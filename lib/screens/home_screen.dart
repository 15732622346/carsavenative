import 'package:flutter/material.dart' hide Badge; // Hide Material Badge
// Removed unused import: flutter_localizations
import 'package:shared_preferences/shared_preferences.dart'; // 本地存储
import '../models/vehicle_model.dart'; // 车辆模型
import '../models/maintenance_component_model.dart'; // 保养组件模型
import '../models/maintenance_record_model.dart'; // 保养记录模型
import 'package:collection/collection.dart'; // 用于 firstWhereOrNull
import 'package:intl/intl.dart'; // For date formatting
// Use alias for the badges package to avoid name collision
import 'package:badges/badges.dart' as badges_pkg;
import 'notifications_screen.dart'; // Import the new screen
import 'package:carsave_app/repositories/local_component_repository.dart';
import 'package:carsave_app/repositories/local_record_repository.dart';
import 'package:carsave_app/repositories/local_vehicle_repository.dart';
import '../main.dart'; // Import main.dart to access the global isar instance
// Removed unused import: maintenance_component_screen.dart
// Removed unused import: vehicle_list_screen.dart
// Removed unused imports: isar, provider

class HomeScreen extends StatefulWidget {
  // Use const constructor and super parameters
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences _prefs; // 本地存储实例

  // --- Repositories (Pass the global Isar instance) ---
  final LocalVehicleRepository _vehicleRepository = LocalVehicleRepository(isar); // Pass isar
  final LocalComponentRepository _componentRepository = LocalComponentRepository(isar);
  final LocalRecordRepository _recordRepository = LocalRecordRepository(isar); // Pass isar

  // --- State Variables ---
  List<Vehicle> _vehicles = [];
  Vehicle? _currentVehicle;
  List<MaintenanceComponent> _reminders = [];
  bool _isLoading = true;
  String? _error;
  bool _isLoadingReminders = false; // Separate loading state for reminders
  List<MaintenanceRecord> _maintenanceRecords = []; // Added for records
  bool _isLoadingRecords = false; // Added loading state for records

  // --- State for derived data ---
  int? _trackedDays;
  DateTime? _lastMaintenanceDate;

  // --- Added for Global Notifications ---
  List<MaintenanceComponent> _allCriticalComponents = []; // Stores all critical components across vehicles
  int _criticalComponentCount = 0; // Count of critical components
  bool _isLoadingGlobalNotifications = false; // Loading state for global notifications
  // --- End Added ---

  static const String _lastSelectedVehicleIdKey = 'last_selected_isar_id';

  @override
  void initState() {
    super.initState();
    // Initialize SharedPreferences and load data directly
    _initializeAndLoadData();
  }

  Future<void> _initializeAndLoadData() async {
     // Initialize SharedPreferences first
    try {
      _prefs = await SharedPreferences.getInstance();
      // Now load the initial data
      await _loadInitialData();
    } catch (e) {
      // Handle potential SharedPreferences init error
      if (mounted) {
         setState(() {
           _isLoading = false;
           _error = "初始化本地存储失败: $e";
         });
      }
      // Use debugPrint instead of print
      debugPrint("Error initializing SharedPreferences: $e");
    }
  }

  // --- Data Loading Logic ---
  Future<void> _loadInitialData() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _isLoadingGlobalNotifications = true;
      _error = null;
      _currentVehicle = null; // Reset current vehicle during full reload
      _vehicles = [];
      _reminders = [];
      _maintenanceRecords = [];
      _trackedDays = null;
      _lastMaintenanceDate = null;
      _allCriticalComponents = [];
      _criticalComponentCount = 0;
    });

    try {
      _vehicles = await _vehicleRepository.getAllVehicles();
      if (!mounted) return;

      if (_vehicles.isEmpty) {
        setState(() { _isLoading = false; _isLoadingGlobalNotifications = false; });
        return;
      }

      // Determine current vehicle after loading all vehicles
      final int? lastSelectedId = _prefs.getInt(_lastSelectedVehicleIdKey);
      if (lastSelectedId != null) {
        _currentVehicle = _vehicles.firstWhereOrNull((v) => v.id == lastSelectedId);
      }
      // Ensure _currentVehicle is set, defaulting to the first if necessary
      _currentVehicle ??= _vehicles.first;
      // Save the potentially updated current vehicle ID
      await _prefs.setInt(_lastSelectedVehicleIdKey, _currentVehicle!.id);

      // Load details specific to the determined current vehicle
      await _loadDetailsForCurrentVehicle();

      // Load global notifications data AFTER vehicle details are potentially available
      List<MaintenanceComponent> criticalComponents = [];
      final List<Future<List<MaintenanceComponent>>> componentFutures = _vehicles
          .map((vehicle) => _componentRepository.getComponentsByVehicleName(vehicle.name))
          .toList();

      final List<List<MaintenanceComponent>> results = await Future.wait(componentFutures);

      if (mounted) {
          for (int i = 0; i < _vehicles.length; i++) {
              final vehicle = _vehicles[i];
              final componentsForVehicle = results[i];
              criticalComponents.addAll(componentsForVehicle.where((component) {
                  final status = component.getStatus(vehicle.mileage.toDouble(), null);
                  // Check for both warning and attention for the badge count
                  return status == MaintenanceStatus.attention || status == MaintenanceStatus.warning;
              }));
          }
          _allCriticalComponents = criticalComponents; // Store all for potential drill-down
          _criticalComponentCount = criticalComponents.length;
      }

    } catch (e, stackTrace) {
      if (mounted) {
        setState(() {
          _error = "加载车辆信息失败: ${e.toString()}";
          _isLoadingGlobalNotifications = false; // Ensure this is reset on error
        });
      }
      debugPrint("Error loading initial data: $e\nStack trace: $stackTrace");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isLoadingGlobalNotifications = false;
        });
      }
    }
  }

  // New function to load both reminders and records for the current vehicle
  Future<void> _loadDetailsForCurrentVehicle() async {
    if (_currentVehicle == null) return;
    if (!mounted) return;

    setState(() {
      _isLoadingReminders = true;
      _isLoadingRecords = true;
      _reminders = [];
      _maintenanceRecords = [];
      _trackedDays = null; // Reset derived data
      _lastMaintenanceDate = null; // Reset derived data
    });

    try {
      final results = await Future.wait([
        _componentRepository.getComponentsByVehicleName(_currentVehicle!.name),
        _recordRepository.getMaintenanceRecords(vehicleName: _currentVehicle!.name),
      ]);

      if (mounted) {
         _reminders = results[0] as List<MaintenanceComponent>;
         _maintenanceRecords = results[1] as List<MaintenanceRecord>; // Already sorted by repo

         // --- DEBUG LOGGING START ---
         debugPrint('[HomeScreen - LoadDetails] Loaded ${_reminders.length} reminders for ${_currentVehicle?.name}:');
         for (var comp in _reminders) {
            if (_currentVehicle != null) {
               final status = comp.getStatus(_currentVehicle!.mileage.toDouble(), null);
               debugPrint('  - ${comp.name}: Status = $status');
            } else {
               debugPrint('  - ${comp.name}: Cannot get status, currentVehicle is null');
            }
         }
         // --- DEBUG LOGGING END ---

         // Calculate derived data
         _lastMaintenanceDate = _maintenanceRecords.isNotEmpty ? _maintenanceRecords.first.maintenanceDate : null;

         if (_maintenanceRecords.isNotEmpty) {
            final earliestRecord = _maintenanceRecords.reduce((a, b) =>
                a.maintenanceDate.isBefore(b.maintenanceDate) ? a : b);
            _trackedDays = DateTime.now().difference(earliestRecord.maintenanceDate).inDays;
         } else {
           _trackedDays = null;
         }
      }

    } catch (e, stackTrace) {
      final errorMsg = "加载 ${_currentVehicle?.name ?? '车辆'} 详情失败: ${e.toString()}";
       if (mounted) {
        setState(() {
          // Append error only if there wasn't a global loading error already
          _error = (_error == null || !_error!.contains("加载车辆信息失败")) ? errorMsg : "$_error\n$errorMsg";
        });
       }
       debugPrint("Error loading vehicle details for ${_currentVehicle?.name}: $e\nStack trace: $stackTrace");
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingReminders = false;
          _isLoadingRecords = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('车辆保养助手'),
        actions: [
          // --- Notifications Badge ---
          if (!_isLoadingGlobalNotifications)
            badges_pkg.Badge(
              showBadge: _criticalComponentCount > 0,
              position: badges_pkg.BadgePosition.topEnd(top: 0, end: 3), // Fine-tune position
              badgeContent: Text(
                  _criticalComponentCount > 99 ? '99+' : _criticalComponentCount.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              badgeStyle: const badges_pkg.BadgeStyle(
                 badgeColor: Colors.red, // Explicitly red
              ),
              child: IconButton(
                icon: const Icon(Icons.notifications_outlined),
                tooltip: '查看所有提醒 (${_criticalComponentCount}项)',
                onPressed: _criticalComponentCount > 0 ? () { // Only enable if count > 0
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationsScreen(
                        // Pass ALL components that are critical across ALL vehicles
                        criticalComponents: _allCriticalComponents,
                        // We need to pass all vehicles as well for context
                        vehicles: _vehicles,
                      ),
                    ),
                  );
                } : null, // Disable button if no notifications
              ),
            )
          else
            const Padding( // Loading indicator for notifications
              padding: EdgeInsets.only(right: 16.0),
              child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)),
            ),
          const SizedBox(width: 8), // Spacing for the action
        ],
      ),
      // Use RefreshIndicator for pull-to-refresh
      body: RefreshIndicator(
        onRefresh: _loadInitialData, // Trigger full reload on refresh
        child: _buildBody(),
      ),
    );
  }

  // --- Body Content Logic ---
  Widget _buildBody() {
    // Handle initial loading state
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Handle error state when loading fails AND there are no vehicles
    if (_error != null && _vehicles.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              const SizedBox(height: 16),
              Text( '加载失败', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text( _error!, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),
              ElevatedButton.icon( icon: const Icon(Icons.refresh), label: const Text('重试'), onPressed: _loadInitialData),
            ],
          ),
        ),
      );
    }

    // Handle state when no vehicles are added yet
    if (_vehicles.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.directions_car_filled_outlined, size: 80, color: Colors.grey),
              const SizedBox(height: 16),
              Text( '暂无车辆信息', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text( '请在"车辆"页面添加您的第一辆车。', // Updated text
                   textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),
              // Consider removing the button here if adding is done on Vehicle screen
              // ElevatedButton.icon(
              //   onPressed: () { /* TODO: Navigate to Add Vehicle Screen if needed */ },
              //   icon: const Icon(Icons.add),
              //   label: const Text('添加车辆'),
              // ),
            ],
          ),
        ),
      );
    }

    // Main content display when vehicles are loaded
    // Use ListView for scrollable content to accommodate different screen sizes
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Display specific error related to loading vehicle details, if any
         if (_error != null && _error!.contains("详情失败"))
           Padding(
             padding: const EdgeInsets.only(bottom: 16.0),
             child: Text( _error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
           ),
        _buildVehicleOverviewSection(),
        const SizedBox(height: 24.0), // Consistent spacing
        _buildVehicleStatusSection(),
        const SizedBox(height: 24.0),
        _buildMaintenanceRemindersSection(),
        const SizedBox(height: 24.0),
        _buildAnnouncementsSection(),
      ],
    );
  }

  // --- Section Builders ---

  // Builds the top section with vehicle name, mileage, tracked time, and switch button
  Widget _buildVehicleOverviewSection() {
    final String trackedDaysString = _trackedDays != null ? '$_trackedDays 天' : '无记录';
    // Format mileage with commas
    final String mileageString = _currentVehicle != null
        ? NumberFormat.decimalPattern('zh_CN').format(_currentVehicle!.mileage)
        : '0';

    return Card(
      elevation: 2.0, // Slightly more prominent
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), // Rounded corners
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start, // Align top
              children: [
                // Flexible title to prevent overflow
                Flexible(
                  child: Text(
                    '车辆概览: ${_currentVehicle?.name ?? 'N/A'}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis, // Handle long names
                  ),
                ),
                // Switch button - consider using an icon button or styling
                TextButton(
                  onPressed: _vehicles.length > 1 ? _showVehicleSelectionDialog : null, // Only enable if >1 vehicle
                  child: Text(_vehicles.length > 1 ? '切换车辆' : '仅一辆车'),
                ),
              ],
            ),
            const SizedBox(height: 12), // Increased spacing
            Text('当前总里程: $mileageString km', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 4),
            Text('已记录时间: $trackedDaysString', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }

  // Builds the status summary section (Last Maintenance, Item Count, Overall Status)
  Widget _buildVehicleStatusSection() {
    final String lastMaintenanceString = _lastMaintenanceDate != null
        ? DateFormat.yMMMd('zh_CN').format(_lastMaintenanceDate!) // Use more descriptive format
        : '无记录';

    // Derive overall status based on critical reminders for the *current* vehicle
    String overallStatus = '状态良好';
    IconData statusIcon = Icons.check_circle_outline;
    Color statusColor = Colors.green; // Good status color

    // --- DEBUG LOGGING START ---
    debugPrint('[HomeScreen - BuildStatus] Checking status for ${_currentVehicle?.name}. Total reminders: ${_reminders.length}');
    // --- DEBUG LOGGING END ---

    bool needsWarning = _reminders.any((r) {
        final status = r.getStatus(_currentVehicle?.mileage.toDouble() ?? 0.0, null);
        // debugPrint('  - [Warning Check] ${r.name}: Status = $status'); // Optional detailed log
        return status == MaintenanceStatus.warning;
      }
    );
    bool needsAttention = _reminders.any((r) {
        final status = r.getStatus(_currentVehicle?.mileage.toDouble() ?? 0.0, null);
        // debugPrint('  - [Attention Check] ${r.name}: Status = $status'); // Optional detailed log
        return status == MaintenanceStatus.attention;
      }
    );

    // --- DEBUG LOGGING START ---
    debugPrint('  Needs Warning: $needsWarning, Needs Attention: $needsAttention');
    // --- DEBUG LOGGING END ---

     if (needsWarning) {
        overallStatus = '需要保养';
        statusIcon = Icons.error_outline; // Use error icon for immediate action needed
        statusColor = Colors.red; // Warning status color
    } else if (needsAttention) {
         overallStatus = '注意保养'; // Attention status text
         statusIcon = Icons.warning_amber_rounded; // Attention icon
         statusColor = Colors.orangeAccent; // Attention status color
    }

    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), // Consistent rounding
      child: Padding(
        // Add horizontal padding as well for better spacing
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Use Flexible to prevent overflow on small screens
            Flexible(child: _buildStatusItem(Icons.event_available_outlined, '上次保养', lastMaintenanceString)),
            Flexible(child: _buildStatusItem(Icons.list_alt_outlined, '保养项目', '${_reminders.length} 项')),
            Flexible(child: _buildStatusItem(statusIcon, '当前状态', overallStatus, iconColor: statusColor)),
          ],
        ),
      ),
    );
  }

  // Helper widget for individual items within the status section
  Widget _buildStatusItem(IconData icon, String label, String value, {Color? iconColor}) {
    final color = iconColor ?? Theme.of(context).colorScheme.primary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 30.0, color: color),
        const SizedBox(height: 8.0),
        Text(label, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center), // Center align label
        const SizedBox(height: 4.0),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center, // Center align value
          overflow: TextOverflow.ellipsis, // Handle long date strings
        ),
      ],
    );
  }

  // Builds the section listing maintenance reminders that need attention
  Widget _buildMaintenanceRemindersSection() {
    // Show loading indicator specifically for reminders
    if (_isLoadingReminders) {
      return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text('保养提醒', style: Theme.of(context).textTheme.titleLarge),
           const SizedBox(height: 8.0),
           const Card(
              elevation: 1.0,
              child: SizedBox(
                width: double.infinity,
                height: 100, // Placeholder height during load
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
             ),
           ),
        ],
      );
    }

    // Filter reminders for the current vehicle that need attention or are overdue
    final List<MaintenanceComponent> criticalReminders = _reminders.where((component) {
      // Ensure _currentVehicle is not null before accessing mileage
      if (_currentVehicle == null) return false;
      final status = component.getStatus(_currentVehicle!.mileage.toDouble(), null);
      // --- DEBUG LOGGING START ---
      // debugPrint('[HomeScreen - FilterReminders] Checking ${component.name}: Status = $status');
      // --- DEBUG LOGGING END ---
      return status == MaintenanceStatus.attention || status == MaintenanceStatus.warning;
    }).toList();

    // --- DEBUG LOGGING START ---
    debugPrint('[HomeScreen - BuildReminders] Filtered critical reminders count: ${criticalReminders.length}');
    // --- DEBUG LOGGING END ---

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('保养提醒', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8.0),
        if (criticalReminders.isEmpty)
          Card(
            elevation: 1.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0), // More padding
              child: const Text(
                '暂无需要关注的保养项目',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          )
        else
          // Build a list of cards for each critical reminder
          Column(
            // Use List.generate for index access if needed, map is fine here
            children: criticalReminders
                .map((component) => _buildReminderItemCard(component)) // Use specific card builder
                .toList(),
          ),
      ],
    );
  }

  // Builds a Card widget for an individual maintenance reminder item
  Widget _buildReminderItemCard(MaintenanceComponent component) {
    // These checks should ideally not fail if logic upstream is correct
    if (_currentVehicle == null) return const SizedBox.shrink();

    final status = component.getStatus(_currentVehicle!.mileage.toDouble(), null);
    final currentMileage = _currentVehicle!.mileage;
    final now = DateTime.now();
    String statusText = '';
    Color statusColor = Colors.grey; // Default color

    // Determine status text and color based on type and remaining value
    if (component.maintenanceType == 'mileage') {
      if (component.targetMaintenanceMileage != null) {
        final remainingMileage = component.targetMaintenanceMileage! - currentMileage;
        final formattedMileage = NumberFormat.decimalPattern('zh_CN').format(remainingMileage.abs());
        if (remainingMileage <= 0) {
          statusText = '已超出: $formattedMileage km';
          statusColor = Colors.red; // Overdue color
        } else {
          statusText = '剩余: $formattedMileage km';
          // Use orange for attention, default green for good (but filtered out earlier)
          statusColor = (status == MaintenanceStatus.attention) ? Colors.orangeAccent : Colors.green;
        }
      } else {
        statusText = '目标里程未设置'; // Error/unknown state text
      }
    } else if (component.maintenanceType == 'date') {
      if (component.targetMaintenanceDate != null) {
        final remainingDays = component.targetMaintenanceDate!.difference(now).inDays;
         if (remainingDays < 0) { // Explicitly check for less than 0
          statusText = '已超出: ${remainingDays.abs()} 天';
          statusColor = Colors.red; // Overdue color
        } else {
          statusText = '剩余: $remainingDays 天';
          // Use orange for attention, default green for good (but filtered out earlier)
           statusColor = (status == MaintenanceStatus.attention) ? Colors.orangeAccent : Colors.green;
        }
      } else {
        statusText = '目标日期未设置'; // Error/unknown state text
      }
    }

    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), // Consistent rounding
      margin: const EdgeInsets.only(bottom: 12.0), // Spacing between cards
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Component Name (Bold)
            Text(
              component.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            // Type and Current Mileage
            Text(
              '类型: ${component.maintenanceType == 'mileage' ? '按里程' : '按时间'}',
              style: Theme.of(context).textTheme.bodyMedium
            ),
            Text(
              '当前里程: ${NumberFormat.decimalPattern('zh_CN').format(currentMileage)} km',
              style: Theme.of(context).textTheme.bodyMedium
             ),
            const SizedBox(height: 4.0),
            // Status Text (Remaining/Overdue) - Colored and Bold
            Text(
              statusText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Builds the static announcements and tips section
  Widget _buildAnnouncementsSection() {
    return Card(
       elevation: 1.0,
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), // Consistent rounding
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0), // Reduce vertical padding slightly
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add padding for the title
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
              child: Text('公告与提示', style: Theme.of(context).textTheme.titleLarge),
            ),
            ListTile(
              leading: Icon(Icons.campaign_outlined, color: Theme.of(context).colorScheme.secondary),
              title: const Text('测试未开放'),
              subtitle: const Text('此功能将在后续版本中提供'), // More informative subtitle
              dense: true, // Make list tiles denser
            ),
            const Divider(height: 1, indent: 16, endIndent: 16), // Add indent to divider
             ListTile(
              leading: Icon(Icons.star_outline, color: Theme.of(context).colorScheme.secondary),
              title: const Text('使用小贴士'),
              subtitle: const Text('定期更新车辆里程可以获得更准确的保养提醒'),
              dense: true,
            ),
          ],
        ),
      ),
    );
  }

  // --- Vehicle Selection Dialog ---
  void _showVehicleSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('选择车辆'),
          // Constrain content size and make it scrollable if many vehicles
          content: SizedBox(
            width: double.maxFinite, // Use available width
            // Use ConstrainedBox to prevent excessive height
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.5),
              child: ListView.builder(
                shrinkWrap: true, // Important for AlertDialog content
                itemCount: _vehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = _vehicles[index];
                  final isSelected = _currentVehicle?.id == vehicle.id;
                  return ListTile(
                    title: Text(vehicle.name),
                    leading: Icon(
                      Icons.directions_car_filled, // Use filled icon
                      color: isSelected
                             ? Theme.of(context).colorScheme.primary
                             : Colors.grey, // Dim non-selected icon
                    ),
                    // Show checkmark for the currently selected vehicle
                    trailing: isSelected
                              ? const Icon(Icons.check_circle, color: Colors.green)
                              : null,
                    onTap: () {
                      if (!isSelected) { // Only process if a different vehicle is selected
                        setState(() { _currentVehicle = vehicle; });
                        // Save selection and reload details
                        _prefs.setInt(_lastSelectedVehicleIdKey, vehicle.id).then((_) {
                           _loadDetailsForCurrentVehicle();
                        });
                      }
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  );
                },
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('关闭'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  // --- NOTE: Old/Unused methods below this point should be removed ---
  // Methods like _buildVehicleSelector, _buildCurrentVehicleDetails, _buildMileageInfo,
  // _buildMaintenanceReminders (old), _buildReminderCard, _getReminderSubtitle,
  // _buildMaintenanceHistory, _buildRecordTile, _showUpdateMileageDialog, _updateVehicleMileage
  // _getIconForStatus, _getColorForStatus etc. are replaced by the new structure above.

} // End of _HomeScreenState
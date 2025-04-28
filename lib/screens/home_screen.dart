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
import 'package:provider/provider.dart'; // 添加Provider导入
import 'notifications_screen.dart'; // Import the new screen
import '../providers/vehicle_list_provider.dart'; // 导入车辆列表Provider
import '../providers/maintenance_provider.dart'; // 导入保养Provider
import '../repositories/local_component_repository.dart';
import '../repositories/local_record_repository.dart';
import '../repositories/local_vehicle_repository.dart';
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

  // --- State Variables ---
  Vehicle? _currentVehicle;
  bool _isLoading = true;
  String? _error;
  
  // --- State for derived data ---
  int? _trackedDays;
  DateTime? _lastMaintenanceDate;

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
      _error = null;
      _currentVehicle = null; // Reset current vehicle during full reload
      _trackedDays = null;
      _lastMaintenanceDate = null;
    });

    try {
      // 使用Provider获取车辆列表
      final vehicleProvider = Provider.of<VehicleListProvider>(context, listen: false);
      await vehicleProvider.loadVehicles();
      final vehicles = vehicleProvider.vehicles;
      
      if (!mounted) return;

      if (vehicles.isEmpty) {
        setState(() { _isLoading = false; });
        return;
      }

      // Determine current vehicle after loading all vehicles
      final int? lastSelectedId = _prefs.getInt(_lastSelectedVehicleIdKey);
      if (lastSelectedId != null) {
        _currentVehicle = vehicles.firstWhereOrNull((v) => v.id == lastSelectedId);
      }
      // Ensure _currentVehicle is set, defaulting to the first if necessary
      _currentVehicle ??= vehicles.first;
      // Save the potentially updated current vehicle ID
      await _prefs.setInt(_lastSelectedVehicleIdKey, _currentVehicle!.id);

      // 使用Provider加载组件和记录
      final maintenanceProvider = Provider.of<MaintenanceProvider>(context, listen: false);
      
      // 加载当前车辆的组件和记录
      if (_currentVehicle != null) {
        await maintenanceProvider.loadComponentsForVehicle(_currentVehicle!.name);
        final records = await maintenanceProvider.loadRecordsForVehicle(_currentVehicle!.name);
        
        // 计算派生数据
        if (records.isNotEmpty) {
          _lastMaintenanceDate = records.first.maintenanceDate;
          
          final earliestRecord = records.reduce((a, b) =>
            a.maintenanceDate.isBefore(b.maintenanceDate) ? a : b);
          _trackedDays = DateTime.now().difference(earliestRecord.maintenanceDate).inDays;
        }
      }
      
      // 加载所有车辆的关键组件
      await maintenanceProvider.loadAllCriticalComponents(vehicles);

    } catch (e, stackTrace) {
      if (mounted) {
        setState(() {
          _error = "加载车辆信息失败: ${e.toString()}";
        });
      }
      debugPrint("Error loading initial data: $e\nStack trace: $stackTrace");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 监听所需的Provider
    final vehicleProvider = Provider.of<VehicleListProvider>(context);
    final maintenanceProvider = Provider.of<MaintenanceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('车辆保养助手'),
        actions: [
          // --- Notifications Badge ---
          if (maintenanceProvider.criticalComponentCount > 0)
            badges_pkg.Badge(
              showBadge: true, 
              position: badges_pkg.BadgePosition.topEnd(top: 0, end: 3), // Fine-tune position
              badgeContent: Text(
                maintenanceProvider.criticalComponentCount > 99 ? '99+' : maintenanceProvider.criticalComponentCount.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              child: IconButton(
                icon: const Icon(Icons.notifications_outlined),
                tooltip: '查看所有提醒 (${maintenanceProvider.criticalComponentCount}项)',
                onPressed: maintenanceProvider.criticalComponentCount > 0 ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationsScreen(
                        // Pass ALL components that are critical across ALL vehicles
                        criticalComponents: maintenanceProvider.allCriticalComponents,
                        // We need to pass all vehicles as well for context
                        vehicles: vehicleProvider.vehicles,
                      ),
                    ),
                  );
                } : null, // Disable if there are no critical items
              ),
            ),
          // --- End Notifications Badge ---
        ],
      ),
      // Show full page loading indicator during initial loading
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildHomeContent(vehicleProvider, maintenanceProvider),
    );
  }

  // --- Content building methods ---
  Widget _buildHomeContent(VehicleListProvider vehicleProvider, MaintenanceProvider maintenanceProvider) {
    // Handle error state when loading fails AND there are no vehicles
    if (_error != null && vehicleProvider.vehicles.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48.0, color: Colors.red),
              const SizedBox(height: 16.0),
              Text(_error!, style: const TextStyle(fontSize: 16.0)),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _loadInitialData,
                child: const Text('重试'),
              ),
            ],
          ),
        ),
      );
    }

    // Handle state when no vehicles are added yet
    if (vehicleProvider.vehicles.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.directions_car_outlined, size: 48.0, color: Colors.blue),
              const SizedBox(height: 16.0),
              const Text('暂无车辆, 请先添加车辆', style: TextStyle(fontSize: 16.0)),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to VehicleListScreen to add a new vehicle
                  Navigator.pushNamed(context, '/vehicle_list');
                },
                child: const Text('添加车辆'),
              ),
            ],
          ),
        ),
      );
    }

    // Main content when everything is loaded successfully
    return RefreshIndicator(
      onRefresh: _loadInitialData, // Pull to refresh
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vehicle Overview Card - with vehicle selection
            Card(
              elevation: 1.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '车辆概览: ${_currentVehicle?.name ?? '未选择车辆'}', // Show vehicle name if loaded
                            style: Theme.of(context).textTheme.titleLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Switch button - consider using an icon button or styling
                        TextButton(
                          onPressed: vehicleProvider.vehicles.length > 1 ? _showVehicleSelectionDialog : null, // Only enable if >1 vehicle
                          child: Text(vehicleProvider.vehicles.length > 1 ? '切换车辆' : '仅一辆车'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text('当前里程: ${NumberFormat.decimalPattern('zh_CN').format(_currentVehicle?.mileage ?? 0)} km'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            _buildVehicleStatusCard(maintenanceProvider),
            const SizedBox(height: 16.0),

            // Maintenance Reminders Section
            _buildMaintenanceRemindersSection(maintenanceProvider),
            const SizedBox(height: 16.0),

            // Announcements
            _buildAnnouncementsSection(),
          ],
        ),
      ),
    );
  }

  // --- Helper methods for building specific sections ---
  Widget _buildVehicleStatusCard(MaintenanceProvider maintenanceProvider) {
    // Default status values
    String lastMaintenanceString = '无记录';
    IconData statusIcon = Icons.check_circle_outline;
    String overallStatus = '良好';
    Color statusColor = Colors.green;

    // --- Calculate last maintenance date string ---
    if (_lastMaintenanceDate != null) {
      // Format date as YYYY-MM-DD
      lastMaintenanceString = DateFormat('yyyy-MM-dd').format(_lastMaintenanceDate!);
    }

    // --- DEBUG LOGGING START ---
    debugPrint('[HomeScreen - BuildStatus] Checking status for ${_currentVehicle?.name}. Total reminders: ${maintenanceProvider.getComponentsForVehicle(_currentVehicle?.name ?? "").length}');
    // --- DEBUG LOGGING END ---

    // 使用Provider获取组件
    final components = _currentVehicle != null 
        ? maintenanceProvider.getComponentsForVehicle(_currentVehicle!.name)
        : <MaintenanceComponent>[];
        
    bool needsWarning = components.any((r) {
        final status = r.getStatus(_currentVehicle?.mileage.toDouble() ?? 0.0, null);
        // debugPrint('  - [Warning Check] ${r.name}: Status = $status'); // Optional detailed log
        return status == MaintenanceStatus.warning;
      }
    );
    
    bool needsAttention = components.any((r) {
        final status = r.getStatus(_currentVehicle?.mileage.toDouble() ?? 0.0, null);
        // debugPrint('  - [Attention Check] ${r.name}: Status = $status'); // Optional detailed log
        return status == MaintenanceStatus.attention;
      }
    );

    if (needsWarning) {
      statusIcon = Icons.error_outline;
      overallStatus = '需要保养';
      statusColor = Colors.red;
    } else if (needsAttention) {
      statusIcon = Icons.warning_amber_outlined;
      overallStatus = '注意保养';
      statusColor = Colors.orange;
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
            Flexible(child: _buildStatusItem(Icons.list_alt_outlined, '保养项目', '${components.length} 项')),
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
  Widget _buildMaintenanceRemindersSection(MaintenanceProvider maintenanceProvider) {
    // Show loading indicator specifically for reminders
    if (maintenanceProvider.isLoadingReminders) {
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

    // 获取当前车辆的组件
    final components = _currentVehicle != null 
        ? maintenanceProvider.getComponentsForVehicle(_currentVehicle!.name)
        : <MaintenanceComponent>[];
        
    // Filter reminders for the current vehicle that need attention or are overdue
    final List<MaintenanceComponent> criticalReminders = components.where((component) {
      // Ensure _currentVehicle is not null before accessing mileage
      if (_currentVehicle == null) return false;
      final status = component.getStatus(_currentVehicle!.mileage.toDouble(), null);
      return status == MaintenanceStatus.attention || status == MaintenanceStatus.warning;
    }).toList();

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
    final vehicleProvider = Provider.of<VehicleListProvider>(context, listen: false);
    final maintenanceProvider = Provider.of<MaintenanceProvider>(context, listen: false);
    
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
                itemCount: vehicleProvider.vehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = vehicleProvider.vehicles[index];
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
                            ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary)
                            : null,
                    selected: isSelected,
                    selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1), // Light highlight
                    onTap: () {
                      Navigator.pop(context); // Close dialog
                      if (!isSelected) { // Only update if selection changed
                        setState(() => _currentVehicle = vehicle); // Update selection in memory
                        // Save selection and reload details
                        _prefs.setInt(_lastSelectedVehicleIdKey, vehicle.id).then((_) {
                          // 重新加载当前车辆的数据
                          maintenanceProvider.loadComponentsForVehicle(vehicle.name);
                          maintenanceProvider.loadRecordsForVehicle(vehicle.name);
                        });
                      }
                    },
                  );
                },
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('取消'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
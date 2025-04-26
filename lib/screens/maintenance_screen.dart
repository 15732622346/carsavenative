import 'package:flutter/material.dart';
import 'package:collection/collection.dart'; // Import for firstWhereOrNull
import '../main.dart'; // Import for global isar instance
import '../models/vehicle_model.dart';
import '../models/maintenance_component_model.dart';
import '../repositories/local_vehicle_repository.dart';
import '../repositories/local_maintenance_repository.dart'; // Import the new repository
import '../widgets/maintenance_progress_painter.dart'; // Import the painter
import 'package:intl/intl.dart'; // Import for date formatting in painter
import 'dart:ui' as ui; // Import for painter
import 'dart:math' as math; // Import for painter
import '../models/maintenance_record_model.dart'; // Import record model
// import 'edit_component_screen.dart'; // REMOVE: Delete this import as the file no longer exists
import 'package:visibility_detector/visibility_detector.dart'; // Import visibility_detector

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({Key? key}) : super(key: key);

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  // Repository instances
  late final LocalVehicleRepository _vehicleRepository;
  late final LocalMaintenanceRepository _maintenanceRepository; // Add maintenance repo

  // State variables
  List<Vehicle> _vehicles = [];
  List<MaintenanceComponent> _components = [];
  List<MaintenanceRecord> _maintenanceRecords = []; // State for records
  String? _selectedVehicleName; // null means "全部车辆"
  bool _isLoadingVehicles = true;
  bool _isLoadingComponents = true;
  bool _isLoadingRecords = true; // Loading state for records
  String? _error;

  @override
  void initState() {
    super.initState();
    // Initialize repositories using the global isar instance
    _vehicleRepository = LocalVehicleRepository(isar);
    _maintenanceRepository = LocalMaintenanceRepository(isar); // Initialize maintenance repo
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() {
      _isLoadingVehicles = true;
      _isLoadingComponents = true;
      _isLoadingRecords = true; // Start loading records too
      _error = null;
    });
    try {
      // Load vehicles first for the filter chips
      _vehicles = await _vehicleRepository.getAllVehicles();
      if (!mounted) return;
      setState(() {
        _isLoadingVehicles = false;
      });
      // Then load components (initially all)
      await _loadComponentsAndRecords();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = "初始化加载失败: ${e.toString()}";
        _isLoadingVehicles = false;
        _isLoadingComponents = false;
        _isLoadingRecords = false;
      });
    }
  }

  // Method to load components AND records based on the selected vehicle filter
  Future<void> _loadComponentsAndRecords() async {
     if (!mounted) return;
     setState(() {
       _isLoadingComponents = true;
       _isLoadingRecords = true; // Start loading records too
       _error = null; // Clear previous errors
     });
     try {
       // Load components
       if (_selectedVehicleName == null) {
         _components = await _maintenanceRepository.getAllComponents();
       } else {
         _components = await _maintenanceRepository.getComponentsByVehicle(_selectedVehicleName!);
       }
       if (!mounted) return; // Check mount status after component load
       setState(() { _isLoadingComponents = false; });

       // Load records based on the same filter
       _maintenanceRecords = await _maintenanceRepository.getMaintenanceRecords(vehicleName: _selectedVehicleName);
       if (!mounted) return; // Check mount status after record load
       print('>>> Loaded ${_maintenanceRecords.length} records for vehicle: $_selectedVehicleName. Record IDs: ${_maintenanceRecords.map((r) => r.isarId).toList()}'); // Log IDs instead
       setState(() { _isLoadingRecords = false; });

     } catch (e) {
       if (!mounted) return;
       setState(() {
         _error = "加载数据失败: ${e.toString()}";
         _isLoadingComponents = false;
         _isLoadingRecords = false;
       });
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('保养组件'),
        // Potentially add actions later (e.g., refresh)
        /* // REMOVE Refresh Button
        actions: [ 
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '刷新',
            onPressed: _loadInitialData, // Call load initial data on press
          ),
        ],
        */
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        heroTag: 'maintenance_fab', // Add a unique heroTag
        onPressed: () {
          _showAddComponentDialog(); // Call the dialog function
          /* // Old navigation code - REMOVE
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddComponentScreen()), // Use AddComponentScreen
          ).then((result) { // Check result after screen pops
            // Refresh components list if the add screen indicated success (returned true)
            if (result == true) {
              _loadComponentsAndRecords();
            }
          });
          */
        },
        backgroundColor: Colors.blueAccent, // Or theme color
        child: const Icon(Icons.add),
      ),
    );
  }

  // Build the main content (Filter Chips + Component List)
  // Wrap with VisibilityDetector
  Widget _buildBody() {
    // Use VisibilityDetector to trigger refresh when the screen becomes visible
    return VisibilityDetector(
      key: const ValueKey('maintenance_screen_visibility'), // Unique key
      onVisibilityChanged: (visibilityInfo) {
        // Check if the widget is fully visible
        if (visibilityInfo.visibleFraction == 1.0 && mounted) {
          print("MaintenanceScreen became visible, reloading data..."); // Add log
          _loadInitialData(); // Reload data when fully visible
        }
      },
      child: _buildContent(), // Extracted original body content
    );
  }

  // Extracted original content of _buildBody to avoid nesting VisibilityDetector issues
  Widget _buildContent() { 
    if (_isLoadingVehicles) { // Show loading indicator while vehicles load
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null && _vehicles.isEmpty) { // Show error if initial vehicle load failed
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Icon(Icons.error_outline, color: Colors.red, size: 60),
               const SizedBox(height: 16),
               Text('加载失败: $_error', textAlign: TextAlign.center),
               const SizedBox(height: 16),
               ElevatedButton(
                 onPressed: _loadInitialData, 
                 child: const Text('重试'),
               )
             ]
          ),
        ),
      );
    }

    // Build the main content (Filter Chips + Component List)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildVehicleFilterChips(),
        Expanded(
          child: _buildComponentList(),
        ),
      ],
    );
  }

  // Widget to build the filter chips
  Widget _buildVehicleFilterChips() {
    // Use a list for chips, starting with "全部车辆"
    List<Widget> chips = [
      ChoiceChip(
        label: const Text('全部车辆'),
        selected: _selectedVehicleName == null,
        onSelected: (selected) {
          if (selected) {
            setState(() {
              _selectedVehicleName = null;
            });
            _loadComponentsAndRecords(); // Reload components and records for all vehicles
          }
        },
        selectedColor: Theme.of(context).colorScheme.primaryContainer,
      ),
    ];

    // Add chips for each vehicle
    chips.addAll(_vehicles.map((vehicle) {
      return ChoiceChip(
        label: Text(vehicle.name),
        selected: _selectedVehicleName == vehicle.name,
        onSelected: (selected) {
          if (selected) {
            setState(() {
              _selectedVehicleName = vehicle.name;
            });
            _loadComponentsAndRecords(); // Reload components and records for the selected vehicle
          }
        },
         selectedColor: Theme.of(context).colorScheme.primaryContainer,
      );
    }));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Wrap(
        spacing: 8.0, // Horizontal space between chips
        runSpacing: 4.0, // Vertical space between lines
        children: chips,
      ),
    );
  }

  // Widget to build the list of components or empty state
  Widget _buildComponentList() {
    // Show loading indicator if either components or records are loading initially
    if (_isLoadingComponents || _isLoadingRecords) { 
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) { // Show error specific to component/record loading
       return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Icon(Icons.error_outline, color: Colors.red, size: 60),
               const SizedBox(height: 16),
               Text('加载失败: $_error', textAlign: TextAlign.center),
               const SizedBox(height: 16),
               ElevatedButton(
                 onPressed: _loadComponentsAndRecords, // Retry loading components and records
                 child: const Text('重试'),
               )
             ]
          ),
        ),
      );
    }

    if (_components.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            '暂无保养组件。\n点击右下角 "+" 添加一个吧！',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        )
      );
    }

    // Build the actual list using ListView.builder
    // Item count is components + 1 for the ExpansionTile
    return RefreshIndicator(
      onRefresh: _loadComponentsAndRecords, // Refresh both components and records
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 80), // Padding for FAB
        itemCount: _components.length + 1, // Add 1 for the records tile
        itemBuilder: (context, index) {
          if (index < _components.length) {
            // Build component card
            final component = _components[index];
            final vehicle = _vehicles.firstWhereOrNull((v) => v.name == component.vehicle);
            return _buildComponentCard(component, vehicle);
          } else {
            // Build the ExpansionTile for maintenance records
            return _buildMaintenanceRecordsTile();
          }
        },
      ),
    );
  }

  // Placeholder for the component card widget
  Widget _buildComponentCard(MaintenanceComponent component, Vehicle? vehicle) {
    // Determine Status and Color (Logic copied from carsave_app)
    String statusText;
    Color statusColor;
    double remainingValue = double.infinity;
    bool isWarning = false;
    bool isAttention = false;
    bool isMileageType = component.maintenanceType == 'mileage';
    double currentMileage = vehicle?.mileage.toDouble() ?? -1.0; // Use -1 if vehicle is null

    DateTime now = DateTime.now();
    DateTime startOfToday = DateTime(now.year, now.month, now.day);

    if (currentMileage < 0 && isMileageType) {
      // Cannot determine status if mileage based and vehicle data is missing
      statusText = '状态未知';
      statusColor = Colors.grey;
    } else {
      if (isMileageType) {
        if (component.targetMaintenanceMileage != null && component.targetMaintenanceMileage! > 0) {
          remainingValue = component.targetMaintenanceMileage! - currentMileage;
          if (remainingValue <= 0) {
            isWarning = true;
          } else if (remainingValue <= MaintenanceProgressPainter.mileageAttentionThreshold) {
            isAttention = true;
          }
        } else {
          // Cannot determine status without a valid target mileage
          remainingValue = double.infinity;
        }
      } else { // Date Type
        if (component.targetMaintenanceDate != null) {
          // Compare target date with the START of today
          remainingValue = component.targetMaintenanceDate!.difference(startOfToday).inDays.toDouble();
          if (remainingValue < 0) { // Target date is before today
            isWarning = true;
          } else if (remainingValue <= MaintenanceProgressPainter.dateAttentionThreshold) {
            isAttention = true;
          }
        } else {
          // Cannot determine status without a target date
          remainingValue = double.infinity;
        }
      }

      // Assign status text and color based on flags
      if (isWarning) {
        statusText = '需要保养';
        statusColor = Colors.red;
      } else if (isAttention) {
        statusText = '注意观察';
        statusColor = Colors.orange; // Use orange for attention
      } else if (remainingValue == double.infinity) {
         statusText = '状态未知'; // If target is missing
         statusColor = Colors.grey;
      } else {
        statusText = '状态良好';
        statusColor = Colors.green; // Use green for good
      }
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Top Row (Name and Status Chip) ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    component.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis, // Handle long names
                  ),
                ),
                const SizedBox(width: 8), // Add spacing
                Chip(
                  label: Text(
                    statusText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  backgroundColor: statusColor,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce chip padding
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '车辆: ${component.vehicle}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),

            // --- CustomPaint Progress Area ---
            SizedBox(
              height: 60, // Height for painter area
              width: double.infinity,
              child: CustomPaint(
                painter: MaintenanceProgressPainter(
                  component: component,
                  isMileageType: isMileageType,
                  // Pass relevant value based on type:
                  currentValue: isMileageType 
                                ? currentMileage // Pass actual vehicle mileage for mileage type
                                : startOfToday.difference(component.lastMaintenance ?? startOfToday).inDays.toDouble(), // Pass days passed for date type
                  vehicleCurrentMileage: currentMileage, // Pass actual vehicle mileage regardless of type
                  targetValue: component.targetMaintenanceMileage,
                  cycleValue: component.maintenanceValue,
                  unit: component.unit,
                  statusColor: statusColor,
                  targetDate: component.targetMaintenanceDate,
                  lastMaintenanceDate: component.lastMaintenance, // Pass last date
                ),
              ),
            ),
            // --- End CustomPaint Progress Area ---

            const SizedBox(height: 12), // Space before buttons
            const Divider(),
            const SizedBox(height: 4),
            // --- Action Buttons Row ---
            Row(
              mainAxisAlignment: MainAxisAlignment.start, // Align buttons to the left
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.check_circle_outline, size: 18),
                  label: const Text('保养'),
                  onPressed: (currentMileage < 0 && isMileageType) ? null : () {
                     // TODO: Implement _handleMaintainAction
                     _handleMaintainAction(component, currentMileage);
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    // Ensure text color is appropriate
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: const Text('编辑'),
                  onPressed: () {
                     // TODO: Implement _handleEditAction (e.g., navigate to Edit Screen)
                     _handleEditAction(component);
                  },
                   style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    foregroundColor: Theme.of(context).textTheme.bodyLarge?.color, // Default text color
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  icon: Icon(Icons.delete_outline, size: 18, color: Theme.of(context).colorScheme.error),
                  label: Text('删除', style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  onPressed: () {
                     // TODO: Implement _handleDeleteAction
                     _handleDeleteAction(component);
                  },
                   style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    // Foreground color is set on the Text widget
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Widget to build the ExpansionTile for maintenance records
  Widget _buildMaintenanceRecordsTile() {
    // Use a key to maintain state if needed, especially if list rebuilds often
    // final GlobalKey expansionTileKey = GlobalKey(); 
    print('>>> Building Records Tile. Record count in state: ${_maintenanceRecords.length}'); // Log during build
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16, top: 8), // Add some top margin
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        // key: expansionTileKey, // Assign key if state preservation needed
        title: Text(
          '保养记录 (${_maintenanceRecords.length})',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const Icon(Icons.history),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        children: _isLoadingRecords
            ? [const Center(child: Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator()))] // Show loader inside if records are still loading separately
            : _maintenanceRecords.isEmpty
                ? [const ListTile(title: Center(child: Text('暂无保养记录', style: TextStyle(color: Colors.grey))))]
                : _maintenanceRecords.map((record) {
                    return ListTile(
                      dense: true, // Make tiles more compact
                      leading: const Icon(Icons.build_circle_outlined, size: 20),
                      title: Text('${record.componentName} - ${record.formattedDate}'),
                      subtitle: Text(
                        '车辆: ${record.vehicleName}' +
                        (record.mileageAtMaintenance != null ? ' | 里程: ${record.mileageAtMaintenance?.toStringAsFixed(0)}km' : '') +
                        (record.notes != null && record.notes!.isNotEmpty ? ' | 备注: ${record.notes}' : ''),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Optional: Add trailing icons or actions for records?
                    );
                  }).toList(),
      ),
    );
  }

  // --- Action Handlers ---

  Future<void> _handleMaintainAction(MaintenanceComponent component, double currentMileage) async {
     final maintenanceDate = DateTime.now(); // Record maintenance time

    // --- First Dialog: Confirm Maintenance ---
    final bool? confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('确认保养'),
          content: Text('您确认已经完成了 "${component.name}" 的保养吗？'),
          actions: <Widget>[
            TextButton(
              child: const Text('取消'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text('确认'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    // --- Show Loading Indicator (Placeholder) ---
    // Consider adding a visual loading state for the specific card
    // setState(() { _isProcessingMaintenance = true; });

    bool recordSaved = false;
    try {
      // --- 1. Save Maintenance Record ---
      final newRecord = MaintenanceRecord(
        vehicleName: component.vehicle,
        componentId: component.isarId.toString(), // Assuming componentId is string for now
        componentName: component.name,
        maintenanceDate: maintenanceDate,
        mileageAtMaintenance: component.maintenanceType == 'mileage' ? currentMileage : null,
        notes: '通过APP标记保养完成',
      );
      await _maintenanceRepository.addMaintenanceRecord(newRecord);
      recordSaved = true;
      print('>>> Maintenance record saved (or attempted). Record ID (after potential save): ${newRecord.isarId}, Component: ${newRecord.componentName}'); // Log basic info

      // --- 2. Ask about next cycle --- 
      final bool? recalculate = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('保养完成'),
            content: const Text('是否自动设置下一个保养周期?'),
            actions: <Widget>[
              TextButton(
                child: const Text('否 (将移除此项目)'), // Clarify consequence
                onPressed: () => Navigator.of(context).pop(false), 
              ),
              TextButton(
                child: const Text('是'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
        },
      );

      final bool shouldRecalculate = recalculate ?? true; // Default to true if somehow null

      if (shouldRecalculate) {
          // --- 3a. Update Component Target ---
          await _maintenanceRepository.recordMaintenanceAndUpdateTarget(
            component, 
            currentMileage: currentMileage, 
            maintenanceDate: maintenanceDate,
            recalculateNextTarget: true
          );
          if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('保养记录成功，已设置下次提醒')),
              );
          }
      } else {
          // --- 3b. Delete Component (User chose not to set next cycle) ---
          await _maintenanceRepository.deleteComponent(component.isarId);
          if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('组件 "${component.name}" 已删除')),
              );
          }
      }

      // --- 4. Refresh List --- 
      _loadComponentsAndRecords(); // Refresh regardless of path

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('处理保养操作时出错: ${e.toString()}')),
        );
        // Optional: Handle partial failure (e.g., record saved but update failed)
        // if (recordSaved) { ... }
      }
    } finally {
       // --- Hide Loading Indicator ---
       // setState(() { _isProcessingMaintenance = false; });
    }

  }

  // --- Show Edit Component Dialog ---
  Future<void> _showEditComponentDialog(MaintenanceComponent componentToEdit) async {
    final GlobalKey<FormState> dialogFormKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController(text: componentToEdit.name);
    final TextEditingController periodController = TextEditingController(text: componentToEdit.maintenanceValue.toStringAsFixed(0));
    String selectedMaintenanceType = componentToEdit.maintenanceType;
    bool isSaving = false;
    final List<String> maintenanceTypes = ['mileage', 'date'];

    // Ensure the type is valid
    if (!maintenanceTypes.contains(selectedMaintenanceType)) {
      selectedMaintenanceType = maintenanceTypes.first;
    }

    String getUnit() {
      return selectedMaintenanceType == 'mileage' ? '公里' : '天';
    }

    Future<void> saveEditedComponent() async {
      if (!dialogFormKey.currentState!.validate()) {
        return;
      }

      // No need to set state for isSaving in the main screen state
      // StatefulBuilder handles dialog state

      try {
        final updatedComponentData = componentToEdit.copyWith(
          name: nameController.text.trim(),
          maintenanceType: selectedMaintenanceType,
          maintenanceValue: double.tryParse(periodController.text) ?? 0.0,
          unit: selectedMaintenanceType == 'mileage' ? 'km' : 'days',
        );
        final componentToSave = updatedComponentData..isarId = componentToEdit.isarId;

        await _maintenanceRepository.updateComponent(componentToSave);

        if (mounted) {
          Navigator.pop(context, true); // Close dialog and signal success
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('保养项目已更新')),
          );
        }
      } catch (e) {
        if (mounted) {
          // Show error INSIDE the dialog? Or pop and show outside?
          // Showing outside is simpler for now.
          Navigator.pop(context, false); // Close dialog on error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('更新失败: ${e.toString()}')),
          );
        }
      } 
      // No finally block needed here as loading state is managed by StatefulBuilder
    }

    // Show the dialog
    final bool? updated = await showDialog<bool>(
      context: context,
      barrierDismissible: !isSaving, // Prevent dismissal while saving
      builder: (BuildContext context) {
        // Use StatefulBuilder to manage state *within* the dialog
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('编辑 "${componentToEdit.name}"'),
              content: SingleChildScrollView(
                child: Form(
                  key: dialogFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Vehicle Display (Read-only)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          '车辆: ${componentToEdit.vehicle}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[700]),
                        ),
                      ),
                      // Component Name
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: '项目名称',
                          prefixIcon: Icon(Icons.label_outline),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '请输入项目名称';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Maintenance Type
                      DropdownButtonFormField<String>(
                        value: selectedMaintenanceType,
                        decoration: const InputDecoration(
                          labelText: '保养方式',
                          prefixIcon: Icon(Icons.schedule),
                        ),
                        items: maintenanceTypes.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value == 'mileage' ? '按里程' : '按日期'),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            // Use setDialogState to update dialog's internal state
                            setDialogState(() {
                              selectedMaintenanceType = newValue;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      // Maintenance Period/Cycle Value
                      TextFormField(
                        controller: periodController,
                        decoration: InputDecoration(
                          labelText: '保养周期 (${getUnit()})',
                          hintText: '输入保养间隔值',
                          prefixIcon: Icon(Icons.repeat),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '请输入保养周期值';
                          }
                          final number = int.tryParse(value);
                          if (number == null || number <= 0) {
                            return '请输入一个有效的正整数';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: isSaving ? null : () => Navigator.pop(context, false),
                  child: const Text('取消'),
                ),
                ElevatedButton(
                  onPressed: isSaving ? null : () async {
                      setDialogState(() => isSaving = true);
                      await saveEditedComponent();
                      // Check if still mounted before resetting state
                      if (context.mounted) { 
                          setDialogState(() => isSaving = false);
                      }
                  },
                  child: isSaving ? const SizedBox(height: 15, width: 15, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('保存'),
                ),
              ],
            );
          },
        );
      },
    );

    // If the dialog was popped with true (meaning success), refresh the list
    if (updated == true && mounted) {
      _loadComponentsAndRecords();
    }
  }

  Future<void> _handleEditAction(MaintenanceComponent component) async {
    // Show the edit dialog instead
    await _showEditComponentDialog(component);
    // Refresh logic is now handled within _showEditComponentDialog after successful save
  }

  Future<void> _handleDeleteAction(MaintenanceComponent component) async {
    // Show confirmation dialog
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('您确定要删除保养项目 "${component.name}" 吗？此操作不可撤销。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('删除', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        // Use the repository method directly, passing the int ID
        await _maintenanceRepository.deleteComponent(component.isarId);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('保养项目 "${component.name}" 已删除')),
          );
          _loadComponentsAndRecords(); // Refresh the list
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('删除失败: ${e.toString()}')),
          );
        }
      }
    }
  }

  // --- Show Add Component Dialog --- 
  Future<void> _showAddComponentDialog() async {
    // Controllers and state specific to the dialog form
    final GlobalKey<FormState> dialogFormKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController periodController = TextEditingController();
    Vehicle? selectedVehicle = _vehicles.isNotEmpty ? _vehicles.first : null;
    String selectedMaintenanceType = 'mileage';
    bool isSaving = false;

    // Pre-check: Ensure there are vehicles to add components to
    if (_vehicles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请先添加车辆，然后才能添加保养项目。')),
      );
      return;
    }

    final bool? added = await showDialog<bool>(
      context: context,
      barrierDismissible: !isSaving, // Prevent dismissal while saving
      builder: (BuildContext context) {
        // Use StatefulBuilder to manage state within the dialog
        return StatefulBuilder(
          builder: (context, setDialogState) {
            
            // Define maintenance types list here for dialog scope
            final List<String> _maintenanceTypes = ['mileage', 'date'];

            String getUnit() {
              return selectedMaintenanceType == 'mileage' ? '公里' : '天';
            }

            Future<void> saveComponent() async {
              if (selectedVehicle == null) {
                // This check might be redundant if validation is good
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('请选择车辆')),
                );
                return;
              }
              if (!dialogFormKey.currentState!.validate()) {
                return;
              }

              setDialogState(() { isSaving = true; });

              try {
                final maintenanceValue = double.tryParse(periodController.text) ?? 0.0;
                final now = DateTime.now();
                final currentMileage = selectedVehicle!.mileage.toDouble();

                double? targetMileage;
                DateTime? targetDate;
                if (selectedMaintenanceType == 'mileage') {
                  targetMileage = currentMileage + maintenanceValue;
                } else {
                  targetDate = now.add(Duration(days: maintenanceValue.toInt()));
                }

                final newComponent = MaintenanceComponent(
                  name: nameController.text.trim(),
                  vehicle: selectedVehicle!.name,
                  maintenanceType: selectedMaintenanceType,
                  maintenanceValue: maintenanceValue,
                  unit: selectedMaintenanceType == 'mileage' ? 'km' : 'days',
                  targetMaintenanceMileage: targetMileage,
                  targetMaintenanceDate: targetDate,
                  lastMaintenance: now, // Assume first add sets last maint to now
                );

                await _maintenanceRepository.addComponent(newComponent);

                if (mounted) {
                   Navigator.pop(context, true); // Close dialog and signal success
                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text('"${newComponent.name}" 已添加')),
                   );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('添加失败: ${e.toString()}')),
                  );
                }
                 // Don't pop dialog on error, let user retry or cancel
              } finally {
                 // Check mount status *within* the dialog state
                 setDialogState(() { isSaving = false; });
              }
            }

            return AlertDialog(
              title: const Text('添加保养组件'),
              content: SingleChildScrollView(
                child: Form(
                  key: dialogFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Vehicle Selector
                      DropdownButtonFormField<Vehicle>(
                        value: selectedVehicle,
                        decoration: const InputDecoration(
                          labelText: '选择车辆',
                          prefixIcon: Icon(Icons.directions_car_outlined),
                          // Consider removing border or using UnderlineInputBorder for dialogs
                        ),
                        items: _vehicles.map((Vehicle vehicle) {
                          return DropdownMenuItem<Vehicle>(
                            value: vehicle,
                            child: Text(vehicle.name),
                          );
                        }).toList(),
                        onChanged: (Vehicle? newValue) {
                          setDialogState(() {
                            selectedVehicle = newValue;
                          });
                        },
                        validator: (value) => value == null ? '请选择车辆' : null,
                      ),
                      const SizedBox(height: 16),
                      // Component Name
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: '组件名称', // Changed label
                          hintText: '例如：更换机油、检查轮胎',
                           prefixIcon: Icon(Icons.label_outline),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '请输入组件名称';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Maintenance Type
                      DropdownButtonFormField<String>(
                        value: selectedMaintenanceType,
                        decoration: const InputDecoration(
                          labelText: '保养方式',
                           prefixIcon: Icon(Icons.schedule),
                        ),
                        items: _maintenanceTypes.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value == 'mileage' ? '按里程' : '按日期'),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setDialogState(() {
                              selectedMaintenanceType = newValue;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      // Maintenance Period/Cycle Value
                      TextFormField(
                        controller: periodController,
                        decoration: InputDecoration(
                          labelText: '保养周期 (${getUnit()})',
                          hintText: '输入保养间隔值',
                           prefixIcon: Icon(Icons.repeat),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '请输入保养周期值';
                          }
                          final number = int.tryParse(value);
                          if (number == null || number <= 0) {
                            return '请输入一个有效的正整数';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: isSaving ? null : () => Navigator.pop(context, false), // Pass false on cancel
                  child: const Text('取消'),
                ),
                ElevatedButton(
                  onPressed: isSaving ? null : saveComponent, // Call save function
                  child: isSaving ? const SizedBox(height: 15, width: 15, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('添加'),
                ),
              ],
            );
          },
        );
      },
    );

    // If the dialog was popped with true (meaning success), refresh the list
    if (added == true && mounted) {
      _loadComponentsAndRecords();
    }
  }
} 
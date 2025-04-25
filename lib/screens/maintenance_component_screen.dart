import 'package:flutter/material.dart';
import 'package:collection/collection.dart'; // <-- Import collection package
import 'dart:math' as math; // Import math for calculations if needed
import 'package:provider/provider.dart'; // Import Provider
import 'package:isar/isar.dart'; // Import Isar Id
import '../models/maintenance_component_model.dart'; // 导入组件模型
import '../models/vehicle_model.dart'; // 导入车辆模型
import '../models/maintenance_record_model.dart'; // <--- ADD Import for Record Model
import '../repositories/local_vehicle_repository.dart'; // Import Repos
import '../repositories/local_component_repository.dart';
import '../repositories/local_record_repository.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'dart:ui' as ui; // <-- CHANGE IMPORT TO USE PREFIX 'ui'

class MaintenanceComponentScreen extends StatefulWidget {
  const MaintenanceComponentScreen({Key? key}) : super(key: key);

  @override
  State<MaintenanceComponentScreen> createState() => _MaintenanceComponentScreenState();
}

class _MaintenanceComponentScreenState extends State<MaintenanceComponentScreen> {
  // Access repositories using Provider
  late LocalVehicleRepository _vehicleRepository;
  late LocalComponentRepository _componentRepository;
  late LocalRecordRepository _recordRepository;

  // State for selected vehicle and vehicle list loading
  List<Vehicle> _vehicles = [];
  Vehicle? _selectedVehicle; 
  bool _isLoadingVehicles = true;
  String? _vehicleLoadError;

  // --- ADD State variables for component/record loading ---
  List<MaintenanceComponent> _components = [];
  Map<String, MaintenanceRecord> _maintenanceRecords = {}; // Key: componentId (String), Value: Latest Record
  bool _isLoadingComponents = false; // Start as false, only true when loading for selected vehicle
  bool _isLoadingRecords = false;  // Start as false
  String? _loadError; 
  // --- END State variables ---

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) { 
          _vehicleRepository = Provider.of<LocalVehicleRepository>(context, listen: false);
          _componentRepository = Provider.of<LocalComponentRepository>(context, listen: false);
          _recordRepository = Provider.of<LocalRecordRepository>(context, listen: false);
          _loadVehiclesForFilter().then((_) { 
             if (mounted && _selectedVehicle != null) {
               _loadDataForSelectedVehicle();
             }
          });
        }
    });
  }

  // Load vehicles for the filter dropdown using the repository
  Future<void> _loadVehiclesForFilter() async {
    if (!mounted) return;
    setState(() {
      _isLoadingVehicles = true;
      _vehicleLoadError = null;
    });
    try {
      _vehicles = await _vehicleRepository.getAllVehicles(); // Use repo
          if (mounted) {
        // Optionally set a default selected vehicle (e.g., the first one)
        // Only set default if _selectedVehicle is currently null
        if (_vehicles.isNotEmpty && _selectedVehicle == null) {
            _selectedVehicle = _vehicles.first;
        }
      } 
    } catch (e) {
      if (mounted) {
        _vehicleLoadError = "加载车辆列表失败: ${e.toString()}";
         print(_vehicleLoadError); // Log error for debugging
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingVehicles = false;
        });
      }
    }
  }

  // Load components and records for the currently selected vehicle
  Future<void> _loadDataForSelectedVehicle() async {
    if (!mounted) return;
      if (_selectedVehicle == null) {
        setState(() {
        _components = [];
        _maintenanceRecords = {};
        _loadError = null;
          _isLoadingComponents = false;
        _isLoadingRecords = false;
      });
      return;
    }

    setState(() {
      _isLoadingComponents = true;
      _isLoadingRecords = true;
      _loadError = null;
      _components = []; 
      _maintenanceRecords = {}; 
    });

    try {
       // Use vehicle NAME for repository queries
       final vehicleName = _selectedVehicle!.name; 

       // Load components using correct method
       final loadedComponents = await _componentRepository.getComponentsByVehicleName(vehicleName);
       if (!mounted) return;

       // Load records using correct method
       final loadedRecords = await _recordRepository.getMaintenanceRecords(vehicleName: vehicleName);
       if (!mounted) return; 

       // Process records to find the latest for each component (using componentId string)
       final Map<String, MaintenanceRecord> latestRecords = {};
       for (var record in loadedRecords) {
           // Skip if componentId is null or empty (shouldn't happen ideally)
           if (record.componentId.isEmpty) continue; 

           final componentIdStr = record.componentId; // Already a string

           // If we haven't seen this componentId OR the current record is newer
           if (!latestRecords.containsKey(componentIdStr) || 
               record.maintenanceDate.isAfter(latestRecords[componentIdStr]!.maintenanceDate)) {
              latestRecords[componentIdStr] = record;
           }
       }

       // Update state with loaded data
             if (mounted) {
                 setState(() {
            _components = loadedComponents;
            _maintenanceRecords = latestRecords;
          });
       }

                    } catch (e) {
                      if (mounted) {
                            setState(() {
           _loadError = "加载数据失败: ${e.toString()}";
        });
         // Log error using vehicle IsarId if available
         print("Error loading data for vehicle ${_selectedVehicle?.isarId}: $e"); 
                      }
                    } finally {
        if (mounted) {
                            setState(() {
          _isLoadingComponents = false;
          _isLoadingRecords = false;
          });
        }
      }
    }

  // Handle maintenance action (like recording maintenance)
  // Use correct Type Names
  Future<void> _handleMaintainAction(MaintenanceComponent component, MaintenanceRecord? lastRecord) async {
    if (!mounted) return; 

    print('Attempting to record maintenance directly for component: ${component.name}');
    
    // Use current date/mileage as placeholders
    final DateTime recordDate = DateTime.now();
    final int? recordMileage = _selectedVehicle?.mileage; 
    final String componentIdStr = component.isarId.toString();
    final String vehicleNameStr = _selectedVehicle?.name ?? 'Unknown';

    // Create and save the actual record 
    final newRecord = MaintenanceRecord(
      vehicleName: vehicleNameStr,
      componentId: componentIdStr,
      componentName: component.name,
      maintenanceDate: recordDate,
      mileageAtMaintenance: recordMileage?.toDouble(),
      notes: "保养完成 (快速记录)" // Simplified note
    );

    try {
      await _recordRepository.addMaintenanceRecord(newRecord);
      print('Successfully saved new maintenance record for ${component.name}');
      
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
               content: Text('已记录 ${component.name} 的保养'),
               duration: const Duration(seconds: 2),
               backgroundColor: Colors.green,
           ),
          );
          // Refresh data after successful save
          print('Refreshing data after direct maintenance recording...');
          await _loadDataForSelectedVehicle(); 
      }

      } catch (e) {
      print('Error saving maintenance record: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('保存保养记录失败: $e'), backgroundColor: Colors.red),
         );
      }
      // No need to return here, let it finish
    }
  }

  @override
  Widget build(BuildContext context) {
    // ... (Scaffold, AppBar) ...
    return Column(
              children: [
        // Vehicle Selector Dropdown
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isLoadingVehicles
              ? const Center(child: CircularProgressIndicator())
              : _vehicleLoadError != null
                  ? Center(child: Text(_vehicleLoadError!, style: const TextStyle(color: Colors.red)))
                  : DropdownButtonFormField<Vehicle>(
                value: _selectedVehicle,
                      hint: const Text('选择车辆'),
                      items: _vehicles.map((Vehicle vehicle) {
                  return DropdownMenuItem<Vehicle>(
                  value: vehicle,
                    child: Text(vehicle.name),
                  );
                }).toList(),
                onChanged: (Vehicle? newValue) {
                        if (newValue != _selectedVehicle) {
                  setState(() {
                    _selectedVehicle = newValue;
                            _components = []; 
                            _maintenanceRecords = {};
                            _loadError = null; 
                           });
                          _loadDataForSelectedVehicle(); 
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: '当前车辆',
                        border: OutlineInputBorder(),
                      ),
                    ),
        ),

        // Loading Indicator or Error for Components/Records
        if (_selectedVehicle != null && (_isLoadingComponents || _isLoadingRecords))
           const Padding(
             padding: EdgeInsets.all(16.0),
             child: Center(child: CircularProgressIndicator()),
           ),
        if (_selectedVehicle != null && _loadError != null)
           Padding(
             padding: const EdgeInsets.all(16.0),
             child: Center(child: Text(_loadError!, style: const TextStyle(color: Colors.red))),
           ),
        
        // Components List (conditionally displayed)
        Expanded(
          child: _selectedVehicle == null 
              ? const Center(child: Text('请先选择车辆'))
              : !_isLoadingComponents && !_isLoadingRecords && _loadError == null
                  ? ListView.builder(
                      itemCount: _components.length,
                      itemBuilder: (context, index) {
                        final component = _components[index];
                        final lastRecord = _maintenanceRecords[component.isarId.toString()]; 
                        
                        // Simple Interval Info based on new model
                        String intervalInfo = '建议周期: ';
                        if (component.maintenanceType == 'mileage') {
                          intervalInfo += '${component.maintenanceValue.toInt()} ${component.unit}';
                        } else if (component.maintenanceType == 'date') {
                          intervalInfo += '${component.maintenanceValue.toInt()} 天'; 
                        } else {
                          intervalInfo += '未知';
                        }

                        return Card(
                           margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                           child: ListTile(
                             title: Text(component.name, style: TextStyle(fontWeight: FontWeight.bold)),
                             subtitle: Text(
                                 '上次保养: ${lastRecord != null ? DateFormat('yyyy-MM-dd').format(lastRecord.maintenanceDate) : '无记录'}' + 
                                 '\n$intervalInfo'
                             ),
                             trailing: IconButton(
                               icon: const Icon(Icons.build_circle_outlined), 
                               tooltip: '记录保养',
                               onPressed: () => _handleMaintainAction(component, lastRecord),
                             ),
                           ),
                        );
                      },
                    )
                 : Container(), // Empty container while loading or if error
        ),
      ],
    );
     // ... (rest of build method, maybe FAB?) ...
  }
}

// ... (Painter class if exists) ... 
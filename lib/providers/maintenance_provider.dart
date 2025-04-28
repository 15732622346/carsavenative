import 'package:flutter/foundation.dart';
import '../models/maintenance_component_model.dart';
import '../models/maintenance_record_model.dart';
import '../models/vehicle_model.dart';
import '../repositories/local_component_repository.dart';
import '../repositories/local_record_repository.dart';
import '../repositories/local_vehicle_repository.dart';

/// 保养组件和记录状态管理
class MaintenanceProvider with ChangeNotifier {
  final LocalComponentRepository _componentRepository;
  final LocalRecordRepository _recordRepository;
  final LocalVehicleRepository _vehicleRepository;
  
  // 当前车辆的组件
  Map<String, List<MaintenanceComponent>> _vehicleComponents = {};
  // 当前车辆的记录
  Map<String, List<MaintenanceRecord>> _vehicleRecords = {};
  // 所有车辆的关键组件
  List<MaintenanceComponent> _allCriticalComponents = [];
  // 加载状态
  bool _isLoadingReminders = false;
  // 缓存的车辆列表
  List<Vehicle> _cachedVehicles = [];
  
  MaintenanceProvider(this._componentRepository, this._recordRepository, this._vehicleRepository) {
    // 在创建时加载车辆列表用于后续操作
    _loadVehicles();
  }

  // 私有方法，加载车辆列表
  Future<void> _loadVehicles() async {
    try {
      _cachedVehicles = await _vehicleRepository.getAllVehicles();
    } catch (e) {
      print('加载车辆失败: $e');
    }
  }

  // Getters
  List<MaintenanceComponent> getComponentsForVehicle(String vehicleName) {
    return _vehicleComponents[vehicleName] ?? [];
  }
  
  List<MaintenanceRecord> getRecordsForVehicle(String vehicleName) {
    return _vehicleRecords[vehicleName] ?? [];
  }
  
  List<MaintenanceComponent> get allCriticalComponents => _allCriticalComponents;
  
  int get criticalComponentCount => _allCriticalComponents.length;
  
  bool get isLoadingReminders => _isLoadingReminders;
  
  // 获取当前车辆的组件 (供HomeScreen使用)
  List<MaintenanceComponent> get reminders {
    // 当前实现简单返回第一个车辆的组件，实际应用中需要基于当前选中的车辆
    return _vehicleComponents.isNotEmpty ? _vehicleComponents.values.first : [];
  }
  
  /// 加载特定车辆的保养组件
  Future<List<MaintenanceComponent>> loadComponentsForVehicle(String vehicleName) async {
    try {
      _isLoadingReminders = true;
      notifyListeners();
      
      final components = await _componentRepository.getComponentsByVehicleName(vehicleName);
      _vehicleComponents[vehicleName] = components;
      
      _isLoadingReminders = false;
      notifyListeners();
      return components;
    } catch (e) {
      _isLoadingReminders = false;
      notifyListeners();
      print('加载车辆组件失败: $e');
      rethrow;
    }
  }
  
  /// 加载特定车辆的保养记录
  Future<List<MaintenanceRecord>> loadRecordsForVehicle(String vehicleName) async {
    try {
      final records = await _recordRepository.getMaintenanceRecords(vehicleName: vehicleName);
      _vehicleRecords[vehicleName] = records;
      notifyListeners();
      return records;
    } catch (e) {
      print('加载车辆记录失败: $e');
      rethrow;
    }
  }
  
  /// 加载所有车辆的关键组件
  Future<void> loadAllCriticalComponents(List<Vehicle> vehicles) async {
    List<MaintenanceComponent> criticalComponents = [];
    
    for (final vehicle in vehicles) {
      // 确保已加载该车辆的组件
      List<MaintenanceComponent> components;
      if (_vehicleComponents.containsKey(vehicle.name)) {
        components = _vehicleComponents[vehicle.name]!;
      } else {
        components = await loadComponentsForVehicle(vehicle.name);
      }
      
      // 找出需要关注的组件
      final criticalForVehicle = components.where((component) {
        final status = component.getStatus(vehicle.mileage.toDouble(), null);
        return status == MaintenanceStatus.attention || status == MaintenanceStatus.warning;
      }).toList();
      
      criticalComponents.addAll(criticalForVehicle);
    }
    
    _allCriticalComponents = criticalComponents;
    notifyListeners();
  }
  
  /// 添加保养组件
  Future<void> addComponent(MaintenanceComponent component) async {
    try {
      await _componentRepository.addComponent(component);
      
      if (_vehicleComponents.containsKey(component.vehicle)) {
        _vehicleComponents[component.vehicle]!.add(component);
      } else {
        _vehicleComponents[component.vehicle] = [component];
      }
      
      // 更新关键组件列表
      _updateCriticalComponentsForVehicle(component.vehicle);
      
      notifyListeners();
    } catch (e) {
      print('添加组件失败: $e');
      rethrow;
    }
  }
  
  /// 更新保养组件
  Future<void> updateComponent(MaintenanceComponent component) async {
    try {
      await _componentRepository.updateComponent(component);
      
      if (_vehicleComponents.containsKey(component.vehicle)) {
        final index = _vehicleComponents[component.vehicle]!
            .indexWhere((c) => c.id == component.id);
        if (index >= 0) {
          _vehicleComponents[component.vehicle]![index] = component;
        }
      }
      
      // 更新关键组件列表
      _updateCriticalComponentsForVehicle(component.vehicle);
      
      notifyListeners();
    } catch (e) {
      print('更新组件失败: $e');
      rethrow;
    }
  }
  
  /// 删除保养组件
  Future<void> deleteComponent(int id, String vehicleName) async {
    try {
      await _componentRepository.deleteComponent(id);
      
      if (_vehicleComponents.containsKey(vehicleName)) {
        _vehicleComponents[vehicleName]!.removeWhere((c) => c.id == id);
      }
      
      // 从关键组件列表中移除
      _allCriticalComponents.removeWhere((c) => c.id == id);
      
      notifyListeners();
    } catch (e) {
      print('删除组件失败: $e');
      rethrow;
    }
  }
  
  /// 添加保养记录
  Future<void> addRecord(MaintenanceRecord record) async {
    try {
      final newRecord = await _recordRepository.addMaintenanceRecord(record);
      
      if (_vehicleRecords.containsKey(record.vehicleName)) {
        _vehicleRecords[record.vehicleName]!.add(newRecord);
        // 保持记录按日期排序
        _vehicleRecords[record.vehicleName]!.sort(
          (a, b) => b.maintenanceDate.compareTo(a.maintenanceDate)
        );
      } else {
        _vehicleRecords[record.vehicleName] = [newRecord];
      }
      
      notifyListeners();
    } catch (e) {
      print('添加记录失败: $e');
      rethrow;
    }
  }
  
  /// 更新保养记录
  Future<void> updateRecord(MaintenanceRecord record) async {
    try {
      // LocalRecordRepository没有提供updateRecord方法
      // 我们需要自己实现，或者调用通用方法
      await _recordRepository.addMaintenanceRecord(record); // 使用添加来替代更新
      
      if (_vehicleRecords.containsKey(record.vehicleName)) {
        final index = _vehicleRecords[record.vehicleName]!
            .indexWhere((r) => r.id == record.id);
        if (index >= 0) {
          _vehicleRecords[record.vehicleName]![index] = record;
          // 保持记录按日期排序
          _vehicleRecords[record.vehicleName]!.sort(
            (a, b) => b.maintenanceDate.compareTo(a.maintenanceDate)
          );
        }
      }
      
      notifyListeners();
    } catch (e) {
      print('更新记录失败: $e');
      rethrow;
    }
  }
  
  /// 删除保养记录
  Future<void> deleteRecord(int id, String vehicleName) async {
    try {
      await _recordRepository.deleteMaintenanceRecord(id);
      
      if (_vehicleRecords.containsKey(vehicleName)) {
        _vehicleRecords[vehicleName]!.removeWhere((r) => r.id == id);
      }
      
      notifyListeners();
    } catch (e) {
      print('删除记录失败: $e');
      rethrow;
    }
  }
  
  /// 清除指定车辆的数据（用于删除车辆时）
  void clearVehicleData(String vehicleName) {
    _vehicleComponents.remove(vehicleName);
    _vehicleRecords.remove(vehicleName);
    _allCriticalComponents.removeWhere((c) => c.vehicle == vehicleName);
    notifyListeners();
  }
  
  /// 清除所有数据（用于刷新所有）
  void clearAllData() {
    _vehicleComponents.clear();
    _vehicleRecords.clear();
    _allCriticalComponents.clear();
    notifyListeners();
  }
  
  /// 更新特定车辆的关键组件 (简化版，不查询数据库)
  void _updateCriticalComponentsForVehicle(String vehicleName) {
    // 移除该车辆的所有关键组件
    _allCriticalComponents.removeWhere((c) => c.vehicle == vehicleName);
    
    // 如果有该车辆的组件信息
    if (_vehicleComponents.containsKey(vehicleName)) {
      // 找到对应车辆
      final vehicleOpt = _cachedVehicles.where((v) => v.name == vehicleName).toList();
      if (vehicleOpt.isNotEmpty) {
        final vehicle = vehicleOpt.first;
        
        // 从组件列表中找出关键组件
        final components = _vehicleComponents[vehicleName]!;
        final criticalForVehicle = components.where((component) {
          final status = component.getStatus(vehicle.mileage.toDouble(), null);
          return status == MaintenanceStatus.attention || status == MaintenanceStatus.warning;
        }).toList();
        
        // 添加到全局关键组件列表
        _allCriticalComponents.addAll(criticalForVehicle);
      }
    }
  }
}
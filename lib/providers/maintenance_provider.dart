import 'package:flutter/foundation.dart';
import '../models/maintenance_component_model.dart';
import '../models/maintenance_record_model.dart';
import '../models/vehicle_model.dart';
import '../repositories/local_component_repository.dart';
import '../repositories/local_record_repository.dart';
import '../repositories/vehicle_repository.dart';

/// 保养组件和记录状态管理
class MaintenanceProvider with ChangeNotifier {
  final LocalComponentRepository? _componentRepository;
  final LocalRecordRepository? _recordRepository;
  final VehicleRepository _vehicleRepository;
  
  // State variables
  List<MaintenanceComponent> _components = [];
  List<MaintenanceRecord> _records = [];
  bool _isLoading = false;
  String? _error;
  Map<String, List<MaintenanceComponent>> _vehicleComponents = {};
  Map<String, List<MaintenanceRecord>> _vehicleRecords = {};
  List<Vehicle> _cachedVehicles = [];
  // 所有车辆的关键组件
  List<MaintenanceComponent> _allCriticalComponents = [];
  // 加载状态
  bool _isLoadingReminders = false;
  
  MaintenanceProvider(
    this._componentRepository,
    this._recordRepository,
    this._vehicleRepository,
  ) {
    // 在创建时加载车辆列表用于后续操作
    debugPrint('【Provider】MaintenanceProvider初始化');
    loadData();
    _loadVehicles();
  }

  // Getters
  List<MaintenanceComponent> get components => _components;
  List<MaintenanceRecord> get records => _records;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
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
      if (_isLoadingReminders) {
        debugPrint('【Provider】已经在加载组件中，跳过: $vehicleName');
        return _vehicleComponents[vehicleName] ?? [];
      }
      
      _isLoadingReminders = true;
      debugPrint('【Provider】设置加载状态，通知UI');
      notifyUI();
      
      debugPrint('【Provider】开始加载车辆组件: $vehicleName');
      final components = await _componentRepository!.getComponentsByVehicleName(vehicleName);
      debugPrint('【Provider】组件加载完成: ${components.length}个');
      _vehicleComponents[vehicleName] = components;
      
      // 更新该车辆的关键组件
      debugPrint('【Provider】更新关键组件');
      _updateCriticalComponentsForVehicleSimple(vehicleName);
      
      _isLoadingReminders = false;
      debugPrint('【Provider】组件加载全部完成，通知UI');
      notifyUI();
      return components;
    } catch (e) {
      debugPrint('【Provider错误】加载车辆组件失败: $e');
      _isLoadingReminders = false;
      notifyUI();
      rethrow;
    }
  }
  
  /// 简化版的更新关键组件方法，不会触发额外的notifyListeners
  void _updateCriticalComponentsForVehicleSimple(String vehicleName) {
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
    // 不会单独调用notifyListeners，减少重新构建次数
  }
  
  /// 加载特定车辆的保养记录
  Future<List<MaintenanceRecord>> loadRecordsForVehicle(String vehicleName) async {
    try {
      debugPrint('【Provider】开始加载车辆记录: $vehicleName');
      final records = await _recordRepository!.getMaintenanceRecords(vehicleName: vehicleName);
      
      // 确保记录按日期排序（最新的在前面）
      records.sort((a, b) => b.maintenanceDate.compareTo(a.maintenanceDate));
      
      _vehicleRecords[vehicleName] = records;
      debugPrint('【Provider】记录加载完成: ${records.length}个，通知UI');
      notifyUI();
      return records;
    } catch (e) {
      debugPrint('【Provider错误】加载车辆记录失败: $e');
      rethrow;
    }
  }
  
  /// 加载所有车辆的关键组件
  Future<void> loadAllCriticalComponents(List<Vehicle> vehicles) async {
    debugPrint('【Provider】开始加载所有车辆的关键组件，${vehicles.length}辆车');
    List<MaintenanceComponent> criticalComponents = [];
    
    for (final vehicle in vehicles) {
      // 确保已加载该车辆的组件
      List<MaintenanceComponent> components;
      if (_vehicleComponents.containsKey(vehicle.name)) {
        debugPrint('【Provider】使用缓存的组件: ${vehicle.name}');
        components = _vehicleComponents[vehicle.name]!;
      } else {
        debugPrint('【Provider】加载车辆组件: ${vehicle.name}');
        components = await _componentRepository!.getComponentsByVehicleName(vehicle.name);
        _vehicleComponents[vehicle.name] = components;
      }
      
      // 找出需要关注的组件
      final criticalForVehicle = components.where((component) {
        final status = component.getStatus(vehicle.mileage.toDouble(), null);
        return status == MaintenanceStatus.attention || status == MaintenanceStatus.warning;
      }).toList();
      
      debugPrint('【Provider】${vehicle.name}有${criticalForVehicle.length}个关键组件');
      criticalComponents.addAll(criticalForVehicle);
    }
    
    _allCriticalComponents = criticalComponents;
    debugPrint('【Provider】所有关键组件加载完成，共${criticalComponents.length}个，通知UI');
    notifyUI(); // 一次性通知所有更改
  }
  
  /// 添加保养组件
  Future<void> addComponent(MaintenanceComponent component) async {
    if (_componentRepository == null) {
      _error = 'Web platform does not support maintenance features';
      notifyListeners();
      return;
    }

    try {
      await _componentRepository!.addComponent(component);
      await loadData();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
  
  /// 更新保养组件
  Future<void> updateComponent(MaintenanceComponent component) async {
    if (_componentRepository == null) {
      _error = 'Web platform does not support maintenance features';
      notifyListeners();
      return;
    }

    try {
      await _componentRepository!.updateComponent(component);
      await loadData();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
  
  /// 删除保养组件
  Future<void> deleteComponent(int id) async {
    if (_componentRepository == null) {
      _error = 'Web platform does not support maintenance features';
      notifyListeners();
      return;
    }

    try {
      await _componentRepository!.deleteComponent(id);
      await loadData();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
  
  /// 添加保养记录
  Future<void> addRecord(MaintenanceRecord record) async {
    if (_recordRepository == null) {
      _error = 'Web platform does not support maintenance features';
      notifyListeners();
      return;
    }

    try {
      await _recordRepository!.addMaintenanceRecord(record);
      await loadData();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
  
  /// 更新保养记录
  Future<void> updateRecord(MaintenanceRecord record) async {
    if (_recordRepository == null) {
      _error = 'Web platform does not support maintenance features';
      notifyListeners();
      return;
    }

    try {
      await _recordRepository!.addMaintenanceRecord(record);
      await loadData();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
  
  /// 删除保养记录
  Future<void> deleteRecord(int id) async {
    if (_recordRepository == null) {
      _error = 'Web platform does not support maintenance features';
      notifyListeners();
      return;
    }

    try {
      await _recordRepository!.deleteMaintenanceRecord(id);
      await loadData();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
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
    // 不需要在这里调用notifyListeners，已经在loadComponentsForVehicle中调用
  }

  void notifyUI() {
    // 自定义方法，添加日志
    debugPrint('【Provider】触发UI更新 ${DateTime.now()}');
    notifyListeners();
  }

  Future<void> loadData() async {
    if (_componentRepository == null || _recordRepository == null) {
      _error = 'Web platform does not support maintenance features';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _components = await _componentRepository!.getAllComponents();
      _records = await _recordRepository!.getMaintenanceRecords();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 私有方法，加载车辆列表
  Future<void> _loadVehicles() async {
    try {
      _cachedVehicles = await _vehicleRepository.getAllVehicles();
      debugPrint('【Provider】缓存车辆列表加载完成，${_cachedVehicles.length}辆车');
    } catch (e) {
      debugPrint('【Provider错误】加载车辆失败: $e');
    }
  }
}
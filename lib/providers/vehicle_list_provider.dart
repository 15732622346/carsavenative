import 'package:flutter/foundation.dart';
import '../models/vehicle_model.dart';
import '../repositories/local_vehicle_repository.dart';

/// 车辆列表状态管理
class VehicleListProvider with ChangeNotifier {
  final LocalVehicleRepository _vehicleRepository;
  List<Vehicle> _vehicles = [];

  VehicleListProvider(this._vehicleRepository) {
    // 初始化时加载车辆
    loadVehicles();
  }

  List<Vehicle> get vehicles => _vehicles;

  /// 加载车辆列表
  Future<void> loadVehicles() async {
    try {
      _vehicles = await _vehicleRepository.getAllVehicles();
      notifyListeners();
    } catch (e) {
      print('加载车辆列表失败: $e');
    }
  }

  /// 删除车辆及其相关数据
  Future<void> deleteVehicle(int id) async {
    try {
      await _vehicleRepository.deleteVehicle(id);
      // 更新内存中的列表
      _vehicles.removeWhere((vehicle) => vehicle.id == id);
      notifyListeners();
    } catch (e) {
      print('删除车辆失败: $e');
      rethrow;
    }
  }

  /// 添加车辆
  Future<void> addVehicle(Vehicle vehicle) async {
    try {
      final newVehicle = await _vehicleRepository.addVehicle(vehicle);
      _vehicles.add(newVehicle);
      notifyListeners();
    } catch (e) {
      print('添加车辆失败: $e');
      rethrow;
    }
  }

  /// 更新车辆
  Future<void> updateVehicle(Vehicle vehicle) async {
    try {
      final updatedVehicle = await _vehicleRepository.updateVehicle(vehicle);
      final index = _vehicles.indexWhere((v) => v.id == vehicle.id);
      if (index >= 0) {
        _vehicles[index] = updatedVehicle;
        notifyListeners();
      }
    } catch (e) {
      print('更新车辆失败: $e');
      rethrow;
    }
  }
  
  /// 获取所有车辆名称列表，用于筛选等场景
  List<String> getVehicleNames() {
    return _vehicles.map((v) => v.name).toList();
  }
} 
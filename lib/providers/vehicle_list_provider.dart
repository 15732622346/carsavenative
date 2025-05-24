import 'package:flutter/foundation.dart';
import '../models/vehicle_model.dart';
import '../repositories/vehicle_repository.dart';

/// 车辆列表状态管理
class VehicleListProvider with ChangeNotifier {
  final VehicleRepository _repository;
  List<Vehicle> _vehicles = [];
  bool _isLoading = false;
  String? _error;

  VehicleListProvider(this._repository) {
    // 初始化时加载车辆列表
    loadVehicles();
  }

  // Getters
  List<Vehicle> get vehicles => _vehicles;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// 加载车辆列表
  Future<void> loadVehicles() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _vehicles = await _repository.getAllVehicles();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 添加车辆
  Future<void> addVehicle(Vehicle vehicle) async {
    try {
      await _repository.addVehicle(vehicle);
      await loadVehicles();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// 更新车辆
  Future<void> updateVehicle(Vehicle vehicle) async {
    try {
      await _repository.updateVehicle(vehicle);
      await loadVehicles();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// 删除车辆
  Future<void> deleteVehicle(int id) async {
    try {
      await _repository.deleteVehicle(id);
      await loadVehicles();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// 通过ID获取车辆
  Vehicle? getVehicleById(int id) {
    return _vehicles.firstWhere((v) => v.id == id, orElse: () => null as Vehicle);
  }

  /// 获取最新的车辆里程数
  int getVehicleMileage(String vehicleName) {
    final vehicle = _vehicles.firstWhere(
      (v) => v.name == vehicleName,
      orElse: () => Vehicle(name: vehicleName, year: 0, mileage: 0),
    );
    return vehicle.mileage;
  }

  /// 刷新车辆里程数
  Future<void> refreshVehicleMileage(int id, int newMileage) async {
    final vehicle = getVehicleById(id);
    if (vehicle != null) {
      final updatedVehicle = vehicle.copyWith(mileage: newMileage);
      await updateVehicle(updatedVehicle);
    }
  }
} 
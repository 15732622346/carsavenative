import 'package:flutter/foundation.dart';
import '../models/vehicle_model.dart';
import '../repositories/local_vehicle_repository.dart';

/// 车辆列表状态管理
class VehicleListProvider with ChangeNotifier {
  final LocalVehicleRepository _vehicleRepository;
  List<Vehicle> _vehicles = [];
  bool _isLoading = false;
  String? _error;

  VehicleListProvider(this._vehicleRepository) {
    // 初始化时加载车辆列表
    loadVehicles();
  }

  // Getters
  List<Vehicle> get vehicles => _vehicles;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// 加载车辆列表
  Future<void> loadVehicles() async {
    try {
      _isLoading = true;
      notifyListeners();

      _vehicles = await _vehicleRepository.getAllVehicles();
      _error = null;
    } catch (e) {
      _error = "加载车辆失败: $e";
      print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 添加车辆
  Future<void> addVehicle(Vehicle vehicle) async {
    try {
      _isLoading = true;
      notifyListeners();

      final newVehicle = await _vehicleRepository.addVehicle(vehicle);
      _vehicles.add(newVehicle);
      _error = null;
    } catch (e) {
      _error = "添加车辆失败: $e";
      print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 更新车辆
  Future<void> updateVehicle(Vehicle vehicle) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _vehicleRepository.updateVehicle(vehicle);
      
      // 更新内存中的数据
      final index = _vehicles.indexWhere((v) => v.id == vehicle.id);
      if (index >= 0) {
        _vehicles[index] = vehicle;
      }
      
      _error = null;
    } catch (e) {
      _error = "更新车辆失败: $e";
      print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 删除车辆
  Future<void> deleteVehicle(int id) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _vehicleRepository.deleteVehicle(id);
      
      // 从内存中移除
      _vehicles.removeWhere((v) => v.id == id);
      
      _error = null;
    } catch (e) {
      _error = "删除车辆失败: $e";
      print(_error);
    } finally {
      _isLoading = false;
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
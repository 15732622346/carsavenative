import 'package:shared_preferences/shared_preferences.dart';
import '../models/vehicle_model.dart';
import 'vehicle_repository.dart';

class WebVehicleRepository implements VehicleRepository {
  final SharedPreferences _prefs;
  static const String _vehiclesKey = 'vehicles';

  WebVehicleRepository(this._prefs);

  @override
  Future<List<Vehicle>> getAllVehicles() async {
    final vehiclesJson = _prefs.getStringList(_vehiclesKey) ?? [];
    return vehiclesJson.map((json) => Vehicle.fromJson(json)).toList();
  }

  @override
  Future<Vehicle?> getVehicleById(int id) async {
    final vehicles = await getAllVehicles();
    return vehicles.firstWhere((v) => v.id == id);
  }

  @override
  Future<Vehicle> addVehicle(Vehicle vehicle) async {
    final vehicles = await getAllVehicles();
    if (vehicles.any((v) => v.name == vehicle.name)) {
      throw Exception('添加失败：已存在同名的车辆，请使用其他名称。');
    }
    vehicles.add(vehicle);
    await _saveVehicles(vehicles);
    return vehicle;
  }

  @override
  Future<Vehicle> updateVehicle(Vehicle vehicle) async {
    final vehicles = await getAllVehicles();
    final index = vehicles.indexWhere((v) => v.id == vehicle.id);
    if (index == -1) {
      throw Exception('更新失败：找不到指定的车辆');
    }
    vehicles[index] = vehicle;
    await _saveVehicles(vehicles);
    return vehicle;
  }

  @override
  Future<void> deleteVehicle(int id) async {
    final vehicles = await getAllVehicles();
    vehicles.removeWhere((v) => v.id == id);
    await _saveVehicles(vehicles);
  }

  Future<void> _saveVehicles(List<Vehicle> vehicles) async {
    final vehiclesJson = vehicles.map((v) => v.toJson()).toList();
    await _prefs.setStringList(_vehiclesKey, vehiclesJson);
  }
} 
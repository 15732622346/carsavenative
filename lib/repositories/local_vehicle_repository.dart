import 'package:isar/isar.dart';
import '../main.dart'; // Import main to access the global isar instance
import '../models/vehicle_model.dart';
import '../models/maintenance_component_model.dart'; // Ensure this is present
import '../models/maintenance_record_model.dart';    // Ensure this is present
import 'vehicle_repository.dart';

class LocalVehicleRepository implements VehicleRepository {
  final Isar isar;

  LocalVehicleRepository(this.isar);

  @override
  Future<List<Vehicle>> getAllVehicles() async {
    return await isar.vehicles.where().findAll();
  }

  @override
  Future<Vehicle?> getVehicleById(int id) async {
    return await isar.vehicles.get(id);
  }

  @override
  Future<Vehicle> addVehicle(Vehicle vehicle) async {
    final existing = await isar.vehicles.filter().nameEqualTo(vehicle.name).findFirst();
    if (existing != null) {
      throw Exception('添加失败：已存在同名的车辆，请使用其他名称。');
    }

    await isar.writeTxn(() async {
      await isar.vehicles.put(vehicle);
    });
    return vehicle;
  }

  @override
  Future<Vehicle> updateVehicle(Vehicle vehicle) async {
    try {
      if (vehicle.id <= 0) {
        throw Exception("无效的车辆ID: ${vehicle.id}");
      }
      
      await isar.writeTxn(() async {
        await isar.vehicles.put(vehicle);
      });
      
      final updatedVehicle = await isar.vehicles.get(vehicle.id);
      if (updatedVehicle == null) {
        throw Exception("更新失败: 无法获取更新后的车辆");
      }
      
      print("更新车辆成功 - ID: ${updatedVehicle.id}, 新里程: ${updatedVehicle.mileage}");
      return updatedVehicle;
    } catch (e) {
      print("更新车辆时出错: $e");
      throw Exception("更新车辆失败: $e");
    }
  }

  @override
  Future<void> deleteVehicle(int id, {bool createTransaction = true}) async {
    if (createTransaction) {
      await isar.writeTxn(() async {
        await isar.vehicles.delete(id);
      });
    } else {
      await isar.vehicles.delete(id);
    }
  }

  Stream<List<Vehicle>> watchAllVehicles() {
    return isar.vehicles.where().watch(fireImmediately: true);
  }

  Stream<Vehicle?> watchVehicleById(Id id) {
    return isar.vehicles.watchObject(id, fireImmediately: true);
  }

  // TODO: Add specific query methods as needed (e.g., find by name, filter by criteria)
} 
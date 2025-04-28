import 'package:isar/isar.dart';
import '../main.dart'; // Import main to access the global isar instance
import '../models/vehicle_model.dart';
import '../models/maintenance_component_model.dart'; // Ensure this is present
import '../models/maintenance_record_model.dart';    // Ensure this is present

class LocalVehicleRepository {
  final Isar isar;

  LocalVehicleRepository(this.isar);

  // Get all vehicles
  Future<List<Vehicle>> getAllVehicles() async {
    return await isar.vehicles.where().findAll();
  }

  // Get a single vehicle by Isar ID
  Future<Vehicle?> getVehicleById(int id) async {
    return await isar.vehicles.get(id);
  }

  // Add a new vehicle
  Future<Vehicle> addVehicle(Vehicle vehicle) async {
    // --- Logic to check for duplicate name locally ---
    final existing = await isar.vehicles.filter().nameEqualTo(vehicle.name).findFirst();
    if (existing != null) {
      throw Exception('添加失败：已存在同名的车辆，请使用其他名称。');
    }
    // --- End duplicate check ---

    await isar.writeTxn(() async {
      await isar.vehicles.put(vehicle);
    });
    return vehicle;
  }

  // Update an existing vehicle
  Future<Vehicle> updateVehicle(Vehicle vehicle) async {
    try {
      // 检查ID是否有效
      if (vehicle.id <= 0) {
        throw Exception("无效的车辆ID: ${vehicle.id}");
      }
      
      // 在事务中更新车辆
      await isar.writeTxn(() async {
        // 使用put方法覆盖现有记录
        await isar.vehicles.put(vehicle);
      });
      
      // 验证更新是否成功
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

  // Delete a vehicle
  Future<void> deleteVehicle(int id, {bool createTransaction = true}) async {
    if (createTransaction) {
      await isar.writeTxn(() async {
        await isar.vehicles.delete(id);
      });
    } else {
      await isar.vehicles.delete(id);
    }
  }

  // Read All (Stream) - Useful for reactive UI updates
  Stream<List<Vehicle>> watchAllVehicles() {
    return isar.vehicles.where().watch(fireImmediately: true);
  }

  // Read One by Isar ID (Stream)
  Stream<Vehicle?> watchVehicleById(Id id) {
    return isar.vehicles.watchObject(id, fireImmediately: true);
  }

  // TODO: Add specific query methods as needed (e.g., find by name, filter by criteria)
} 
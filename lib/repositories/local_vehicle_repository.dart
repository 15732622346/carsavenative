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
    // Fetch existing to ensure it exists before update
    final existingVehicle = await isar.vehicles.get(vehicle.id);
    if (existingVehicle == null) {
      throw Exception("Cannot update vehicle: Not found in local database.");
    }
    
    // Optional: Check for name conflict if name is changed
    if (vehicle.name != existingVehicle.name) {
        final conflictingVehicle = await isar.vehicles.filter().nameEqualTo(vehicle.name).findFirst();
        if (conflictingVehicle != null) {
             throw Exception('更新失败：已存在同名的车辆，请使用其他名称。');
        }
    }

    await isar.writeTxn(() async {
      await isar.vehicles.put(vehicle);
    });
    return vehicle;
  }

  // Delete a vehicle
  Future<void> deleteVehicle(int id) async {
    await isar.writeTxn(() async {
      await isar.vehicles.delete(id);
    });
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
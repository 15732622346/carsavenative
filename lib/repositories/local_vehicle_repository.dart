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
  Future<Vehicle?> getVehicleById(int isarId) async {
    // Use readAsync for read operations (optional, but good practice)
    return await isar.readAsync((isar) => isar.vehicles.get(isarId));
  }

  // Add a new vehicle
  Future<Vehicle> addVehicle(Vehicle vehicle) async {
    // --- Logic to check for duplicate name locally ---
    // In Isar v4, chain filters directly after where()
    final existing = await isar.vehicles.where().nameEqualTo(vehicle.name).findFirst();
    if (existing != null) {
      throw Exception('添加失败：已存在同名的车辆，请使用其他名称。');
    }
    // --- End duplicate check ---

    // Write the new vehicle using writeAsync with the correct signature
    await isar.writeAsync((isar) async {
      isar.vehicles.put(vehicle); // Call put without await inside transaction
    });
    return vehicle;
  }

  // Update an existing vehicle
  Future<Vehicle> updateVehicle(Vehicle vehicle) async {
    // Fetch existing to ensure it exists before update
    // Use readAsync for read operations
    final existingVehicle = await isar.readAsync((isar) => isar.vehicles.get(vehicle.isarId));
    if (existingVehicle == null) {
      throw Exception("Cannot update vehicle: Not found in local database.");
    }
    
    // Optional: Check for name conflict if name is changed
    if (vehicle.name != existingVehicle.name) {
        // In Isar v4, chain filters directly after where()
        final conflictingVehicle = await isar.vehicles.where().nameEqualTo(vehicle.name).findFirst();
        if (conflictingVehicle != null) {
             throw Exception('更新失败：已存在同名的车辆，请使用其他名称。');
        }
    }

    // Perform the update using writeAsync with the correct signature
    await isar.writeAsync((isar) async {
      isar.vehicles.put(vehicle); // Call put without await inside transaction
    });
    return vehicle;
  }

  // Delete a vehicle
  Future<void> deleteVehicle(int isarId) async {
    // Use writeAsync with the correct signature
    await isar.writeAsync((isar) async {
      await isar.vehicles.delete(isarId); // delete returns Future<bool>
    });
  }

  // Read All (Stream) - Useful for reactive UI updates
  Stream<List<Vehicle>> watchAllVehicles() {
     // Implementation using isar.vehicles.where().watch(fireImmediately: true)
     return Stream.value([]); // Placeholder
  }

  // Read One by Isar ID (Stream)
  Stream<Vehicle?> watchVehicleById(Id isarId) {
    // Implementation using isar.vehicles.watchObject(isarId, fireImmediately: true)
    return Stream.value(null); // Placeholder
  }

  // TODO: Add specific query methods as needed (e.g., find by name, filter by criteria)
} 
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

  // Get a single vehicle by Isar ID (if needed, often not directly used from UI)
  Future<Vehicle?> getVehicleById(Id isarId) async {
    return await isar.vehicles.get(isarId);
  }

  // Add a new vehicle
  Future<Vehicle> addVehicle(Vehicle vehicle) async {
    // --- Logic to check for duplicate name locally ---
    final existing = await isar.vehicles.filter().nameEqualTo(vehicle.name).findFirst();
    if (existing != null) {
      throw Exception('添加失败：已存在同名的车辆，请使用其他名称。'); // Use localized message
    }
    // --- End duplicate check ---

    // Write the new vehicle to Isar within a transaction
    await isar.writeTxn(() async {
      await isar.vehicles.put(vehicle);
    });
    // After put, the vehicle object might have its isarId populated if it was null
    return vehicle; // Return the vehicle (potentially with its new Isar ID)
  }

  // Update an existing vehicle (e.g., update mileage)
  Future<Vehicle> updateVehicle(Vehicle vehicle) async {
    // Ensure the vehicle has a valid Isar ID
    // Note: Isar's put operation handles both insert and update based on ID.
    // If vehicle.isarId exists, it updates; otherwise, it inserts.
    // We might want more explicit checks depending on the source of the 'vehicle' object.

    // For clarity, let's assume we only update existing ones here.
    // Fetch existing to ensure it exists before update? Optional but safer.
    final existingVehicle = await isar.vehicles.get(vehicle.isarId);
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

    // Perform the update within a transaction
    await isar.writeTxn(() async {
      await isar.vehicles.put(vehicle); // put handles update if ID exists
    });
    return vehicle; // Return the updated vehicle object
  }

  // Delete a vehicle and its associated components/records (Cascade delete)
  Future<void> deleteVehicle(Id isarId) async {
    // Delete the vehicle itself
    await isar.vehicles.delete(isarId);
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
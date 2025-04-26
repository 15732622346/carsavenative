import 'package:isar/isar.dart';
import '../models/maintenance_record_model.dart';

class LocalRecordRepository {
  final Isar isar; // Ensure Isar instance field exists

  // Correct the constructor to accept Isar instance
  LocalRecordRepository(this.isar);

  // Get records, optionally filtered by vehicle name
  Future<List<MaintenanceRecord>> getMaintenanceRecords({String? vehicleName}) async {
    if (vehicleName != null && vehicleName.isNotEmpty) {
      // In Isar v4, chain filters directly after where()
      return await isar.maintenanceRecords.where()
              .vehicleNameEqualTo(vehicleName) // Apply filter directly
              .sortByMaintenanceDateDesc() // Sort by date descending
              .findAll();
    } else {
      // Get all records, sorted
      return await isar.maintenanceRecords.where()
              .sortByMaintenanceDateDesc()
              .findAll();
    }
  }

  // Add a new maintenance record
  Future<MaintenanceRecord> addMaintenanceRecord(MaintenanceRecord record) async {
    // Use writeAsync with correct signature
    await isar.writeAsync((isar) async {
      isar.maintenanceRecords.put(record); // Call put without await
    });
    return record;
  }

  // Delete a specific maintenance record by Isar ID
  Future<void> deleteMaintenanceRecord(int isarId) async { // Changed Id to int
    // Use writeAsync with correct signature
    await isar.writeAsync((isar) async {
      await isar.maintenanceRecords.delete(isarId);
    });
  }

  // Potentially add methods to delete records by componentId or vehicleName if needed
  // Future<void> deleteRecordsByComponentId(String componentId) async { ... }
  // Future<void> deleteRecordsByVehicleName(String vehicleName) async { ... }
} 
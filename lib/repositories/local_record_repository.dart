import 'package:isar/isar.dart';
import '../models/maintenance_record_model.dart';

class LocalRecordRepository {
  final Isar isar; // Ensure Isar instance field exists

  // Correct the constructor to accept Isar instance
  LocalRecordRepository(this.isar);

  // Get records, optionally filtered by vehicle name
  Future<List<MaintenanceRecord>> getMaintenanceRecords({String? vehicleName}) async {
    if (vehicleName != null && vehicleName.isNotEmpty) {
      // Use index for filtering
      return await isar.maintenanceRecords.filter()
              .vehicleNameEqualTo(vehicleName)
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
    // Add timestamp if not already set (or use default from model?)
    // record.maintenanceDate ??= DateTime.now(); // Ensure date is set
    
    await isar.writeTxn(() async {
      await isar.maintenanceRecords.put(record);
    });
    return record;
  }

  // Delete a specific maintenance record by Isar ID
  Future<void> deleteMaintenanceRecord(Id isarId) async {
    await isar.writeTxn(() async {
      await isar.maintenanceRecords.delete(isarId);
    });
  }

  // Potentially add methods to delete records by componentId or vehicleName if needed
  // Future<void> deleteRecordsByComponentId(String componentId) async { ... }
  // Future<void> deleteRecordsByVehicleName(String vehicleName) async { ... }
} 
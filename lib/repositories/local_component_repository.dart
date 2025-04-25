import 'package:isar/isar.dart';
import '../models/maintenance_component_model.dart';
import '../models/maintenance_record_model.dart'; // Import the main model file

class LocalComponentRepository {
  final Isar isar; // Add Isar instance field

  // Update constructor to accept Isar instance
  LocalComponentRepository(this.isar);

  Future<List<MaintenanceComponent>> getAllComponents() async {
    // Use the instance field 'isar'
    return await isar.maintenanceComponents.where().findAll();
  }

  Future<MaintenanceComponent?> getComponentById(int id) async {
    // Use the instance field 'isar'
    // Assuming MaintenanceComponent has an isarId getter after generation
    return await isar.maintenanceComponents.get(id);
  }

  Future<void> addComponent(MaintenanceComponent component) async {
    await isar.writeTxn(() async {
      // Use the instance field 'isar'
      await isar.maintenanceComponents.put(component);
    });
  }

  Future<void> updateComponent(MaintenanceComponent component) async {
    await isar.writeTxn(() async {
       // Use the instance field 'isar'
      await isar.maintenanceComponents.put(component);
    });
  }

  Future<void> deleteComponent(int id) async {
    await isar.writeTxn(() async {
      // Use the instance field 'isar'
      // Assuming MaintenanceComponent has an isarId getter after generation
      await isar.maintenanceComponents.delete(id);
    });
  }

  // New method to get components filtered by vehicle name
  Future<List<MaintenanceComponent>> getComponentsByVehicleName(String vehicleName) async {
    // Use the instance field 'isar'
    return await isar.maintenanceComponents
        .filter()
        .vehicleEqualTo(vehicleName)
        .findAll();
  }

  // Add methods for Maintenance Records if needed, accessing via this.isar
  // It might be better to keep record-related methods in LocalRecordRepository
  /* // Commenting out record methods here as they likely belong in the other repo
  Future<List<MaintenanceRecord>> getRecordsForComponent(int componentId) async {
     // Use the instance field 'isar' and the correct collection name
    // Convert int componentId to String for the query
    return await isar.maintenanceRecords
        .filter()
        .componentIdEqualTo(componentId.toString()) // Ensure conversion to String
        .findAll();
  }

   Future<void> addRecord(MaintenanceRecord record) async {
    await isar.writeTxn(() async {
      // Use the instance field 'isar'
      await isar.maintenanceRecords.put(record);
    });
  }
  */

  // TODO: Add specific query methods as needed (e.g., filter by status, type)
}
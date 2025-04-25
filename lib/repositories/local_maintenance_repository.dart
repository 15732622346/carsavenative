import 'package:isar/isar.dart';
import '../main.dart'; // Access global isar instance
import '../models/maintenance_component_model.dart';
import '../models/maintenance_record_model.dart'; // Import record model

class LocalMaintenanceRepository {
  final Isar isar;

  LocalMaintenanceRepository(this.isar); // Constructor

  // --- Get Components ---
  /// Fetches all maintenance components from the local database.
  Future<List<MaintenanceComponent>> getAllComponents() async {
    return await isar.maintenanceComponents.where().findAll();
  }

  /// Fetches maintenance components associated with a specific vehicle name.
  Future<List<MaintenanceComponent>> getComponentsByVehicle(String vehicleName) async {
    return await isar.maintenanceComponents
        .filter()
        .vehicleEqualTo(vehicleName)
        .findAll();
  }

  // --- Delete Component ---
  /// Deletes a maintenance component by its Isar ID.
  Future<void> deleteComponent(Id componentId) async {
    await isar.writeTxn(() async {
      await isar.maintenanceComponents.delete(componentId);
      // TODO: Decide if associated records should be deleted here or elsewhere
    });
  }

  /// Deletes all maintenance components associated with a specific vehicle name.
  /// Returns the number of components deleted.
  Future<int> deleteComponentsByVehicle(String vehicleName) async {
    // This needs to be wrapped in a transaction by the caller if done with other operations.
    final componentsToDelete = await isar.maintenanceComponents
        .filter()
        .vehicleEqualTo(vehicleName)
        .findAll();
    
    if (componentsToDelete.isNotEmpty) {
      final List<Id> idsToDelete = componentsToDelete.map((c) => c.isarId).toList();
      return await isar.maintenanceComponents.deleteAll(idsToDelete);
    } else {
      return 0;
    }
  }

  // --- Add Component ---
  Future<MaintenanceComponent> addComponent(MaintenanceComponent component) async {
    // Check for duplicate name within the same vehicle
    final existing = await isar.maintenanceComponents
                              .filter()
                              .vehicleEqualTo(component.vehicle)
                              .and()
                              .nameEqualTo(component.name)
                              .findFirst();
    if (existing != null) {
      throw Exception('添加失败：该车辆下已存在同名的保养项目。');
    }
    
    // Write the new component
    await isar.writeTxn(() async {
      await isar.maintenanceComponents.put(component);
    });
    // After put, the component object will have its isarId populated.
    return component; 
  }

  // --- Update Component ---
  /// Updates an existing maintenance component in the database.
  /// IMPORTANT: This only updates basic info and cycle value.
  /// Target mileage/date recalculation happens during the 'Maintain' action.
  Future<MaintenanceComponent> updateComponent(MaintenanceComponent component) async {
    // Ensure the component has a valid Isar ID
    final existing = await isar.maintenanceComponents.get(component.isarId);
    if (existing == null) {
      throw Exception("Cannot update component: Not found in local database.");
    }
    
    // Optional: Check for name conflict if name is changed and within the same vehicle
    if (component.name != existing.name) {
        final conflicting = await isar.maintenanceComponents
                                  .filter()
                                  .vehicleEqualTo(component.vehicle)
                                  .and()
                                  .nameEqualTo(component.name)
                                  .findFirst();
        if (conflicting != null) {
             throw Exception('更新失败：该车辆下已存在同名的保养项目。');
        }
    }

    // Perform the update within a transaction
    // Note: We update the passed 'component' object which should contain the changes
    // from the edit screen. Isar's put will overwrite the existing object with this one.
    await isar.writeTxn(() async {
      await isar.maintenanceComponents.put(component);
    });
    return component; // Return the updated component object
  }

  // --- Add Maintenance Record ---
  Future<void> addMaintenanceRecord(MaintenanceRecord record) async {
    await isar.writeTxn(() async {
      await isar.maintenanceRecords.put(record);
    });
  }

  // --- Record Maintenance and Update Component Target --- 
  Future<void> recordMaintenanceAndUpdateTarget(
    MaintenanceComponent component, {
    required double currentMileage, // Current vehicle mileage when maintenance was done
    required DateTime maintenanceDate, // Actual date maintenance was done
    required bool recalculateNextTarget, // User choice from dialog
  }) async {
    await isar.writeTxn(() async {
      // 1. Update the component's last maintenance date
      component.lastMaintenance = maintenanceDate;

      // 2. Recalculate target if requested
      if (recalculateNextTarget) {
        if (component.maintenanceType == 'mileage') {
          // For mileage, next target is current mileage + cycle value
          component.targetMaintenanceMileage = currentMileage + component.maintenanceValue;
          component.targetMaintenanceDate = null; // Clear date target if it exists
        } else { // Date type
          // For date, next target is maintenance date + cycle value (days)
          component.targetMaintenanceDate = maintenanceDate.add(Duration(days: component.maintenanceValue.toInt()));
          component.targetMaintenanceMileage = null; // Clear mileage target if it exists
        }
      } // No 'else' needed as caller handles deletion if recalculateNextTarget is false

      // 3. Save the updated component
      // Only save if recalculateNextTarget was true
      if (recalculateNextTarget) {
         await isar.maintenanceComponents.put(component);
      }
    });
  }

  // --- Get Maintenance Records ---
  /// Fetches maintenance records, optionally filtered by vehicle name.
  /// Fetches all records and then filters/sorts in Dart to avoid Isar query builder issues.
  Future<List<MaintenanceRecord>> getMaintenanceRecords({String? vehicleName}) async {
    // 1. Fetch ALL records first
    List<MaintenanceRecord> allRecords = await isar.maintenanceRecords.where().findAll();

    // 2. Filter in Dart if vehicleName is provided
    List<MaintenanceRecord> filteredRecords;
    if (vehicleName != null) {
      filteredRecords = allRecords.where((record) => record.vehicleName == vehicleName).toList();
    } else {
      filteredRecords = allRecords; // No filter needed
    }

    // 3. Sort the filtered list in Dart by date descending
    filteredRecords.sort((a, b) => b.maintenanceDate.compareTo(a.maintenanceDate));

    return filteredRecords;
  }

  /// Deletes all maintenance records associated with a specific vehicle name.
  /// Returns the number of records deleted.
  Future<int> deleteRecordsByVehicle(String vehicleName) async {
    final recordsToDelete = await isar.maintenanceRecords
        .filter()
        .vehicleNameEqualTo(vehicleName)
        .findAll();

    if (recordsToDelete.isNotEmpty) {
      final List<Id> idsToDelete = recordsToDelete.map((r) => r.isarId).toList();
      return await isar.maintenanceRecords.deleteAll(idsToDelete);
    } else {
      return 0;
    }
  }
}
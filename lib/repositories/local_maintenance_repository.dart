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
        .vehicleIndexEqualTo(vehicleName)
        .findAll();
  }

  // --- Delete Component ---
  /// Deletes a maintenance component by its Isar ID.
  Future<void> deleteComponent(int componentId) async {
    await isar.writeTxn(() async {
      await isar.maintenanceComponents.delete(componentId);
    });
  }

  /// Deletes all maintenance components associated with a specific vehicle name.
  /// Returns the number of components deleted.
  /// If createTransaction is false, assumes this is called from within an existing transaction
  Future<int> deleteComponentsByVehicle(String vehicleName, {bool createTransaction = true}) async {
    final componentsToDelete = await isar.maintenanceComponents
        .filter()
        .vehicleIndexEqualTo(vehicleName)
        .findAll();
    
    if (componentsToDelete.isEmpty) {
      return 0;
    }

    final List<int> idsToDelete = componentsToDelete.map((c) => c.id).toList();
    
    if (createTransaction) {
      return await isar.writeTxn(() async {
        return await isar.maintenanceComponents.deleteAll(idsToDelete);
      });
    } else {
      return await isar.maintenanceComponents.deleteAll(idsToDelete);
    }
  }

  // --- Add Component ---
  Future<MaintenanceComponent> addComponent(MaintenanceComponent component) async {
    final existing = await isar.maintenanceComponents
                              .filter()
                              .vehicleIndexEqualTo(component.vehicle)
                              .nameEqualTo(component.name)
                              .findFirst();
    if (existing != null) {
      throw Exception('添加失败：该车辆下已存在同名的保养项目。');
    }
    
    await isar.writeTxn(() async {
      await isar.maintenanceComponents.put(component);
    });
    return component; 
  }

  // --- Update Component ---
  /// Updates an existing maintenance component in the database.
  /// IMPORTANT: This only updates basic info and cycle value.
  /// Target mileage/date recalculation happens during the 'Maintain' action.
  Future<MaintenanceComponent> updateComponent(MaintenanceComponent component) async {
    final existing = await isar.maintenanceComponents.get(component.id);
    if (existing == null) {
      throw Exception("Cannot update component: Not found in local database.");
    }
    
    if (component.name != existing.name) {
        final conflicting = await isar.maintenanceComponents
                                  .filter()
                                  .vehicleIndexEqualTo(component.vehicle)
                                  .nameEqualTo(component.name)
                                  .findFirst();
        if (conflicting != null) {
             throw Exception('更新失败：该车辆下已存在同名的保养项目。');
        }
    }

    await isar.writeTxn(() async {
      await isar.maintenanceComponents.put(component);
    });
    return component;
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
      component.lastMaintenance = maintenanceDate;

      if (recalculateNextTarget) {
        if (component.maintenanceType == 'mileage') {
          component.targetMaintenanceMileage = currentMileage + component.maintenanceValue;
          component.targetMaintenanceDate = null;
        } else {
          component.targetMaintenanceDate = maintenanceDate.add(Duration(days: component.maintenanceValue.toInt()));
          component.targetMaintenanceMileage = null;
        }
      }

      if (recalculateNextTarget) {
         await isar.maintenanceComponents.put(component);
      }
    });
  }

  // --- Get Maintenance Records ---
  /// Fetches maintenance records, optionally filtered by vehicle name.
  /// Fetches all records and then filters/sorts in Dart to avoid Isar query builder issues.
  Future<List<MaintenanceRecord>> getMaintenanceRecords({String? vehicleName}) async {
    List<MaintenanceRecord> allRecords = await isar.maintenanceRecords.where().findAll();

    List<MaintenanceRecord> filteredRecords;
    if (vehicleName != null) {
      filteredRecords = allRecords.where((record) => record.vehicleName == vehicleName).toList();
    } else {
      filteredRecords = allRecords;
    }

    filteredRecords.sort((a, b) => b.maintenanceDate.compareTo(a.maintenanceDate));

    return filteredRecords;
  }

  /// Deletes all maintenance records associated with a specific vehicle name.
  /// Returns the number of records deleted.
  /// If createTransaction is false, assumes this is called from within an existing transaction
  Future<int> deleteRecordsByVehicle(String vehicleName, {bool createTransaction = true}) async {
    final recordsToDelete = await isar.maintenanceRecords
        .filter()
        .vehicleIndexEqualTo(vehicleName)
        .findAll();

    if (recordsToDelete.isEmpty) {
      return 0;
    }

    final List<int> idsToDelete = recordsToDelete.map((r) => r.id).toList();
    
    if (createTransaction) {
      return await isar.writeTxn(() async {
        return await isar.maintenanceRecords.deleteAll(idsToDelete);
      });
    } else {
      return await isar.maintenanceRecords.deleteAll(idsToDelete);
    }
  }

  Future<int> deleteRecordsByComponent(String componentId) async {
    final recordsToDelete = await isar.maintenanceRecords
        .filter()
        .componentIdEqualTo(componentId)
        .findAll();

    if (recordsToDelete.isNotEmpty) {
      return await isar.writeTxn(() async {
         final List<int> idsToDelete = recordsToDelete.map((r) => r.id).toList();
         return await isar.maintenanceRecords.deleteAll(idsToDelete);
      });
    } else {
      return 0;
    }
  }

  /// 删除单条保养记录
  Future<bool> deleteRecord(int recordId) async {
    return await isar.writeTxn(() async {
      return await isar.maintenanceRecords.delete(recordId);
    });
  }
}
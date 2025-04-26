import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

part 'maintenance_record_model.g.dart'; // Isar code generation

@collection
class MaintenanceRecord {
  Id id = Isar.autoIncrement;

  // Keep original fields, ensure types match Isar needs
  String vehicleName;
  String componentId; // Might change to IsarLink later if needed
  String componentName;
  DateTime maintenanceDate;
  double? mileageAtMaintenance;
  String? notes;

  // Add indexes for potential queries
  @Index() // Update Index annotation for Isar v4
  String get vehicleIndex => vehicleName;

  @Index() // Update Index annotation for Isar v4
  String get componentIdIndex => componentId;

  // Constructor without ID
  MaintenanceRecord({
    // required this.id, // Removed
    required this.vehicleName,
    required this.componentId,
    required this.componentName,
    required this.maintenanceDate,
    this.mileageAtMaintenance,
    this.notes,
  });

  // Remove fromJson factory
  /*
  factory MaintenanceRecord.fromJson(Map<String, dynamic> json) {
     // ... implementation ...
  }
  */

  // Remove toJson method
  /*
  Map<String, dynamic> toJson() {
     // ... implementation ...
  }
  */

  // Keep formattedDate helper
  String get formattedDate {
    return DateFormat('yyyy-MM-dd').format(maintenanceDate);
  }
} 
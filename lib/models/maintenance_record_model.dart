import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

part 'maintenance_record_model.g.dart'; // Isar code generation

@Collection()
class MaintenanceRecord {
  Id isarId = Isar.autoIncrement;

  // Keep original fields, ensure types match Isar needs
  late String vehicleName;
  late String componentId; // Might change to IsarLink later if needed
  late String componentName;
  late DateTime maintenanceDate;
  double? mileageAtMaintenance;
  String? notes;

  // Add indexes for potential queries
  @Index(type: IndexType.value)
  String get vehicleIndex => vehicleName;

  @Index(type: IndexType.value)
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
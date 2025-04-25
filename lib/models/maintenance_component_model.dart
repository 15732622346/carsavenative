import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'maintenance_component_model.g.dart'; // Isar code generation

// Define the MaintenanceStatus enum here
enum MaintenanceStatus {
  good, // 状态良好
  attention, // 注意观察 (例如，接近保养)
  warning, // 需要保养 (到期或超期)
  unknown // 无法确定状态 (例如，缺少数据)
}

@Collection()
class MaintenanceComponent {
  Id isarId = Isar.autoIncrement;

  late String name;
  late String vehicle; // Vehicle name or potentially link via IsarLink later
  late String maintenanceType; // 'mileage' or 'date'
  late double maintenanceValue; // Interval in km or days
  double? targetMaintenanceMileage; // Changed from DateTime? to double?
  DateTime? targetMaintenanceDate;
  late String unit;
  DateTime? lastMaintenance;

  // Define indexes for querying
  @Index(type: IndexType.value) // Index vehicle name for filtering
  String get vehicleIndex => vehicle;

  @Index(type: IndexType.value) // Index type for potential filtering
  String get typeIndex => maintenanceType;

  // Constructor for creating new instances
  MaintenanceComponent({
    required this.name,
    required this.vehicle,
    required this.maintenanceType,
    required this.maintenanceValue,
    required this.unit,
    this.targetMaintenanceMileage,
    this.targetMaintenanceDate,
    this.lastMaintenance,
  });

  // --- REMOVED/COMMENTED OUT fromJson factory ---
  /*
  factory MaintenanceComponent.fromJson(Map<String, dynamic> json) {
    return MaintenanceComponent(
      name: json['name'] ?? 'Unknown Name',
      vehicle: json['vehicle'] ?? 'Unknown Vehicle',
      maintenanceType: json['maintenanceType'] ?? 'unknown',
      maintenanceValue: (json['maintenanceValue'] as num?)?.toDouble() ?? 0.0,
      unit: json['unit'] ?? (json['maintenanceType'] == 'mileage' ? 'km' : 'days'),
      // Handle potential string or double for target mileage
      targetMaintenanceMileage: json['targetMaintenanceMileage'] != null
          ? (json['targetMaintenanceMileage'] is String
              ? double.tryParse(json['targetMaintenanceMileage'])
              : (json['targetMaintenanceMileage'] as num?)?.toDouble())
          : null,
      targetMaintenanceDate: json['targetMaintenanceDate'] != null
          ? DateTime.tryParse(json['targetMaintenanceDate'])
          : null,
      lastMaintenance: json['lastMaintenance'] != null
          ? DateTime.tryParse(json['lastMaintenance'])
          : null,
    );
    // Note: isarId is NOT handled here.
  }
  */

  // --- REMOVED/COMMENTED OUT toJson method ---
  /*
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'vehicle': vehicle,
      'maintenanceType': maintenanceType,
      'maintenanceValue': maintenanceValue,
      'targetMaintenanceMileage': targetMaintenanceMileage, // Send as double?
      'targetMaintenanceDate': targetMaintenanceDate?.toIso8601String(),
      'unit': unit,
      'lastMaintenance': lastMaintenance?.toIso8601String(),
      // DO NOT include 'isarId' here
    };
  }
  */

  // --- UI Helper Methods ---
  // Updated calculation logic based on target values and external current state

  /// Calculates the maintenance progress percentage (0.0 to 1.0).
  /// Requires the current vehicle mileage. Manufacturing date no longer needed here.
  double getPercentage(double currentMileage) {
    if (maintenanceType == 'mileage') {
      if (targetMaintenanceMileage == null || targetMaintenanceMileage! <= 0 || maintenanceValue <= 0) return 0.0;
      // Calculate percentage based on progress within the *current cycle* 
      // Assuming targetMaintenanceMileage was calculated correctly based on lastMaintenance + cycle
      // This might need adjustment based on how targets are set/reset
      double startMileageOfCurrentCycle = targetMaintenanceMileage! - maintenanceValue;
      double cycleLength = maintenanceValue;
      double progressInCycle = currentMileage - startMileageOfCurrentCycle; 
      return (progressInCycle / cycleLength).clamp(0.0, 1.0);
    } else if (maintenanceType == 'date') {
      if (targetMaintenanceDate == null || lastMaintenance == null) return 0.0;
      final totalDuration = targetMaintenanceDate!.difference(lastMaintenance!).inDays;
      if (totalDuration <= 0) return 1.0; 
      final elapsedDuration = DateTime.now().difference(lastMaintenance!).inDays;
      return (elapsedDuration / totalDuration).clamp(0.0, 1.0);
    }
    return 0.0;
  }

  /// Returns a status indicating remaining mileage/days or overdue status.
  /// Requires the current vehicle mileage. 
  MaintenanceStatus getStatus(double currentMileage, DateTime? manufacturingDate /* Keep param for now, might remove */) {
     final mileageAttentionThreshold = maintenanceValue * 0.1; 
     const dateAttentionThresholdDays = 15;

     if (maintenanceType == 'mileage') {
      if (targetMaintenanceMileage == null) return MaintenanceStatus.unknown;
      final remaining = targetMaintenanceMileage! - currentMileage;
      if (remaining <= 0) {
        return MaintenanceStatus.warning;
      } else if (remaining <= mileageAttentionThreshold) {
        return MaintenanceStatus.attention;
      }
      return MaintenanceStatus.good;
    } else if (maintenanceType == 'date') {
       if (targetMaintenanceDate == null) return MaintenanceStatus.unknown;
      final remainingDays = targetMaintenanceDate!.difference(DateTime.now()).inDays;
       if (remainingDays <= 0) {
         return MaintenanceStatus.warning;
       } else if (remainingDays <= dateAttentionThresholdDays) {
         return MaintenanceStatus.attention;
       }
       return MaintenanceStatus.good;
     }
     return MaintenanceStatus.unknown;
  }

  /// Determines the progress bar color based on the status.
  Color getProgressColor(MaintenanceStatus status) {
    switch (status) {
      case MaintenanceStatus.warning:
        return Colors.red;
      case MaintenanceStatus.attention:
        return Colors.orange;
      case MaintenanceStatus.good:
        return Colors.green;
      case MaintenanceStatus.unknown:
        return Colors.grey; // Color for unknown status
    }
  }

  /// Creates a copy of the MaintenanceComponent object with optional updated properties.
  MaintenanceComponent copyWith({
    // Id? isarId, // Isar ID is not typically copied
    String? name,
    String? vehicle,
    String? maintenanceType,
    double? maintenanceValue,
    double? targetMaintenanceMileage,
    DateTime? targetMaintenanceDate,
    String? unit,
    DateTime? lastMaintenance,
  }) {
    final newComponent = MaintenanceComponent(
      name: name ?? this.name,
      vehicle: vehicle ?? this.vehicle,
      maintenanceType: maintenanceType ?? this.maintenanceType,
      maintenanceValue: maintenanceValue ?? this.maintenanceValue,
      targetMaintenanceMileage: targetMaintenanceMileage ?? this.targetMaintenanceMileage,
      targetMaintenanceDate: targetMaintenanceDate ?? this.targetMaintenanceDate,
      unit: unit ?? this.unit,
      lastMaintenance: lastMaintenance ?? this.lastMaintenance,
    );
    // newComponent.isarId = this.isarId; // Don't copy Isar ID
    return newComponent;
  }
}
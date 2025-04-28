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

@collection
class MaintenanceComponent {
  Id id = Isar.autoIncrement;

  String name;
  String vehicle; // Vehicle name or potentially link via IsarLink later
  String maintenanceType; // 'mileage' or 'date'
  double maintenanceValue; // Interval in km or days
  double? targetMaintenanceMileage; // Changed from DateTime? to double?
  DateTime? targetMaintenanceDate;
  String unit;
  DateTime? lastMaintenance;

  // Define indexes for querying
  @Index() // Update Index annotation for Isar v4
  String get vehicleIndex => vehicle;

  @Index() // Update Index annotation for Isar v4
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
     // 使用固定阈值，与MaintenanceProgressPainter保持一致
     const double mileageAttentionThreshold = 100.0;
     const double dateAttentionThresholdDays = 15.0;

     if (maintenanceType == 'mileage') {
      if (targetMaintenanceMileage == null) {
        debugPrint('组件[$name]: 无目标里程，返回未知状态');
        return MaintenanceStatus.unknown;
      }
      
      final remaining = targetMaintenanceMileage! - currentMileage;
      
      debugPrint('组件[$name] 里程状态计算: 目标=${targetMaintenanceMileage}, 当前=$currentMileage, 剩余=$remaining, 警告阈值=$mileageAttentionThreshold');
      
      if (remaining <= 0) {
        debugPrint('组件[$name]: 已超出目标里程，需要保养');
        return MaintenanceStatus.warning;
      } else if (remaining <= mileageAttentionThreshold) {
        debugPrint('组件[$name]: 接近目标里程，注意观察');
        return MaintenanceStatus.attention;
      }
      
      debugPrint('组件[$name]: 状态良好');
      return MaintenanceStatus.good;
    } else if (maintenanceType == 'date') {
       if (targetMaintenanceDate == null) {
         debugPrint('组件[$name]: 无目标日期，返回未知状态');
         return MaintenanceStatus.unknown;
       }
      
      final remainingDays = targetMaintenanceDate!.difference(DateTime.now()).inDays;
      
      debugPrint('组件[$name] 日期状态计算: 目标=${targetMaintenanceDate}, 当前=${DateTime.now()}, 剩余天数=$remainingDays, 警告阈值=$dateAttentionThresholdDays');
      
       if (remainingDays <= 0) {
         debugPrint('组件[$name]: 已超出目标日期，需要保养');
         return MaintenanceStatus.warning;
       } else if (remainingDays <= dateAttentionThresholdDays) {
         debugPrint('组件[$name]: 接近目标日期，注意观察');
         return MaintenanceStatus.attention;
       }
       
       debugPrint('组件[$name]: 状态良好');
       return MaintenanceStatus.good;
     }
     
     debugPrint('组件[$name]: 未识别的保养类型: $maintenanceType');
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
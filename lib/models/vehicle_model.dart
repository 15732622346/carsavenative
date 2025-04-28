import 'package:isar/isar.dart'; // Add Isar import

part 'vehicle_model.g.dart'; // Add part directive

@collection
class Vehicle {
  Id id = Isar.autoIncrement;

  // final String id; // Keep original ID for reference if needed, but not indexed by Isar
  String name;
  int year;
  int mileage;
  DateTime? manufacturingDate;
  String? image;
  String? plateNumber;  // 添加车牌号字段以兼容原版本

  Vehicle({
    // required this.id, // Remove original ID from constructor if not used
    required this.name,
    required this.year,
    required this.mileage,
    this.manufacturingDate,
    this.image,
    this.plateNumber,
  });

  // --- REMOVED/COMMENTED OUT fromJson factory ---
  /*
  factory Vehicle.fromJson(Map<String, dynamic> json) {
    // Use tryParse for robustness
    DateTime? parsedDate;
    if (json['manufacturingDate'] != null) {
      parsedDate = DateTime.tryParse(json['manufacturingDate']);
    }

    // Extract year from date if date exists, otherwise use year field if present
    int yearFromJson = json['year'] ?? (parsedDate?.year ?? 0); // Default to 0 if neither exists

    return Vehicle(
      // id: id ?? this.id, // Remove original ID
      name: json['name'] ?? 'Unknown Name',
      year: yearFromJson,
      mileage: (json['mileage'] as num?)?.toInt() ?? 0,
      manufacturingDate: parsedDate,
      image: json['image'],
      plateNumber: json['plateNumber'],
    );
    // Note: isarId is NOT handled here.
  }
  */

  // --- REMOVED/COMMENTED OUT toJson method ---
  /*
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'year': year,
      'mileage': mileage,
      'manufacturingDate': manufacturingDate?.toIso8601String(),
      'image': image,
      'plateNumber': plateNumber,
      // DO NOT include 'isarId' here
    };
  }
  */

  // 创建Vehicle对象的副本并更新属性
  Vehicle copyWith({
    // String? id, // Remove original ID
    String? name,
    int? year,
    int? mileage,
    DateTime? manufacturingDate,
    String? image,
    String? plateNumber,
  }) {
    final newManufacturingDate = manufacturingDate ?? this.manufacturingDate;
    final newYear = year ?? (newManufacturingDate?.year ?? this.year);

    final result = Vehicle(
      name: name ?? this.name,
      year: newYear,
      mileage: mileage ?? this.mileage,
      manufacturingDate: newManufacturingDate,
      image: image ?? this.image,
      plateNumber: plateNumber ?? this.plateNumber,
    );
    
    // 保留原始ID
    result.id = this.id;
    
    return result;
  }
} 
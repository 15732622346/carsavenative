import '../models/maintenance_component_model.dart';

class MockDataService {
  static const String baseUrl = 'http://localhost:3000'; // 模拟服务器地址

  // 模拟数据存储
  static final Map<String, dynamic> _mockComponents = {};
  static final Map<String, dynamic> _mockMaintenanceRecords = {};

  // 添加新的保养组件
  Future<MaintenanceComponent> addComponent(Map<String, dynamic> componentData) async {
    try {
      // 验证必需字段
      final requiredFields = ['name', 'vehicle', 'maintenanceType', 'maintenanceValue'];
      for (final field in requiredFields) {
        if (componentData[field] == null) {
          throw Exception('Missing required component data: $field');
        }
      }

      // 验证 maintenanceValue
      final maintenanceValue = double.tryParse(componentData['maintenanceValue'].toString());
      if (maintenanceValue == null || maintenanceValue <= 0) {
        throw Exception('Invalid maintenanceValue. Must be a positive number.');
      }

      // 根据保养类型设置单位和验证目标值
      String unit;
      if (componentData['maintenanceType'] == 'mileage') {
        unit = 'km';
        if (componentData['targetMaintenanceMileage'] == null) {
          throw Exception("Missing targetMaintenanceMileage for type 'mileage'");
        }
        final targetMileage = double.tryParse(componentData['targetMaintenanceMileage'].toString());
        if (targetMileage == null) {
          throw Exception('Invalid targetMaintenanceMileage. Must be a number.');
        }
        componentData.remove('targetMaintenanceDate');
      } else if (componentData['maintenanceType'] == 'date') {
        unit = 'days';
        if (componentData['targetMaintenanceDate'] == null) {
          throw Exception("Missing targetMaintenanceDate for type 'date'");
        }
        try {
          DateTime.parse(componentData['targetMaintenanceDate']);
        } catch (e) {
          throw Exception('Invalid targetMaintenanceDate format. Must be ISO string.');
        }
        componentData.remove('targetMaintenanceMileage');
      } else {
        throw Exception("Invalid maintenanceType. Must be 'mileage' or 'date'.");
      }

      // 设置时间戳和初始值
      final now = DateTime.now();
      componentData['unit'] = unit;
      componentData['created_at'] = now.toIso8601String();
      componentData['updated_at'] = now.toIso8601String();
      componentData['lastMaintenance'] = now.toIso8601String();

      // 生成唯一ID
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      componentData['id'] = id;

      // 存储到模拟数据中
      _mockComponents[id] = componentData;

      // 返回创建的组件
      return MaintenanceComponent.fromJson(componentData);
    } catch (e) {
      throw Exception('Error adding maintenance component: $e');
    }
  }

  // 标记组件为已保养
  Future<MaintenanceComponent> markComponentAsMaintained(String componentId, double currentMileage) async {
    try {
      if (currentMileage < 0) {
        throw Exception('Invalid currentMileage. Must be a non-negative number.');
      }

      final component = _mockComponents[componentId];
      if (component == null) {
        throw Exception('Maintenance component not found');
      }

      final maintenanceType = component['maintenanceType'];
      final maintenanceValue = double.parse(component['maintenanceValue'].toString());
      final now = DateTime.now();

      Map<String, dynamic> updateData = {
        'lastMaintenance': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };

      if (maintenanceType == 'mileage') {
        final newTargetMileage = currentMileage + maintenanceValue;
        updateData['targetMaintenanceMileage'] = newTargetMileage;
      } else if (maintenanceType == 'date') {
        final newTargetDate = now.add(Duration(days: maintenanceValue.toInt()));
        updateData['targetMaintenanceDate'] = newTargetDate.toIso8601String();
      } else {
        throw Exception('Unknown maintenance type in component data.');
      }

      // 更新组件数据
      _mockComponents[componentId] = {...component, ...updateData};

      // 添加保养记录
      final recordData = {
        'componentId': componentId,
        'vehicleId': component['vehicleId'],
        'vehicleName': component['vehicle'],
        'componentName': component['name'],
        'maintenanceDate': now.toIso8601String(),
        'maintenanceMileage': currentMileage,
        'created_at': now.toIso8601String(),
      };
      _mockMaintenanceRecords[DateTime.now().millisecondsSinceEpoch.toString()] = recordData;

      // 返回更新后的组件
      return MaintenanceComponent.fromJson(_mockComponents[componentId]);
    } catch (e) {
      throw Exception('Error marking component as maintained: $e');
    }
  }

  // 获取所有保养组件
  Future<List<MaintenanceComponent>> getAllComponents() async {
    return _mockComponents.values
        .map((data) => MaintenanceComponent.fromJson(data))
        .toList();
  }

  // 根据车辆获取保养组件
  Future<List<MaintenanceComponent>> getComponentsByVehicle(String vehicleName) async {
    return _mockComponents.values
        .where((data) => data['vehicle'] == vehicleName)
        .map((data) => MaintenanceComponent.fromJson(data))
        .toList();
  }

  // 删除保养组件
  Future<void> deleteComponent(String componentId) async {
    if (!_mockComponents.containsKey(componentId)) {
      throw Exception('Maintenance component not found');
    }
    _mockComponents.remove(componentId);
  }
} 
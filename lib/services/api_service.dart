import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/vehicle_model.dart';
import '../models/maintenance_component_model.dart';
import '../models/user_model.dart';

/// API服务类，用于与后端API交互
class ApiService {
  // 单例模式
  static final ApiService _instance = ApiService._internal();
  
  factory ApiService() {
    return _instance;
  }
  
  ApiService._internal();

  // API基础URL
  final String baseUrl = 'http://localhost:5001/demo-carsave/us-central1/api'; // Functions 模拟器地址

  // 用于HTTP请求的客户端
  final http.Client _client = http.Client();

  // 获取当前用户信息
  Future<User> getCurrentUser() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/users/current'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('获取用户信息失败: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('获取用户信息错误: $e');
    }
  }

  // 获取所有车辆
  Future<List<Vehicle>> getAllVehicles() async {
    print('ApiService.getAllVehicles called but is disabled due to Isar migration.');
    throw UnimplementedError('ApiService.getAllVehicles disabled due to Isar migration');
  }

  // 获取单个车辆详情
  Future<Vehicle> getVehicle(String id) async {
    print('ApiService.getVehicle called but is disabled due to Isar migration.');
    throw UnimplementedError('ApiService.getVehicle disabled due to Isar migration');
  }

  // 添加新车辆
  Future<Vehicle> addVehicle(Vehicle vehicle) async {
    print('ApiService.addVehicle called but is disabled due to Isar migration.');
    throw UnimplementedError('ApiService.addVehicle disabled due to Isar migration');
  }

  // 更新车辆信息
  Future<Vehicle> updateVehicle(Vehicle vehicle) async {
    print('ApiService.updateVehicle called but is disabled due to Isar migration.');
    throw UnimplementedError('ApiService.updateVehicle disabled due to Isar migration');
  }

  // 删除车辆
  Future<void> deleteVehicle(String id) async {
    try {
      final response = await _client.delete(
        Uri.parse('$baseUrl/vehicles/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 204) {
        // Attempt to parse error message from backend
        String errorMessage = '删除车辆失败: ${response.statusCode}';
        try {
          final errorBody = json.decode(utf8.decode(response.bodyBytes));
          if (errorBody is Map && errorBody['message'] != null) {
            errorMessage = '删除车辆失败: ${errorBody['message']}';
          } else if (response.body.isNotEmpty) {
             errorMessage = '删除车辆失败: ${utf8.decode(response.bodyBytes)}';
          }
        } catch (_) {}
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('删除车辆错误: $e');
    }
  }

  // 获取所有保养组件
  Future<List<MaintenanceComponent>> getAllComponents() async {
    print('ApiService.getAllComponents called but is disabled due to Isar migration.');
    throw UnimplementedError('ApiService.getAllComponents disabled due to Isar migration');
  }

  // 获取特定车辆的保养组件
  Future<List<MaintenanceComponent>> getComponentsByVehicle(String vehicleName) async {
    print('ApiService.getComponentsByVehicle called but is disabled due to Isar migration.');
    throw UnimplementedError('ApiService.getComponentsByVehicle disabled due to Isar migration');
  }

  // 更新保养组件 (使用 Map 数据) - 这个方法本身没问题，但如果调用处依赖fromJson返回结果则会出错
  Future<void> updateComponentMap(String id, Map<String, dynamic> componentData) async {
    try {
      final response = await _client.put(
        Uri.parse('$baseUrl/maintenance_components/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(componentData),
      );

      if (response.statusCode != 200) {
        // Handle specific 409 Conflict for duplicate name
        if (response.statusCode == 409) {
          // Try to parse backend message, fallback to default
          String backendMessage = "该车辆下已存在同名组件";
          try {
            final errorBody = json.decode(utf8.decode(response.bodyBytes)); 
            if (errorBody is String && errorBody.isNotEmpty) {
               backendMessage = errorBody; // Use backend message directly
            } else if (errorBody is Map && errorBody['message'] != null) {
              backendMessage = errorBody['message'];
            }
          } catch (_) {}
          // Use a slightly more specific message for update vs add
          throw Exception('更新失败：$backendMessage'); 
        }

        // Handle other errors
        String errorMessage = '更新保养组件失败: ${response.statusCode}';
        try {
          final errorBody = json.decode(utf8.decode(response.bodyBytes)); 
          if (errorBody is String) {
             errorMessage = '更新保养组件失败: $errorBody';
          } else if (errorBody is Map && errorBody['message'] != null) {
            errorMessage = '更新保养组件失败: ${errorBody['message']}';
          } else if (response.body.isNotEmpty) {
             errorMessage = '更新保养组件失败: ${utf8.decode(response.bodyBytes)}';
          }
        } catch (_) {}
        throw Exception(errorMessage);
      }
    } catch (e) {
      // Rethrow specific formatted errors or a generic one
      if (e.toString().contains('更新失败：')) { 
          rethrow;
      }
      throw Exception('更新保养组件时发生网络或未知错误: $e');
    }
  }

  // 添加保养组件 (使用 Map 数据) - 这个方法本身没问题，但如果调用处依赖fromJson返回结果则会出错
  Future<void> addComponentMap(Map<String, dynamic> componentData) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/maintenance_components'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(componentData),
      );

      if (response.statusCode != 201) {
         // Handle specific 409 Conflict for duplicate name
        if (response.statusCode == 409) {
          String backendMessage = "该车辆下已存在同名组件";
          try {
            final errorBody = json.decode(utf8.decode(response.bodyBytes)); 
            if (errorBody is String && errorBody.isNotEmpty) {
               backendMessage = errorBody; 
            } else if (errorBody is Map && errorBody['message'] != null) {
              backendMessage = errorBody['message'];
            }
          } catch (_) {}
          throw Exception('添加失败：$backendMessage'); 
        }

        // Handle other errors
        String errorMessage = '添加保养组件失败: ${response.statusCode}';
        try {
          final errorBody = json.decode(utf8.decode(response.bodyBytes));
          if (errorBody is String) {
             errorMessage = '添加保养组件失败: $errorBody';
          } else if (errorBody is Map && errorBody['message'] != null) {
            errorMessage = '添加保养组件失败: ${errorBody['message']}';
          } else if (response.body.isNotEmpty) {
             errorMessage = '添加保养组件失败: ${utf8.decode(response.bodyBytes)}';
          }
        } catch (_) {}
        throw Exception(errorMessage);
      }
    } catch (e) {
      // Rethrow specific formatted errors or a generic one
       if (e.toString().contains('添加失败：')) { 
          rethrow;
      }
      throw Exception('添加保养组件时发生网络或未知错误: $e');
    }
  }

  // --- 添加一个使用完整对象的方法，并禁用它 ---
  Future<MaintenanceComponent> addComponent(MaintenanceComponent component) async {
    print('ApiService.addComponent(MaintenanceComponent) called but is disabled due to Isar migration.');
    throw UnimplementedError('ApiService.addComponent(MaintenanceComponent) disabled due to Isar migration. Use addComponentMap instead if needed.');
  }

  // --- 添加一个使用完整对象的方法，并禁用它 ---
  Future<MaintenanceComponent> updateComponent(MaintenanceComponent component) async {
     print('ApiService.updateComponent(MaintenanceComponent) called but is disabled due to Isar migration.');
    throw UnimplementedError('ApiService.updateComponent(MaintenanceComponent) disabled due to Isar migration. Use updateComponentMap instead if needed.');
  }

  // 删除保养组件
  Future<void> deleteComponent(String id) async {
    try {
      final response = await _client.delete(
        Uri.parse('$baseUrl/maintenance_components/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 204) {
        // 尝试解析错误信息
        String errorMessage = '删除保养组件失败: ${response.statusCode}';
         try {
           final errorBody = json.decode(utf8.decode(response.bodyBytes));
           if (errorBody is String) {
             errorMessage = '删除保养组件失败: $errorBody';
           } else if (errorBody is Map && errorBody['message'] != null) {
             errorMessage = '删除保养组件失败: ${errorBody['message']}';
           } else if (response.body.isNotEmpty) {
             errorMessage = '删除保养组件失败: ${utf8.decode(response.bodyBytes)}';
           }
         } catch (_) { /* 忽略解析错误 */ }
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('删除保养组件错误: $e');
    }
  }

  // --- NEW: Maintenance Record Methods ---

  // Add a new maintenance record
  Future<void> addMaintenanceRecord(Map<String, dynamic> recordData) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/maintenance_records'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(recordData),
      );

      if (response.statusCode != 201) {
        // Handle error
        String errorMessage = '添加保养记录失败: ${response.statusCode}';
        try {
          final errorBody = json.decode(utf8.decode(response.bodyBytes));
           if (errorBody is String) {
             errorMessage = '添加保养记录失败: $errorBody';
          } else if (errorBody is Map && errorBody['message'] != null) {
            errorMessage = '添加保养记录失败: ${errorBody['message']}';
          } else if (response.body.isNotEmpty) {
             errorMessage = '添加保养记录失败: ${utf8.decode(response.bodyBytes)}';
          }
        } catch (_) {}
        throw Exception(errorMessage);
      }
      // Success, no return value needed
    } catch (e) {
      throw Exception('添加保养记录错误: $e');
    }
  }

  // Get maintenance records, optionally filtered by vehicle name
  Future<List<Map<String, dynamic>>> getMaintenanceRecords({String? vehicleName}) async {
     try {
      String url = '$baseUrl/maintenance_records';
      if (vehicleName != null && vehicleName.isNotEmpty) {
        // Ensure the query parameter name matches the backend ('vehicleName')
        url += '?vehicleName=${Uri.encodeComponent(vehicleName)}'; 
      }
      
      final response = await _client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // The backend returns a List<Map<String, dynamic>>
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        // Ensure each item in the list is cast to the expected type
        return data.map((item) => Map<String, dynamic>.from(item)).toList();
      } else {
        // Handle error
         String errorMessage = '获取保养记录失败: ${response.statusCode}';
         try {
           final errorBody = json.decode(utf8.decode(response.bodyBytes));
            if (errorBody is String) {
             errorMessage = '获取保养记录失败: $errorBody';
           } else if (errorBody is Map && errorBody['message'] != null) {
             errorMessage = '获取保养记录失败: ${errorBody['message']}';
           } else if (response.body.isNotEmpty) {
              errorMessage = '获取保养记录失败: ${utf8.decode(response.bodyBytes)}';
           }
         } catch (_) {}
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('获取保养记录错误: $e');
    }
  }

  // Mark component as maintained (modified to accept flag and currentMileage)
  Future<void> markComponentAsMaintained(String id, {required double currentMileage, bool recalculateNextTarget = true}) async {
    try {
      final response = await _client.patch(
        Uri.parse('$baseUrl/maintenance_components/$id/maintain'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'currentMileage': currentMileage, // Pass currentMileage from parameter
          'recalculateNextTarget': recalculateNextTarget, // Pass the flag
        }),
      );
      if (response.statusCode != 200) {
         // Handle error (similar to other methods)
         String errorMessage = '标记保养完成失败: ${response.statusCode}';
          try {
            final errorBody = json.decode(utf8.decode(response.bodyBytes));
             if (errorBody is String) {
              errorMessage = '标记保养完成失败: $errorBody';
            } else if (errorBody is Map && errorBody['message'] != null) {
              errorMessage = '标记保养完成失败: ${errorBody['message']}';
            } else if (response.body.isNotEmpty) {
               errorMessage = '标记保养完成失败: ${utf8.decode(response.bodyBytes)}';
            }
          } catch (_) {}
         throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('标记保养完成错误: $e');
    }
  }

  // --- NEW: Delete a maintenance record ---
  Future<void> deleteMaintenanceRecord(String recordId) async {
    try {
      final response = await _client.delete(
        Uri.parse('$baseUrl/maintenance_records/$recordId'), // Target the specific record ID
        headers: {'Content-Type': 'application/json'},
      );

      // Check for success (204 No Content) or errors (404 Not Found, 500 Server Error, etc.)
      if (response.statusCode != 204) {
        String errorMessage = '删除保养记录失败: ${response.statusCode}';
        try {
          // Attempt to parse error message from response body if available
          final errorBody = json.decode(utf8.decode(response.bodyBytes));
          if (errorBody is String) {
             errorMessage = '删除保养记录失败: $errorBody';
          } else if (errorBody is Map && errorBody['message'] != null) {
            errorMessage = '删除保养记录失败: ${errorBody['message']}';
          } else if (response.body.isNotEmpty) {
            errorMessage = '删除保养记录失败: ${utf8.decode(response.bodyBytes)}';
          }
        } catch (_) {
          // If body parsing fails or body is empty, stick with the status code message
        }
        // Throw specific error codes or a generic message
        if (response.statusCode == 404) {
            throw Exception('删除保养记录失败: 记录未找到 (404)');
        }
        throw Exception(errorMessage);
      }
      // Success: No return value needed for DELETE
    } catch (e) {
      // Rethrow specific errors or a generic one
       if (e.toString().contains('(404)')) {
         rethrow; // Keep the specific 404 message
       }
      throw Exception('删除保养记录时出错: $e');
    }
  }

  // 关闭HTTP客户端
  void dispose() {
    _client.close();
  }
} 
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add import for DateFormat
import '../models/vehicle_model.dart';
// import '../services/api_service.dart'; // Re-remove ApiService import
import 'package:isar/isar.dart'; // Re-add Isar Id import
import '../main.dart'; // Re-add for global isar instance
import '../repositories/local_vehicle_repository.dart'; // Re-add Local Repository import
import 'add_vehicle_screen.dart';
import '../repositories/local_maintenance_repository.dart'; // Import maintenance repo

class VehicleListScreen extends StatefulWidget {
  const VehicleListScreen({Key? key}) : super(key: key);

  @override
  State<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  // final ApiService _apiService = ApiService(); // Re-remove ApiService instance
  late LocalVehicleRepository _vehicleRepository; // Re-add Local Repository
  late LocalMaintenanceRepository _maintenanceRepository; // Add maintenance repo
  List<Vehicle> _vehicles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Re-initialize repository here
    _vehicleRepository = LocalVehicleRepository(isar); 
    _maintenanceRepository = LocalMaintenanceRepository(isar); // Initialize maintenance repo
    _loadVehicles();
  }

  // 显示错误提示框
  Future<void> _showErrorAlert(BuildContext context, String errorMessage) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('加载失败'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('获取车辆数据时发生错误:'),
                const SizedBox(height: 8),
                SelectableText(errorMessage),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('重试'),
              onPressed: () {
                Navigator.of(context).pop();
                _loadVehicles(); // 点击重试时再次调用加载
              },
            ),
            TextButton(
              child: const Text('关闭'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // 加载车辆数据 (Use Repository)
  Future<void> _loadVehicles() async {
    if (!mounted) return; 
    setState(() {
      _isLoading = true;
    });

    try {
      // Fetch vehicles from the local repository
      final vehicles = await _vehicleRepository.getAllVehicles(); 
      if (mounted) {
        setState(() {
          _vehicles = vehicles;
        });
      }
    } catch (e) {
      final String errorMessage = e.toString();
      if (mounted) {
         WidgetsBinding.instance.addPostFrameCallback((_) {
           if (mounted) {
             _showErrorAlert(context, errorMessage);
           }
         });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // 删除车辆 (Use Repository, expect Id)
  // Update delete method to handle related data within a transaction
  Future<void> _deleteVehicleWithComponents(Vehicle vehicle) async {
    // Show confirmation dialog first
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('您确定要删除车辆 "${vehicle.name}" 吗？\n与之关联的所有保养组件也将被删除。此操作不可撤销。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed != true) return; // Exit if not confirmed

    // Perform deletion within a single transaction
    try {
      await isar.writeTxn(() async {
        // 1. Delete associated maintenance components
        await _maintenanceRepository.deleteComponentsByVehicle(vehicle.name);
        // 2. Delete the vehicle itself
        await _vehicleRepository.deleteVehicle(vehicle.id); 
        // 3. Delete associated maintenance records
        await _maintenanceRepository.deleteRecordsByVehicle(vehicle.name);
      });

      // Refresh list after successful deletion
      _loadVehicles(); 
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('车辆 "${vehicle.name}" 及关联组件已删除')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('删除失败: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的车辆'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 导航到添加车辆页面
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddVehicleScreen()),
          ).then((newVehicle) {
            // 如果返回了新车辆数据，则刷新列表
            if (newVehicle != null) {
              _loadVehicles();
            }
          });
        },
        backgroundColor: Colors.redAccent, // Set eye-catching background color
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_vehicles.isEmpty && !_isLoading) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _loadVehicles,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _vehicles.length,
        itemBuilder: (context, index) {
          final vehicle = _vehicles[index];
          return _buildVehicleCard(context, vehicle);
        },
      ),
    );
  }

  // 当没有车辆时显示的界面
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_car_outlined,
            size: 100,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            '暂无车辆',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '点击下方"+"按钮添加您的第一辆车',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // Update _buildVehicleCard to use context for delete and add InkWell
  Widget _buildVehicleCard(BuildContext context, Vehicle vehicle) {
    final String displayDate;
    if (vehicle.manufacturingDate != null) {
      displayDate = DateFormat('yyyy-MM-dd').format(vehicle.manufacturingDate!);
    } else {
      displayDate = '日期未知';
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell( 
        onTap: () {
          // TODO: Navigate to Vehicle Detail Screen
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('导航到车辆: ${vehicle.name} (TODO)')));
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Vehicle Image Placeholder
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                              Icons.directions_car,
                              size: 50,
                              color: Colors.grey[400],
                            ),
                  ),
                  const SizedBox(width: 16),
                  // Vehicle Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicle.name,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${vehicle.mileage.toStringAsFixed(0)} 公里', 
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '出厂: $displayDate',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                        ),
                         if (vehicle.plateNumber != null && vehicle.plateNumber!.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            '车牌: ${vehicle.plateNumber}', 
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                          ),
                         ]
                      ],
                    ),
                  ),
                  // --- REMOVE PopupMenuButton ---
                  /*
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    tooltip: "更多操作",
                    onSelected: (String result) { ... },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[ ... ],
                  ),
                  */
                ],
              ),
              const SizedBox(height: 12), // Add some space before buttons
              const Divider(), // Add a divider
              const SizedBox(height: 8), // Add some space after divider
              // --- ADD Action Buttons Row ---
              Row(
                mainAxisAlignment: MainAxisAlignment.start, // Align buttons to the left
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.speed_outlined, size: 18),
                    label: const Text('更新里程'),
                    onPressed: () => _showUpdateMileageDialog(vehicle),
                    style: TextButton.styleFrom(
                       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    icon: Icon(Icons.delete_outline, size: 18, color: Theme.of(context).colorScheme.error),
                    label: Text('删除车辆', style: TextStyle(color: Theme.of(context).colorScheme.error)),
                    onPressed: () => _deleteVehicleWithComponents(vehicle), 
                    style: TextButton.styleFrom(
                       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // 显示更新里程对话框 (Use Repository)
  void _showUpdateMileageDialog(Vehicle vehicle) {
    final TextEditingController mileageController = TextEditingController(text: vehicle.mileage.toString());
    final formKey = GlobalKey<FormState>();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('更新里程'),
        content: Form(
           key: formKey,
           child: TextFormField(
             controller: mileageController,
             keyboardType: TextInputType.number,
             decoration: const InputDecoration(
               labelText: '当前里程 (公里)',
               hintText: '请输入当前里程',
             ),
             validator: (value) { 
                if (value == null || value.isEmpty) return '里程不能为空';
                final mileage = int.tryParse(value);
                if (mileage == null) return '请输入有效的整数里程';
                if (mileage < vehicle.mileage) return '新里程不能小于当前里程 (${vehicle.mileage})';
                return null;
             },
           ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) {
                 return;
              }
              final newMileage = int.parse(mileageController.text); 
              try {
                // Create the updated vehicle object using copyWith
                final updatedVehicle = vehicle.copyWith(mileage: newMileage);

                // Call repository update method
                await _vehicleRepository.updateVehicle(updatedVehicle);
                
                if (mounted) {
                  Navigator.pop(context);
                  _loadVehicles(); // 刷新列表
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('里程更新成功')),
                  );
                }
              } catch (e) {
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('更新失败: ${e.toString()}')),
                  );
                }
              }
            },
            child: const Text('更新'),
          ),
        ],
      ),
    );
  }

  // --- REMOVE Old Delete Confirm Dialog (if unused) ---
  /* 
  void _showDeleteConfirmDialog(Vehicle vehicle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('您确定要删除 ${vehicle.name} 吗？此操作不可撤销。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteVehicle(vehicle.isarId);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
  */
} 
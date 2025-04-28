import 'package:flutter/material.dart' hide Badge; // Hide Material Badge
// Removed unused import: flutter_localizations
import 'package:shared_preferences/shared_preferences.dart'; // 本地存储
import '../models/vehicle_model.dart'; // 车辆模型
import '../models/maintenance_component_model.dart'; // 保养组件模型
import '../models/maintenance_record_model.dart'; // 保养记录模型
import 'package:collection/collection.dart'; // 用于 firstWhereOrNull
import 'package:intl/intl.dart'; // For date formatting
import 'dart:async'; // 添加Timer导入
// Use alias for the badges package to avoid name collision
import 'package:badges/badges.dart' as badges_pkg;
import 'package:provider/provider.dart'; // 添加Provider导入
import 'notifications_screen.dart'; // Import the new screen
import '../providers/vehicle_list_provider.dart'; // 导入车辆列表Provider
import '../providers/maintenance_provider.dart'; // 导入保养Provider
import '../repositories/local_component_repository.dart';
import '../repositories/local_record_repository.dart';
import '../repositories/local_vehicle_repository.dart';
import '../main.dart'; // Import main.dart to access the global isar instance
// Removed unused import: maintenance_component_screen.dart
// Removed unused import: vehicle_list_screen.dart
// Removed unused imports: isar, provider

class HomeScreen extends StatefulWidget {
  // Use const constructor and super parameters
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

// 改为public类型，去掉下划线
class HomeScreenState extends State<HomeScreen> {
  late SharedPreferences _prefs; // 本地存储实例

  // --- State Variables ---
  Vehicle? _currentVehicle;
  bool _isLoading = false; // 初始值设为false，避免默认就进入加载状态
  String? _error;
  bool _initialDataLoaded = false; // 跟踪是否已加载初始数据
  
  // --- State for derived data ---
  int? _trackedDays;
  DateTime? _lastMaintenanceDate;

  static const String _lastSelectedVehicleIdKey = 'last_selected_isar_id';

  @override
  void initState() {
    super.initState();
    // Initialize SharedPreferences and load data directly
    _initializeAndLoadData();
  }

  Future<void> _initializeAndLoadData() async {
    // Initialize SharedPreferences first
    try {
      debugPrint('【日志】_initializeAndLoadData - 开始初始化SharedPreferences');
      // 先确保不在加载状态
      setState(() {
        _isLoading = false;
      });
      
      _prefs = await SharedPreferences.getInstance();
      debugPrint('【日志】_initializeAndLoadData - SharedPreferences初始化完成');
      
      // 确保只加载一次初始数据
      if (!_initialDataLoaded) {
        _initialDataLoaded = true;
        // 使用延时确保状态已更新
        Future.microtask(() {
          if (mounted) {
            loadInitialData();
          }
        });
      }
    } catch (e) {
      // Handle potential SharedPreferences init error
      debugPrint('【错误】_initializeAndLoadData - 初始化SharedPreferences失败: $e');
      if (mounted) {
         setState(() {
           _isLoading = false;
           _error = "初始化本地存储失败: $e";
         });
      }
    }
  }

  // 改为public方法，去掉下划线
  Future<void> loadInitialData() async {
    if (!mounted) {
      debugPrint('【日志】loadInitialData - 组件已卸载，不执行加载');
      return;
    }
    if (_isLoading) {
      debugPrint('【日志】loadInitialData - 已经在加载中，跳过');
      return; // 防止重复加载
    }

    debugPrint('【日志】loadInitialData - 开始加载数据 ${DateTime.now()}');
    setState(() {
      _isLoading = true;
      _error = null;
    });
    
    // 添加超时保护
    final timeoutTimer = Timer(const Duration(seconds: 10), () {
      if (mounted && _isLoading) {
        debugPrint('【日志】loadInitialData - 加载超时');
        setState(() {
          _isLoading = false;
          _error = "加载超时，请重试";
        });
      }
    });

    try {
      // 使用Provider获取车辆列表
      debugPrint('【日志】loadInitialData - 准备加载车辆列表');
      final vehicleProvider = Provider.of<VehicleListProvider>(context, listen: false);
      await vehicleProvider.loadVehicles();
      final vehicles = vehicleProvider.vehicles;
      debugPrint('【日志】拿到数据了 - 车辆列表加载完成，共${vehicles.length}辆车');
      
      if (!mounted) {
        debugPrint('【日志】loadInitialData - 组件已卸载，中断加载');
        return;
      }

      if (vehicles.isEmpty) {
        debugPrint('【日志】loadInitialData - 没有车辆数据，结束加载');
        setState(() { _isLoading = false; });
        return;
      }

      // Determine current vehicle after loading all vehicles
      final int? lastSelectedId = _prefs.getInt(_lastSelectedVehicleIdKey);
      if (lastSelectedId != null) {
        debugPrint('【日志】loadInitialData - 尝试加载上次选择的车辆ID: $lastSelectedId');
        _currentVehicle = vehicles.firstWhereOrNull((v) => v.id == lastSelectedId);
      }
      // Ensure _currentVehicle is set, defaulting to the first if necessary
      _currentVehicle ??= vehicles.first;
      debugPrint('【日志】拿到数据了 - 当前选择的车辆: ${_currentVehicle?.name}');
      
      // Save the potentially updated current vehicle ID
      await _prefs.setInt(_lastSelectedVehicleIdKey, _currentVehicle!.id);

      // 使用Provider加载组件和记录
      debugPrint('【日志】loadInitialData - 准备加载保养组件');
      final maintenanceProvider = Provider.of<MaintenanceProvider>(context, listen: false);
      
      // 加载当前车辆的组件和记录
      if (_currentVehicle != null) {
        debugPrint('【日志】loadInitialData - 加载车辆组件: ${_currentVehicle!.name}');
        await maintenanceProvider.loadComponentsForVehicle(_currentVehicle!.name);
        debugPrint('【日志】拿到数据了 - 车辆组件加载完成');
        
        debugPrint('【日志】loadInitialData - 加载车辆记录: ${_currentVehicle!.name}');
        final records = await maintenanceProvider.loadRecordsForVehicle(_currentVehicle!.name);
        debugPrint('【日志】拿到数据了 - 记录加载完成，共${records.length}条');
        
        // 计算派生数据
        if (records.isNotEmpty && mounted) {
          // 查找最近的保养记录（按日期排序，取最新的）
          records.sort((a, b) => b.maintenanceDate.compareTo(a.maintenanceDate));
          _lastMaintenanceDate = records.first.maintenanceDate;
          debugPrint('【日志】拿到数据了 - 找到最近一次保养记录：${DateFormat('yyyy-MM-dd').format(_lastMaintenanceDate!)}');
          
          // 计算跟踪天数（仍然使用最早的记录）
          final earliestRecord = records.reduce((a, b) =>
            a.maintenanceDate.isBefore(b.maintenanceDate) ? a : b);
          _trackedDays = DateTime.now().difference(earliestRecord.maintenanceDate).inDays;
          
          debugPrint('【日志】拿到数据了 - 计算派生数据完成，跟踪天数: $_trackedDays');
        } else {
          // 如果没有保养记录，将最后保养日期设为null
          _lastMaintenanceDate = null;
          debugPrint('【日志】拿到数据了 - 未找到保养记录，显示"暂无保养"');
        }
      }
      
      debugPrint('【日志】拿到数据了 - 所有数据加载完成');

    } catch (e) {
      debugPrint('【错误】loadInitialData - 加载错误: $e');
      if (mounted) {
        setState(() {
          _error = "加载车辆信息失败: ${e.toString()}";
        });
      }
    } finally {
      timeoutTimer.cancel(); // 取消超时定时器
      if (mounted) {
        debugPrint('【日志】loadInitialData - 完成所有加载 ${DateTime.now()}');
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('【日志】HomeScreen.build - 重新构建UI ${DateTime.now()}, isLoading=$_isLoading');
    // 监听所需的Provider
    final vehicleProvider = Provider.of<VehicleListProvider>(context);
    final maintenanceProvider = Provider.of<MaintenanceProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('车辆保养助手'),
        actions: [
          // 添加刷新按钮
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '刷新所有数据',
            onPressed: _isLoading ? null : () {
              debugPrint('【日志】刷新按钮点击，准备重新加载数据');
              // 确保当前不在加载状态
              if (!_isLoading) {
                loadInitialData();
              }
            },
          ),
          // --- Notifications Badge ---
          if (maintenanceProvider.criticalComponentCount > 0)
            badges_pkg.Badge(
              showBadge: true, 
              position: badges_pkg.BadgePosition.topEnd(top: 0, end: 3), // Fine-tune position
              badgeContent: Text(
                maintenanceProvider.criticalComponentCount > 99 ? '99+' : maintenanceProvider.criticalComponentCount.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              child: IconButton(
                icon: const Icon(Icons.notifications_outlined),
                tooltip: '查看所有提醒 (${maintenanceProvider.criticalComponentCount}项)',
                onPressed: maintenanceProvider.criticalComponentCount > 0 ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationsScreen(
                        // Pass ALL components that are critical across ALL vehicles
                        criticalComponents: maintenanceProvider.allCriticalComponents,
                        // We need to pass all vehicles as well for context
                        vehicles: vehicleProvider.vehicles,
                      ),
                    ),
                  );
                } : null, // Disable if there are no critical items
              ),
            ),
          // --- End Notifications Badge ---
        ],
      ),
      // Show full page loading indicator during initial loading
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildHomeContent(vehicleProvider, maintenanceProvider),
    );
  }

  // --- Content building methods ---
  Widget _buildHomeContent(VehicleListProvider vehicleProvider, MaintenanceProvider maintenanceProvider) {
    // Handle error state when loading fails AND there are no vehicles
    if (_error != null && vehicleProvider.vehicles.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48.0, color: Colors.red),
              const SizedBox(height: 16.0),
              Text(_error!, style: const TextStyle(fontSize: 16.0)),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: loadInitialData,
                child: const Text('重试'),
              ),
            ],
          ),
        ),
      );
    }

    // Handle state when no vehicles are added yet
    if (vehicleProvider.vehicles.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.directions_car_outlined, size: 48.0, color: Colors.blue),
              const SizedBox(height: 16.0),
              const Text('暂无车辆, 请先添加车辆', style: TextStyle(fontSize: 16.0)),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to VehicleListScreen to add a new vehicle
                  Navigator.pushNamed(context, '/vehicle_list');
                },
                child: const Text('添加车辆'),
              ),
            ],
          ),
        ),
      );
    }

    // Main content when everything is loaded successfully
    return RefreshIndicator(
      onRefresh: loadInitialData, // Pull to refresh
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vehicle Overview Card - with vehicle selection
            Card(
              elevation: 1.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '车辆概览: ${_currentVehicle?.name ?? '未选择车辆'}', // Show vehicle name if loaded
                            style: Theme.of(context).textTheme.titleLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Switch button - consider using an icon button or styling
                        TextButton(
                          onPressed: vehicleProvider.vehicles.length > 1 ? _showVehicleSelectionDialog : null, // Only enable if >1 vehicle
                          child: Text(vehicleProvider.vehicles.length > 1 ? '切换车辆' : '仅一辆车'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text('当前里程: ${NumberFormat.decimalPattern('zh_CN').format(_currentVehicle?.mileage ?? 0)} km'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            _buildVehicleStatusCard(maintenanceProvider),
            const SizedBox(height: 16.0),

            // Maintenance Reminders Section
            _buildMaintenanceRemindersSection(maintenanceProvider),
            const SizedBox(height: 16.0),

            // Announcements
            _buildAnnouncementsSection(),
          ],
        ),
      ),
    );
  }

  // --- Helper methods for building specific sections ---
  Widget _buildVehicleStatusCard(MaintenanceProvider maintenanceProvider) {
    // Default status values
    String lastMaintenanceString = '暂无保养';
    IconData statusIcon = Icons.check_circle_outline;
    String overallStatus = '良好';
    Color statusColor = Colors.green;

    // --- Calculate last maintenance date string ---
    if (_lastMaintenanceDate != null) {
      // Format date as YYYY-MM-DD
      lastMaintenanceString = DateFormat('yyyy-MM-dd').format(_lastMaintenanceDate!);
    }

    // --- DEBUG LOGGING START ---
    debugPrint('[HomeScreen - BuildStatus] Checking status for ${_currentVehicle?.name}. Total reminders: ${maintenanceProvider.getComponentsForVehicle(_currentVehicle?.name ?? "").length}');
    // --- DEBUG LOGGING END ---

    // 使用Provider获取组件
    final components = _currentVehicle != null 
        ? maintenanceProvider.getComponentsForVehicle(_currentVehicle!.name)
        : <MaintenanceComponent>[];
        
    bool needsWarning = components.any((r) {
        final status = r.getStatus(_currentVehicle?.mileage.toDouble() ?? 0.0, null);
        // debugPrint('  - [Warning Check] ${r.name}: Status = $status'); // Optional detailed log
        return status == MaintenanceStatus.warning;
      }
    );
    
    bool needsAttention = components.any((r) {
        final status = r.getStatus(_currentVehicle?.mileage.toDouble() ?? 0.0, null);
        // debugPrint('  - [Attention Check] ${r.name}: Status = $status'); // Optional detailed log
        return status == MaintenanceStatus.attention;
      }
    );

    if (needsWarning) {
      statusIcon = Icons.error_outline;
      overallStatus = '需要保养';
      statusColor = Colors.red;
    } else if (needsAttention) {
      statusIcon = Icons.warning_amber_outlined;
      overallStatus = '注意保养';
      statusColor = Colors.orange;
    }

    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), // Consistent rounding
      child: Padding(
        // Add horizontal padding as well for better spacing
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Use Flexible to prevent overflow on small screens
            Flexible(child: _buildStatusItem(Icons.event_available_outlined, '上次保养', lastMaintenanceString)),
            Flexible(child: _buildStatusItem(Icons.list_alt_outlined, '保养项目', '${components.length} 项')),
            Flexible(child: _buildStatusItem(statusIcon, '当前状态', overallStatus, iconColor: statusColor)),
          ],
        ),
      ),
    );
  }

  // Helper widget for individual items within the status section
  Widget _buildStatusItem(IconData icon, String label, String value, {Color? iconColor}) {
    final color = iconColor ?? Theme.of(context).colorScheme.primary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 30.0, color: color),
        const SizedBox(height: 8.0),
        Text(label, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center), // Center align label
        const SizedBox(height: 4.0),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center, // Center align value
          overflow: TextOverflow.ellipsis, // Handle long date strings
        ),
      ],
    );
  }

  // Builds the section listing maintenance reminders that need attention
  Widget _buildMaintenanceRemindersSection(MaintenanceProvider maintenanceProvider) {
    // Show loading indicator specifically for reminders
    if (maintenanceProvider.isLoadingReminders) {
      return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text('保养提醒', style: Theme.of(context).textTheme.titleLarge),
           const SizedBox(height: 8.0),
           const Card(
              elevation: 1.0,
              child: SizedBox(
                width: double.infinity,
                height: 100, // Placeholder height during load
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
             ),
           ),
        ],
      );
    }

    // 获取当前车辆的组件
    final components = _currentVehicle != null 
        ? maintenanceProvider.getComponentsForVehicle(_currentVehicle!.name)
        : <MaintenanceComponent>[];
        
    // Filter reminders for the current vehicle that need attention or are overdue
    final List<MaintenanceComponent> criticalReminders = components.where((component) {
      // Ensure _currentVehicle is not null before accessing mileage
      if (_currentVehicle == null) return false;
      final status = component.getStatus(_currentVehicle!.mileage.toDouble(), null);
      return status == MaintenanceStatus.attention || status == MaintenanceStatus.warning;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('保养提醒', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8.0),
        Card(
          elevation: 1.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: criticalReminders.isEmpty
            ? Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                child: const Text(
                  '暂无需要关注的保养项目',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : Column(
                children: criticalReminders.map((component) {
                  // 获取组件状态数据
                  final currentMileage = _currentVehicle?.mileage.toDouble() ?? 0.0;
                  final status = component.getStatus(currentMileage, null);
                  
                  // 计算剩余数据
                  String remainingText = '';
                  Color remainingColor = Colors.orange;
                  
                  if (component.maintenanceType == 'mileage' && component.targetMaintenanceMileage != null) {
                    final remaining = component.targetMaintenanceMileage! - currentMileage;
                    final formattedMileage = NumberFormat.decimalPattern('zh_CN').format(remaining.abs());
                    if (remaining <= 0) {
                      remainingText = '$formattedMileage km';
                      remainingColor = Colors.red;
                    } else {
                      remainingText = '$formattedMileage km';
                      remainingColor = Colors.orange;
                    }
                  } else if (component.maintenanceType == 'date' && component.targetMaintenanceDate != null) {
                    final remainingDays = component.targetMaintenanceDate!.difference(DateTime.now()).inDays;
                    if (remainingDays < 0) {
                      remainingText = '${remainingDays.abs()} 天';
                      remainingColor = Colors.red;
                    } else {
                      remainingText = '$remainingDays 天';
                      remainingColor = Colors.orange;
                    }
                  }
                  
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 第一行：组件名称
                            Text(
                              component.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            // 第二行：详细信息
                            Row(
                              children: [
                                Text(
                                  '类型: ${component.maintenanceType == 'mileage' ? '按里程' : '按时间'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Text(
                                  '当前里程: ${NumberFormat.decimalPattern('zh_CN').format(currentMileage)} km',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            // 第三行：剩余值
                            Row(
                              children: [
                                Text(
                                  status == MaintenanceStatus.warning ? '已超出: ' : '剩余: ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: remainingColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  remainingText,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: remainingColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // 除了最后一个项目外，都添加分隔线
                      if (component != criticalReminders.last)
                        const Divider(height: 1, indent: 16, endIndent: 16),
                    ],
                  );
                }).toList(),
              ),
        ),
      ],
    );
  }

  // Builds the static announcements and tips section
  Widget _buildAnnouncementsSection() {
    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), // Consistent rounding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 添加标题
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
            child: Text('公告与提示', style: Theme.of(context).textTheme.titleLarge),
          ),
          // 测试未开放
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '测试未开放',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '此功能将在后续版本中提供',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          // 使用小贴士
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '使用小贴士',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '定期更新车辆里程可以获得更准确的保养提醒',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Vehicle Selection Dialog ---
  void _showVehicleSelectionDialog() {
    final vehicleProvider = Provider.of<VehicleListProvider>(context, listen: false);
    final maintenanceProvider = Provider.of<MaintenanceProvider>(context, listen: false);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('选择车辆'),
          // Constrain content size and make it scrollable if many vehicles
          content: SizedBox(
            width: double.maxFinite, // Use available width
            // Use ConstrainedBox to prevent excessive height
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.5),
              child: ListView.builder(
                shrinkWrap: true, // Important for AlertDialog content
                itemCount: vehicleProvider.vehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = vehicleProvider.vehicles[index];
                  final isSelected = _currentVehicle?.id == vehicle.id;
                  return ListTile(
                    title: Text(vehicle.name),
                    leading: Icon(
                      Icons.directions_car_filled, // Use filled icon
                      color: isSelected
                             ? Theme.of(context).colorScheme.primary
                             : Colors.grey, // Dim non-selected icon
                    ),
                    // Show checkmark for the currently selected vehicle
                    trailing: isSelected
                            ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary)
                            : null,
                    selected: isSelected,
                    selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1), // Light highlight
                    onTap: () {
                      Navigator.pop(context); // Close dialog
                      if (!isSelected) { // Only update if selection changed
                        setState(() => _currentVehicle = vehicle); // Update selection in memory
                        // Save selection and reload details
                        _prefs.setInt(_lastSelectedVehicleIdKey, vehicle.id).then((_) {
                          // 重新加载当前车辆的数据并刷新页面
                          debugPrint('【日志】车辆选择 - 切换到车辆: ${vehicle.name}');
                          
                          // 清空当前保养记录数据
                          setState(() {
                            _lastMaintenanceDate = null; // 重置最后保养日期
                          });
                          
                          // 重新加载车辆的保养组件和记录
                          maintenanceProvider.loadComponentsForVehicle(vehicle.name).then((_) {
                            // 加载车辆的保养记录
                            maintenanceProvider.loadRecordsForVehicle(vehicle.name).then((records) {
                              if (records.isNotEmpty && mounted) {
                                // 查找最近一次保养记录
                                records.sort((a, b) => b.maintenanceDate.compareTo(a.maintenanceDate));
                                setState(() {
                                  _lastMaintenanceDate = records.first.maintenanceDate;
                                });
                                debugPrint('【日志】车辆选择 - 找到最近一次保养记录：${DateFormat('yyyy-MM-dd').format(_lastMaintenanceDate!)}');
                              } else {
                                debugPrint('【日志】车辆选择 - 未找到保养记录，显示"暂无保养"');
                              }
                            });
                          });
                        });
                      }
                    },
                  );
                },
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('取消'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
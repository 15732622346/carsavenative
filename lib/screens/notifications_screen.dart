import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl for NumberFormat
import '../models/maintenance_component_model.dart';
// Import the Vehicle model
import '../models/vehicle_model.dart';

class NotificationsScreen extends StatelessWidget {
  final List<MaintenanceComponent> criticalComponents;
  final List<Vehicle> vehicles; // Add vehicles list

  const NotificationsScreen({
    Key? key, 
    required this.criticalComponents,
    required this.vehicles, // Make vehicles required
  }) : super(key: key);

  // Helper to get status color
  Color _getStatusColor(MaintenanceStatus status) {
    switch (status) {
      case MaintenanceStatus.warning:
        return Colors.red.withAlpha(150); // Semi-transparent red for warning
      case MaintenanceStatus.attention:
        return Colors.orange.withAlpha(150); // Semi-transparent orange for attention
      default:
        return Colors.grey; // Should not happen for critical components
    }
  }

  // Helper to get status icon
  IconData _getStatusIcon(MaintenanceStatus status) {
     switch (status) {
      case MaintenanceStatus.warning:
        return Icons.error_outline; // Error icon for warning
      case MaintenanceStatus.attention:
        return Icons.warning_amber_outlined; // Warning icon for attention
      default:
        return Icons.help_outline; // Should not happen
    }
  }

  // Helper to get status text
   String _getStatusText(MaintenanceStatus status) {
     switch (status) {
      case MaintenanceStatus.warning:
        return "需要保养";
      case MaintenanceStatus.attention:
        return "注意观察";
      default:
        return "未知状态";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('保养提醒中心'),
      ),
      body: criticalComponents.isEmpty
          ? const Center(
              child: Text(
                '暂无需要注意或保养的项目',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: criticalComponents.length,
              itemBuilder: (context, index) {
                final component = criticalComponents[index];
                
                // Find the corresponding vehicle to get the accurate mileage
                final vehicle = vehicles.firstWhere(
                  (v) => v.name == component.vehicle,
                  orElse: () => Vehicle(name: 'Unknown', year: 0, mileage: 0), // Fallback, should not happen ideally
                );
                final currentMileage = vehicle.mileage.toDouble(); 

                // Calculate status using the correct mileage
                final status = component.getStatus(currentMileage, null); // Use accurate mileage
                final statusColor = _getStatusColor(status);
                final statusIcon = _getStatusIcon(status);
                final statusText = _getStatusText(status);

                // Calculate remaining/overdue status text
                String detailText = statusText;
                final now = DateTime.now();
                if (component.maintenanceType == 'mileage') {
                  if (component.targetMaintenanceMileage != null) {
                    final remainingMileage = component.targetMaintenanceMileage! - currentMileage;
                    final formattedMileage = NumberFormat.decimalPattern('zh_CN').format(remainingMileage.abs());
                    detailText += remainingMileage <= 0 ? ' (已超出 $formattedMileage km)' : ' (剩余 $formattedMileage km)';
                  }
                } else if (component.maintenanceType == 'date') {
                  if (component.targetMaintenanceDate != null) {
                    final remainingDays = component.targetMaintenanceDate!.difference(now).inDays;
                    detailText += remainingDays < 0 ? ' (已超出 ${remainingDays.abs()} 天)' : ' (剩余 $remainingDays 天)';
                  }
                }

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: statusColor.withAlpha(150), width: 1)),
                  child: ListTile(
                    leading: Icon(statusIcon, color: statusColor, size: 30),
                    title: Text(
                      '${component.vehicle} - ${component.name}', 
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    subtitle: Text(
                       detailText // Display calculated detail text
                       // '状态: $statusText | 剩余: [Calculate Remaining]' // Ideal
                    ),
                    trailing: Text( // Indicate type
                       component.maintenanceType == 'mileage' ? '里程' : '日期', 
                       style: TextStyle(color: Colors.grey[600], fontSize: 12)
                     ),
                    // Add onTap? Maybe navigate to the component detail screen?
                    onTap: () {
                       // TODO: Navigate to component details or vehicle screen?
                       print("Tapped on: ${component.vehicle} - ${component.name}");
                    },
                  ),
                );
              },
            ),
    );
  }
} 
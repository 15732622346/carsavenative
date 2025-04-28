import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For input formatters
import 'package:intl/intl.dart'; // Added for date formatting
import 'package:provider/provider.dart'; // Import Provider
import '../models/vehicle_model.dart';
// import '../services/api_service.dart'; // Remove ApiService import
import '../repositories/local_vehicle_repository.dart'; // Import LocalVehicleRepository
import '../providers/vehicle_list_provider.dart'; // 导入车辆列表Provider

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({Key? key}) : super(key: key);

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mileageController = TextEditingController();
  // Remove ApiService instance
  // final ApiService _apiService = ApiService(); 

  DateTime? _selectedDate;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _mileageController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _submitForm() async {
    // Access repository using Provider
    final vehicleRepository = Provider.of<LocalVehicleRepository>(context, listen: false);
    // 获取VehicleListProvider
    final vehicleProvider = Provider.of<VehicleListProvider>(context, listen: false);

    if (_formKey.currentState!.validate() && _selectedDate != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        final newVehicle = Vehicle(
          name: _nameController.text.trim(), // Trim whitespace
          year: _selectedDate!.year,
          mileage: int.parse(_mileageController.text),
          manufacturingDate: _selectedDate,
          // plateNumber: _plateController.text, // If plate number is added back
        );

        // 使用vehicleProvider添加车辆，确保所有页面同步更新
        await vehicleProvider.addVehicle(newVehicle);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('车辆添加成功')),
          );
          Navigator.pop(context, true); // Return true to indicate success
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('添加车辆失败: ${e.toString()}')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else if (_selectedDate == null) {
       ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('请选择车辆出厂日期')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加车辆'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Placeholder for Image Picker remains the same
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.directions_car, size: 60, color: Colors.grey[400]),
                    ),
                    FloatingActionButton.small(
                      onPressed: () { /* TODO: Implement image picking */ },
                      child: const Icon(Icons.camera_alt),
                    ),
                  ],
                ),
              ),
              const Center(child: Text('添加车辆照片')),
              const SizedBox(height: 24),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '车辆名称',
                  prefixIcon: Icon(Icons.directions_car),
                  border: OutlineInputBorder(),
                ),
                maxLength: 50,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '请输入车辆名称';
                  }
                  if (value.trim().length < 2) {
                     return '名称至少需要2个字符';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              InkWell(
                 onTap: () => _selectDate(context),
                 child: InputDecorator(
                    decoration: InputDecoration(
                       labelText: '出厂日期',
                       prefixIcon: const Icon(Icons.calendar_today),
                       border: const OutlineInputBorder(),
                       errorText: _formKey.currentState?.validate() == false && _selectedDate == null
                                  ? '请选择出厂日期'
                                  : null,
                    ),
                    child: Text(
                       _selectedDate == null
                           ? '请选择'
                           : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                       style: TextStyle(
                          fontSize: 16,
                          color: _selectedDate == null ? Colors.grey[600] : null,
                       ),
                    ),
                 ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _mileageController,
                decoration: const InputDecoration(
                  labelText: '当前里程 (公里)',
                  prefixIcon: Icon(Icons.speed),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(7),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入当前里程';
                  }
                  final mileage = int.tryParse(value);
                  if (mileage == null || mileage < 0) {
                    return '请输入有效的非负里程数';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              ElevatedButton.icon(
                onPressed: _isLoading ? null : _submitForm,
                icon: _isLoading
                      ? Container(width: 24, height: 24, padding: const EdgeInsets.all(2.0), child: const CircularProgressIndicator(strokeWidth: 3, color: Colors.white))
                      : const Icon(Icons.save),
                label: const Text('保存车辆信息'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 
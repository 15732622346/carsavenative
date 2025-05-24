import '../models/vehicle_model.dart';

abstract class VehicleRepository {
  Future<List<Vehicle>> getAllVehicles();
  Future<Vehicle?> getVehicleById(int id);
  Future<Vehicle> addVehicle(Vehicle vehicle);
  Future<Vehicle> updateVehicle(Vehicle vehicle);
  Future<void> deleteVehicle(int id);
} 
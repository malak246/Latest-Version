import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modernlogintute/src/features/models/Vehicle_model.dart';

class VehicleRepository {
  final CollectionReference _vehicleCollection =
      FirebaseFirestore.instance.collection('vehicles');

  Future<void> addVehicle(Vehicle vehicle) async {
    await _vehicleCollection.add(vehicle.toMap());
  }

  Future<void> updateVehicle(Vehicle vehicle) async {
    if (vehicle.id.isNotEmpty) {
      await _vehicleCollection.doc(vehicle.id).update(vehicle.toMap());
    }
  }

  Future<void> deleteVehicle(String vehicleId) async {
    await _vehicleCollection.doc(vehicleId).delete();
  }

  Future<Vehicle?> getVehicleById(String vehicleId) async {
    DocumentSnapshot doc = await _vehicleCollection.doc(vehicleId).get();
    if (doc.exists) {
      return Vehicle.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  Stream<List<Vehicle>> getVehiclesStream() {
    return _vehicleCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Vehicle.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}

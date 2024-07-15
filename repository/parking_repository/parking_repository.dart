// lib/repositories/parking_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modernlogintute/src/features/models/Parking_model.dart';

class ParkingRepository {
  final CollectionReference _parkingCollection =
      FirebaseFirestore.instance.collection('parkings');

  Future<void> addParking(Parking parking) async {
    await _parkingCollection.doc(parking.parkingId).set(parking.toMap());
  }

  Future<void> updateParking(Parking parking) async {
    if (parking.parkingId.isNotEmpty) {
      await _parkingCollection.doc(parking.parkingId).update(parking.toMap());
    }
  }

  Future<void> deleteParking(String parkingId) async {
    await _parkingCollection.doc(parkingId).delete();
  }

  Future<Parking?> getParkingById(String parkingId) async {
    DocumentSnapshot doc = await _parkingCollection.doc(parkingId).get();
    if (doc.exists) {
      return Parking.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  Stream<List<Parking>> getParkingsStream() {
    return _parkingCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Parking.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}

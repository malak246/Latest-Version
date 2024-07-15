import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modernlogintute/src/features/models/Reservation_model.dart';

class ReservationRepository {
  final CollectionReference _reservationCollection =
      FirebaseFirestore.instance.collection('reservations');

  Future<void> addReservation(Reservation reservation) async {
    await _reservationCollection.add(reservation.toMap());
  }

  Future<void> updateReservation(Reservation reservation) async {
    if (reservation.id.isNotEmpty) {
      await _reservationCollection
          .doc(reservation.id)
          .update(reservation.toMap());
    }
  }

  Future<void> deleteReservation(String reservationId) async {
    await _reservationCollection.doc(reservationId).delete();
  }

  Future<Reservation?> getReservationById(String reservationId) async {
    DocumentSnapshot doc =
        await _reservationCollection.doc(reservationId).get();
    if (doc.exists) {
      return Reservation.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  Stream<List<Reservation>> getReservationsStream() {
    return _reservationCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Reservation.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}

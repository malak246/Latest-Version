import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modernlogintute/src/features/models/Slot_model.dart';

class SlotRepository {
  final CollectionReference _slotCollection =
      FirebaseFirestore.instance.collection('slots');

  Future<void> addSlot(Slot slot) async {
    await _slotCollection.add(slot.toMap());
  }

  Future<void> updateSlot(Slot slot) async {
    if (slot.id.isNotEmpty) {
      await _slotCollection.doc(slot.id).update(slot.toMap());
    }
  }

  Future<void> deleteSlot(String slotId) async {
    await _slotCollection.doc(slotId).delete();
  }

  Future<Slot?> getSlotById(String slotId) async {
    DocumentSnapshot doc = await _slotCollection.doc(slotId).get();
    if (doc.exists) {
      return Slot.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  Stream<List<Slot>> getSlotsStream() {
    return _slotCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Slot.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}

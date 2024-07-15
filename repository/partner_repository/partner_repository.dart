import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modernlogintute/src/features/models/Partner_model.dart';

class PartnerRepository {
  final CollectionReference _partnerCollection =
      FirebaseFirestore.instance.collection('partners');

  Future<void> addPartner(Partner partner) async {
    await _partnerCollection.doc(partner.partnerId).set(partner.toMap());
  }

  Future<void> updatePartner(Partner partner) async {
    if (partner.partnerId.isNotEmpty) {
      await _partnerCollection.doc(partner.partnerId).update(partner.toMap());
    }
  }

  Future<void> deletePartner(String partnerId) async {
    await _partnerCollection.doc(partnerId).delete();
  }

  Future<Partner?> getPartnerById(String partnerId) async {
    DocumentSnapshot doc = await _partnerCollection.doc(partnerId).get();
    if (doc.exists) {
      return Partner.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  Stream<List<Partner>> getPartnersStream() {
    return _partnerCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Partner.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}

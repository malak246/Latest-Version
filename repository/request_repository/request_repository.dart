import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:modernlogintute/src/features/models/request_model.dart';

class RequestRepository {
  final CollectionReference _requestCollection =
      FirebaseFirestore.instance.collection('requests');

  Future<void> addRequest(Request request) async {
    await _requestCollection.doc(request.requestId).set(request.toMap());
  }

  Future<void> updateRequest(Request request) async {
    await _requestCollection.doc(request.requestId).update(request.toMap());
  }

  Future<void> deleteRequest(String requestId) async {
    await _requestCollection.doc(requestId).delete();
  }

  Future<Request?> getRequestById(String requestId) async {
    DocumentSnapshot<Map<String, dynamic>> doc = await _requestCollection
        .doc(requestId)
        .get() as DocumentSnapshot<Map<String, dynamic>>;
    if (doc.exists) {
      return Request.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  Stream<List<Request>> getRequestsStream() {
    return _requestCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Request.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}

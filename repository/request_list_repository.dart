import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modernlogintute/src/features/models/Request_model.dart' as my;

class RequestListRepository {
  final CollectionReference _requestCollection =
      FirebaseFirestore.instance.collection('requests');

  Future<void> addRequest(my.Request request) async {
    await _requestCollection.add(request.toMap());
  }

  Future<void> updateRequest(my.Request request) async {
    if (request.requestId.isNotEmpty) {
      await _requestCollection.doc(request.requestId).update(request.toMap());
    }
  }

  Future<void> deleteRequest(String requestId) async {
    await _requestCollection.doc(requestId).delete();
  }

  Future<List<my.Request>> getRequests() async {
    QuerySnapshot snapshot = await _requestCollection.get();
    return snapshot.docs.map((doc) {
      return my.Request.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  Stream<List<my.Request>> getRequestsStream() {
    return _requestCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return my.Request.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modernlogintute/src/features/models/Client_model.dart';

class ClientRepository {
  final CollectionReference _clientCollection =
      FirebaseFirestore.instance.collection('clients');

  Future<void> addClient(Client client) async {
    await _clientCollection.doc(client.clientId).set(client.toMap());
  }

  Future<void> updateClient(Client client) async {
    if (client.clientId.isNotEmpty) {
      await _clientCollection.doc(client.clientId).update(client.toMap());
    }
  }

  Future<void> deleteClient(String clientId) async {
    await _clientCollection.doc(clientId).delete();
  }

  Future<Client?> getClientById(String clientId) async {
    DocumentSnapshot doc = await _clientCollection.doc(clientId).get();
    if (doc.exists) {
      return Client.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  Stream<List<Client>> getClientsStream() {
    return _clientCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Client.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}

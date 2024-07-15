import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modernlogintute/src/features/models/Service_model.dart';

class ServiceRepository {
  final CollectionReference _serviceCollection =
      FirebaseFirestore.instance.collection('services');

  Future<void> addService(Service service) async {
    await _serviceCollection.add(service.toMap());
  }

  Future<void> updateService(Service service) async {
    if (service.id.isNotEmpty) {
      await _serviceCollection.doc(service.id).update(service.toMap());
    }
  }

  Future<void> deleteService(String serviceId) async {
    await _serviceCollection.doc(serviceId).delete();
  }

  Future<Service?> getServiceById(String serviceId) async {
    DocumentSnapshot doc = await _serviceCollection.doc(serviceId).get();
    if (doc.exists) {
      return Service.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  Stream<List<Service>> getServicesStream() {
    return _serviceCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Service.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}

// lib/repositories/payment_method_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modernlogintute/src/features/models/Paymentmethod_model.dart';

class PaymentMethodRepository {
  final CollectionReference _paymentMethodCollection =
      FirebaseFirestore.instance.collection('payment_methods');

  Future<void> addPaymentMethod(PaymentMethod paymentMethod) async {
    await _paymentMethodCollection
        .doc(paymentMethod.paymentId)
        .set(paymentMethod.toMap());
  }

  Future<void> updatePaymentMethod(PaymentMethod paymentMethod) async {
    if (paymentMethod.paymentId.isNotEmpty) {
      await _paymentMethodCollection
          .doc(paymentMethod.paymentId)
          .update(paymentMethod.toMap());
    }
  }

  Future<void> deletePaymentMethod(String paymentId) async {
    await _paymentMethodCollection.doc(paymentId).delete();
  }

  Future<PaymentMethod?> getPaymentMethodById(String paymentId) async {
    DocumentSnapshot doc = await _paymentMethodCollection.doc(paymentId).get();
    if (doc.exists) {
      return PaymentMethod.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  Stream<List<PaymentMethod>> getPaymentMethodsStream() {
    return _paymentMethodCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return PaymentMethod.fromMap(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}

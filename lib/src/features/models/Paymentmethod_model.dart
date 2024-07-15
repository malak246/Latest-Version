class PaymentMethod {
  final String paymentId;
  final String name;
  final String details;

  PaymentMethod({
    required this.paymentId,
    required this.name,
    required this.details,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'details': details,
    };
  }

  factory PaymentMethod.fromMap(Map<String, dynamic> map, String documentId) {
    return PaymentMethod(
      paymentId: documentId,
      name: map['name'],
      details: map['details'],
    );
  }
}

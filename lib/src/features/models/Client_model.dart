class Client {
  final String clientId;
  final String name;
  final String phone;
  final String account;
  final String address;
  final String requestId; // Foreign key from Request class
  final String feedback;

  Client({
    required this.clientId,
    required this.name,
    required this.phone,
    required this.account,
    required this.address,
    required this.requestId,
    required this.feedback,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'account': account,
      'address': address,
      'requestId': requestId,
      'feedback': feedback,
    };
  }

  factory Client.fromMap(Map<String, dynamic> map, String documentId) {
    return Client(
      clientId: documentId,
      name: map['name'],
      phone: map['phone'],
      account: map['account'],
      address: map['address'],
      requestId: map['requestId'],
      feedback: map['feedback'],
    );
  }
}

// your_project_name/lib/models/partner.dart

class Partner {
  final String partnerId;
  final String name;
  final String email;
  final String phoneNumber;

  Partner({
    required this.partnerId,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory Partner.fromMap(Map<String, dynamic> map, String documentId) {
    return Partner(
      partnerId: documentId,
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
    );
  }
}

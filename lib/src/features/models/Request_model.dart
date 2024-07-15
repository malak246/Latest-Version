class Request {
  final String requestId;
  final DateTime date;
  final String adminId; // Foreign key from Admin class
  final String requestApproval; // Foreign key from Admin class
  final String slotId; // Foreign key from Slot class
  final String parkingId; // Foreign key from Parking class
  final String serviceId; // Foreign key from Service class

  Request({
    required this.requestId,
    required this.date,
    required this.adminId,
    required this.requestApproval,
    required this.slotId,
    required this.parkingId,
    required this.serviceId,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'adminId': adminId,
      'requestApproval': requestApproval,
      'slotId': slotId,
      'parkingId': parkingId,
      'serviceId': serviceId,
    };
  }

  factory Request.fromMap(Map<String, dynamic> map, String documentId) {
    return Request(
      requestId: documentId,
      date: DateTime.parse(map['date']),
      adminId: map['adminId'],
      requestApproval: map['requestApproval'],
      slotId: map['slotId'],
      parkingId: map['parkingId'],
      serviceId: map['serviceId'],
    );
  }
}

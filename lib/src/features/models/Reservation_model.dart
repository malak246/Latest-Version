// your_project_name/lib/models/reservation.dart

class Reservation {
  final String id;
  final String serviceId;
  final String slotId;
  final DateTime date;

  Reservation({
    required this.id,
    required this.serviceId,
    required this.slotId,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'serviceId': serviceId,
      'slotId': slotId,
      'reservationTime': date.toIso8601String(),
    };
  }

  factory Reservation.fromMap(Map<String, dynamic> map, String documentId) {
    return Reservation(
      id: documentId,
      serviceId: map['serviceId'],
      slotId: map['slotId'],
      date: DateTime.parse(map['reservationTime']),
    );
  }
}

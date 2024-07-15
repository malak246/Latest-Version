// lib/models/parking_model.dart

class Parking {
  final String parkingId;
  final String location;
  final int capacity;
  final bool hasCamera;
  final int slotNumber;
  final String slotId;

  Parking({
    required this.parkingId,
    required this.location,
    required this.capacity,
    required this.hasCamera,
    required this.slotNumber,
    required this.slotId,
  });

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'capacity': capacity,
      'hasCamera': hasCamera,
      'slotNumber': slotNumber,
      'slotId': slotId,
    };
  }

  factory Parking.fromMap(Map<String, dynamic> map, String documentId) {
    return Parking(
      parkingId: documentId,
      location: map['location'],
      capacity: map['capacity'],
      hasCamera: map['hasCamera'],
      slotNumber: map['slotNumber'],
      slotId: map['slotId'],
    );
  }
}

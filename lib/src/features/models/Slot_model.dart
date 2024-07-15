class Slot {
  final String id;
  final String name;
  final DateTime startTime;
  final DateTime endTime;

  Slot(
      {required this.id,
      required this.name,
      required this.startTime,
      required this.endTime});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    };
  }

  factory Slot.fromMap(Map<String, dynamic> map, String documentId) {
    return Slot(
      id: documentId,
      name: map['name'],
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
    );
  }
}

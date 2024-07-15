class Vehicle {
  final String id;
  final String make;
  final String model;
  final int year;

  Vehicle(
      {required this.id,
      required this.make,
      required this.model,
      required this.year});

  Map<String, dynamic> toMap() {
    return {
      'make': make,
      'model': model,
      'year': year,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map, String documentId) {
    return Vehicle(
      id: documentId,
      make: map['make'],
      model: map['model'],
      year: map['year'],
    );
  }
}

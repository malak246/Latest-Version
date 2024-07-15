class Service {
  final String id;
  final String name;
  final String description;
  final double price;

  Service(
      {required this.id,
      required this.name,
      required this.description,
      required this.price});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
    };
  }

  factory Service.fromMap(Map<String, dynamic> map, String documentId) {
    return Service(
      id: documentId,
      name: map['name'],
      description: map['description'],
      price: map['price'],
    );
  }
}

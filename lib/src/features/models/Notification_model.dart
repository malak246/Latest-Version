class NotificationModel {
  final String notificationId;
  final String bookingConfirmation;
  final DateTime expiryOfReservationPeriod;
  final String requestId;

  NotificationModel({
    required this.notificationId,
    required this.bookingConfirmation,
    required this.expiryOfReservationPeriod,
    required this.requestId,
  });

  Map<String, dynamic> toMap() {
    return {
      'bookingConfirmation': bookingConfirmation,
      'expiryOfReservationPeriod': expiryOfReservationPeriod.toIso8601String(),
      'requestId': requestId,
    };
  }

  factory NotificationModel.fromMap(
      Map<String, dynamic> map, String documentId) {
    return NotificationModel(
      notificationId: documentId,
      bookingConfirmation: map['bookingConfirmation'],
      expiryOfReservationPeriod:
          DateTime.parse(map['expiryOfReservationPeriod']),
      requestId: map['requestId'],
    );
  }
}

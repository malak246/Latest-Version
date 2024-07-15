// admin_model.dart
class Admin {
  final String adminId; // Primary Key
  final String requestApproval; // Foreign key from Notification class
  final String account;
  final String phone;
  final String optimization;
  final String notificationId; // Foreign key from Notification class

  Admin({
    required this.adminId,
    required this.requestApproval,
    required this.account,
    required this.phone,
    required this.optimization,
    required this.notificationId,
  });

  Map<String, dynamic> toMap() {
    return {
      'adminId': adminId,
      'requestApproval': requestApproval,
      'account': account,
      'phone': phone,
      'optimization': optimization,
      'notificationId': notificationId,
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      adminId: map['adminId'],
      requestApproval: map['requestApproval'],
      account: map['account'],
      phone: map['phone'],
      optimization: map['optimization'],
      notificationId: map['notificationId'],
    );
  }
}

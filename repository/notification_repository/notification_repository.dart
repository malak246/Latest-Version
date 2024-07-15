import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modernlogintute/src/features/models/Notification_model.dart';

class NotificationRepository {
  final CollectionReference _notificationCollection =
      FirebaseFirestore.instance.collection('notifications');

  Future<void> addNotification(NotificationModel notification) async {
    await _notificationCollection
        .doc(notification.notificationId)
        .set(notification.toMap());
  }

  Future<void> updateNotification(NotificationModel notification) async {
    if (notification.notificationId.isNotEmpty) {
      await _notificationCollection
          .doc(notification.notificationId)
          .update(notification.toMap());
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    await _notificationCollection.doc(notificationId).delete();
  }

  Future<NotificationModel?> getNotificationById(String notificationId) async {
    DocumentSnapshot doc =
        await _notificationCollection.doc(notificationId).get();
    if (doc.exists) {
      return NotificationModel.fromMap(
          doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  Stream<List<NotificationModel>> getNotificationsStream() {
    return _notificationCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return NotificationModel.fromMap(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}

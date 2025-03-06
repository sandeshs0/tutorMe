import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tutorme/features/notifications/domain/entity/notification_entity.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidInitializationSettings);

    _notificationsPlugin.initialize(settings);
  }

  Future<void> showNotification(NotificationEntity notification) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      "tutorme_notifications",
      "Notifications",
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      int.parse(notification.id.substring(0, 5), radix: 16),
      "New Notification",
      notification.message,
      details,
    );
  }
}

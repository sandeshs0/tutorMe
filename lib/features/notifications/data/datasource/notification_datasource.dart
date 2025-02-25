import 'package:tutorme/features/notifications/domain/entity/notification_entity.dart';

abstract interface class INotificationRemoteDataSource {
  /// Fetch notifications from API
  Future<List<NotificationEntity>> fetchNotifications();

  /// Mark all notifications as read
  Future<void> markNotificationsAsRead();
}

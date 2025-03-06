import 'package:tutorme/features/notifications/domain/entity/notification_entity.dart';

abstract interface class INotificationRemoteDataSource {
  Future<List<NotificationEntity>> fetchNotifications();
  Future<void> markNotificationsAsRead();
}

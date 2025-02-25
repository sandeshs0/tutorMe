import 'package:dartz/dartz.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/notifications/domain/entity/notification_entity.dart';

abstract interface class INotificationRepository {
  /// Fetches all notifications for the user
  Future<Either<Failure, List<NotificationEntity>>> getNotifications();

  /// Marks all notifications as read
  Future<Either<Failure, void>> markNotificationsAsRead();
}

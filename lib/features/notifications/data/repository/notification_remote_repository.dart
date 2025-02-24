import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/notifications/data/datasource/remote_datasource/notification_remote_datasource.dart';
import 'package:tutorme/features/notifications/domain/entity/notification_entity.dart';
import 'package:tutorme/features/notifications/domain/repository/notification_repository.dart';

class NotificationRemoteRepository implements INotificationRepository {
  final NotificationRemoteDataSource _notificationRemoteDataSource;

  NotificationRemoteRepository(this._notificationRemoteDataSource);

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    try {
      debugPrint("Fetching notifications...");
      final notifications = await _notificationRemoteDataSource.fetchNotifications();
      return Right(notifications);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markNotificationsAsRead() async {
    try {
      debugPrint("Marking all notifications as read...");
      await _notificationRemoteDataSource.markNotificationsAsRead();
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}

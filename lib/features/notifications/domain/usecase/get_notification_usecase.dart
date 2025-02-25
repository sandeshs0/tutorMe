import 'package:dartz/dartz.dart';
import 'package:tutorme/app/usecase/usecase.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/notifications/domain/entity/notification_entity.dart';
import 'package:tutorme/features/notifications/domain/repository/notification_repository.dart';

class GetNotificationsUsecase implements UsecaseWithoutParams<List<NotificationEntity>> {
  final INotificationRepository notificationRepository;

  GetNotificationsUsecase({required this.notificationRepository});

  @override
  Future<Either<Failure, List<NotificationEntity>>> call() async {
    return await notificationRepository.getNotifications();
  }
}

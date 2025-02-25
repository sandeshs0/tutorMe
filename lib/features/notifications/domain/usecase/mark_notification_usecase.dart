import 'package:dartz/dartz.dart';
import 'package:tutorme/app/usecase/usecase.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/notifications/domain/repository/notification_repository.dart';

class MarkNotificationsAsReadUsecase implements UsecaseWithoutParams<void> {
  final INotificationRepository notificationRepository;

  MarkNotificationsAsReadUsecase({required this.notificationRepository});

  @override
  Future<Either<Failure, void>> call() async {
    return await notificationRepository.markNotificationsAsRead();
  }
}

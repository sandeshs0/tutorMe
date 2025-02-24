import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/notifications/domain/entity/notification_entity.dart';
import 'package:tutorme/features/notifications/domain/usecase/get_notification_usecase.dart';
import 'package:tutorme/features/notifications/domain/usecase/mark_notification_usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUsecase getNotificationsUsecase;
  final MarkNotificationsAsReadUsecase markNotificationsAsReadUsecase;

  NotificationBloc({
    required this.getNotificationsUsecase,
    required this.markNotificationsAsReadUsecase,
  }) : super(NotificationInitial()) {
    on<FetchNotificationsEvent>(_onFetchNotifications);
    on<MarkNotificationsAsReadEvent>(_onMarkNotificationsAsRead);
  }

  /// Handles fetching notifications
  Future<void> _onFetchNotifications(
      FetchNotificationsEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());

    final Either<Failure, List<NotificationEntity>> result =
        await getNotificationsUsecase();

    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (notifications) => emit(NotificationLoaded(notifications)),
    );
  }

  /// Handles marking notifications as read
  Future<void> _onMarkNotificationsAsRead(MarkNotificationsAsReadEvent event,
      Emitter<NotificationState> emit) async {
    final Either<Failure, void> result = await markNotificationsAsReadUsecase();

    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (_) {
        emit(NotificationsMarkedAsRead()); // Show success message
        add(FetchNotificationsEvent()); // ✅ Re-fetch notifications after marking them as read
      },
    );
  }
}

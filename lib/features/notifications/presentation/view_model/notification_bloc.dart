import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/core/services/notification_service.dart';
import 'package:tutorme/features/notifications/domain/entity/notification_entity.dart';
import 'package:tutorme/features/notifications/domain/usecase/get_notification_usecase.dart';
import 'package:tutorme/features/notifications/domain/usecase/mark_notification_usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUsecase getNotificationsUsecase;
  final MarkNotificationsAsReadUsecase markNotificationsAsReadUsecase;
  // final SocketService socketService;
  final NotificationService notificationService; // ✅ Add NotificationService

  NotificationBloc({
    required this.getNotificationsUsecase,
    required this.markNotificationsAsReadUsecase,
    // required this.socketService,
    required this.notificationService, // ✅ Inject NotificationService
  }) : super(NotificationInitial()) {
    on<FetchNotificationsEvent>(_onFetchNotifications);
    on<MarkNotificationsAsReadEvent>(_onMarkNotificationsAsRead);
    on<AddNewNotificationEvent>(
        _onAddNewNotification); // ✅ Handle real-time event

    // Listening for socket events
    //  socketService.listenForNotifications((data) {
    //   final notification = NotificationEntity(
    //     id: data['_id'],
    //     userId: data['userId'],
    //     message: data['message'],
    //     type: data['type'],
    //     isRead: false,
    //     createdAt: DateTime.parse(data['createdAt']),
    //   );
    //   add(AddNewNotificationEvent(notification)); // ✅ Dispatch event properly
    //   NotificationService().showNotification(notification); // 🔔 Show push notification
    // });
  }

  void _onAddNewNotification(
      AddNewNotificationEvent event, Emitter<NotificationState> emit) {
    if (state is NotificationLoaded) {
      final currentState = state as NotificationLoaded;
      final updatedNotifications = [
        event.notification,
        ...currentState.notifications
      ];
      NotificationService().showNotification(
          updatedNotifications[0]); // 🔔 Show push notification

      emit(NotificationLoaded(updatedNotifications));
    }
  }

  /// Handles fetching notifications
  Future<void> _onFetchNotifications(
      FetchNotificationsEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());

    final Either<Failure, List<NotificationEntity>> result =
        await getNotificationsUsecase();
    // NotificationService().showNotification(notification); // 🔔 Show push notification

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

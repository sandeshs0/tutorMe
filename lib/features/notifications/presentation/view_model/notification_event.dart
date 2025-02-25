part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

/// Event to fetch all notifications
class FetchNotificationsEvent extends NotificationEvent {}

/// Event to mark all notifications as read
class MarkNotificationsAsReadEvent extends NotificationEvent {}

class AddNewNotificationEvent extends NotificationEvent {
  final NotificationEntity notification;

  const AddNewNotificationEvent(this.notification);

  @override
  List<Object> get props => [notification];
}

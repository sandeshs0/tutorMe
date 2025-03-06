part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class FetchNotificationsEvent extends NotificationEvent {}

class MarkNotificationsAsReadEvent extends NotificationEvent {}

class AddNewNotificationEvent extends NotificationEvent {
  final NotificationEntity notification;

  const AddNewNotificationEvent(this.notification);

  @override
  List<Object> get props => [notification];
}

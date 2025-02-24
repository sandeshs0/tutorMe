part of 'notification_bloc.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

/// Initial state when notifications are not loaded yet
final class NotificationInitial extends NotificationState {}

/// State when notifications are being fetched
final class NotificationLoading extends NotificationState {}

/// State when notifications are successfully fetched
final class NotificationLoaded extends NotificationState {
  final List<NotificationEntity> notifications;

  const NotificationLoaded(this.notifications);

  @override
  List<Object> get props => [notifications];
}

/// State when notifications have been marked as read
final class NotificationsMarkedAsRead extends NotificationState {}

/// State when there is an error fetching notifications
final class NotificationError extends NotificationState {
  final String message;

  const NotificationError(this.message);

  @override
  List<Object> get props => [message];
}

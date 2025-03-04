part of 'session_bloc.dart';

sealed class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object> get props => [];
}

final class FetchStudentSessions extends SessionEvent {}

final class JoinSession extends SessionEvent {
  final String bookingId;

  const JoinSession(this.bookingId);

  @override
  List<Object> get props => [bookingId];
}

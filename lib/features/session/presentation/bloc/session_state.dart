part of 'session_bloc.dart';

sealed class SessionState extends Equatable {
  const SessionState();
  
  @override
  List<Object?> get props => [];
}

final class SessionInitial extends SessionState {}

final class SessionLoading extends SessionState {}

final class SessionLoaded extends SessionState {
  final List<SessionEntity> sessions;

  const SessionLoaded({required this.sessions});

  @override
  List<Object?> get props => [sessions];
}

final class SessionError extends SessionState {
  final String message;

  const SessionError({required this.message});

  @override
  List<Object?> get props => [message];
}
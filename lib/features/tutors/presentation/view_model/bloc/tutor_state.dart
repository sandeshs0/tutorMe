part of 'tutor_bloc.dart';

sealed class TutorState extends Equatable {
  const TutorState();

  @override
  List<Object> get props => [];
}

final class TutorInitial extends TutorState {}

final class TutorLoading extends TutorState {}

final class TutorLoaded extends TutorState {
  final List<TutorEntity> tutors;

  const TutorLoaded({required this.tutors});

  @override
  List<Object> get props => [tutors];
}

final class TutorProfileLoaded extends TutorState {
  final TutorEntity tutor;

  const TutorProfileLoaded({required this.tutor});

  @override
  List<Object> get props => [tutor];
}

final class TutorError extends TutorState {
  final String message;

  const TutorError({required this.message});

  @override
  List<Object> get props => [message];
}

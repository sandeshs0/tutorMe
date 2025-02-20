part of 'tutor_bloc.dart';

sealed class TutorState extends Equatable {
  const TutorState();

  @override
  List<Object> get props => [];
}

// Initial State (Default)
final class TutorInitial extends TutorState {}

// Loading State
final class TutorLoading extends TutorState {}

// Success State for All Tutors
final class TutorLoaded extends TutorState {
  final List<TutorEntity> tutors;

  const TutorLoaded({required this.tutors});

  @override
  List<Object> get props => [tutors];
}

// Success State for Single Tutor Profile
final class TutorProfileLoaded extends TutorState {
  final TutorEntity tutor;

  const TutorProfileLoaded({required this.tutor});

  @override
  List<Object> get props => [tutor];
}

// Error State
final class TutorError extends TutorState {
  final String message;

  const TutorError({required this.message});

  @override
  List<Object> get props => [message];
}

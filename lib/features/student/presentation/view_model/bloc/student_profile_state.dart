part of 'student_profile_bloc.dart';

sealed class StudentProfileState extends Equatable {
  const StudentProfileState();

  @override
  List<Object?> get props => [];
}

// Initial state when no data is loaded yet
final class StudentProfileInitial extends StudentProfileState {}

// Loading state when fetching data
final class StudentProfileLoading extends StudentProfileState {}

// Loaded state when data is successfully fetched
final class StudentProfileLoaded extends StudentProfileState {
  final StudentEntity student;

  const StudentProfileLoaded({required this.student});

  @override
  List<Object?> get props => [student];
}

// Error state when fetching fails
final class StudentProfileError extends StudentProfileState {
  final String message;

  const StudentProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class StudentProfileSuccess extends StudentProfileState {}

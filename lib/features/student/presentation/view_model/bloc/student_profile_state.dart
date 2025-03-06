part of 'student_profile_bloc.dart';

sealed class StudentProfileState extends Equatable {
  const StudentProfileState();

  @override
  List<Object?> get props => [];
}

final class StudentProfileInitial extends StudentProfileState {}

final class StudentProfileLoading extends StudentProfileState {}

final class StudentProfileLoaded extends StudentProfileState {
  final StudentEntity student;

  const StudentProfileLoaded({required this.student});

  @override
  List<Object?> get props => [student];
}

final class StudentProfileError extends StudentProfileState {
  final String message;

  const StudentProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class StudentProfileUpdated extends StudentProfileState {
  final StudentEntity student;
  
  const StudentProfileUpdated({required this.student});
  
  @override
  List<Object?> get props => [student];
}


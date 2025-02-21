part of 'student_profile_bloc.dart';

sealed class StudentProfileEvent extends Equatable {
  const StudentProfileEvent();

  @override
  List<Object?> get props => [];
}

// Event to fetch student profile
final class FetchStudentProfile extends StudentProfileEvent {
  const FetchStudentProfile();
}

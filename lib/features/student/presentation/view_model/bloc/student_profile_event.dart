part of 'student_profile_bloc.dart';

sealed class StudentProfileEvent extends Equatable {
  const StudentProfileEvent();

  @override
  List<Object?> get props => [];
}

final class FetchStudentProfile extends StudentProfileEvent {
  const FetchStudentProfile();
}

final class UpdateStudentProfile extends StudentProfileEvent {
  final UpdateStudentProfileDTO updatedData;

  const UpdateStudentProfile({required this.updatedData});

  @override
  List<Object?> get props => [updatedData];
}
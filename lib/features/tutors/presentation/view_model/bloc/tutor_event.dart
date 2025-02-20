part of 'tutor_bloc.dart';

sealed class TutorEvent extends Equatable {
  const TutorEvent();

  @override
  List<Object> get props => [];
}

// Event to Fetch All Tutors
class GetAllTutorsEvent extends TutorEvent {
  final int page;
  final int limit;

  const GetAllTutorsEvent({this.page = 1, this.limit = 10});

  @override
  List<Object> get props => [page, limit];
}

// Event to Fetch a Tutor by Username
class GetTutorByUsernameEvent extends TutorEvent {
  final String username;

  const GetTutorByUsernameEvent({required this.username});

  @override
  List<Object> get props => [username];
}

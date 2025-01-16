part of 'tutor_bloc.dart';

class TutorState extends Equatable {
  final List<TutorModel> tutors;
  final bool isLoading;

  const TutorState({
    required this.tutors,
    required this.isLoading,
  });
  
  factory TutorState.initial() {
    return const TutorState(tutors: [], isLoading: false);
  }

  TutorState copyWith({List<TutorModel>? tutors, bool? isLoading}) {
    return TutorState(
        tutors: tutors ?? this.tutors, isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object> get props => [];
}

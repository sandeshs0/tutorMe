import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';
import 'package:tutorme/features/tutors/domain/usecase/get_all_tutors_usecase.dart';
import 'package:tutorme/features/tutors/domain/usecase/get_tutor_by_username_usecase.dart';

part 'tutor_event.dart';
part 'tutor_state.dart';

class TutorBloc extends Bloc<TutorEvent, TutorState> {
  final GetAllTutorsUsecase getAllTutorsUsecase;
  final GetTutorByUsernameUsecase getTutorByUsernameUsecase;

  TutorBloc({
    required this.getAllTutorsUsecase,
    required this.getTutorByUsernameUsecase,
  }) : super(TutorInitial()) {
    
    // Handle Fetch All Tutors Event
    on<GetAllTutorsEvent>((event, emit) async {
      emit(TutorLoading());

      final Either<Failure, List<TutorEntity>> result =
          await getAllTutorsUsecase(GetTutorsParams(page: event.page, limit: event.limit));

      result.fold(
        (failure) => emit(TutorError(message: failure.toString())),
        (tutors) => emit(TutorLoaded(tutors: tutors)),
      );
    });

    // Handle Fetch Tutor By Username Event
    on<GetTutorByUsernameEvent>((event, emit) async {
      emit(TutorLoading());

      final Either<Failure, TutorEntity> result = await getTutorByUsernameUsecase(
        GetTutorByUsernameParams(username: event.username),
      );

      result.fold(
        (failure) => emit(TutorError(message: failure.toString())),
        (tutor) => emit(TutorProfileLoaded(tutor: tutor)),
      );
    });
  }
}

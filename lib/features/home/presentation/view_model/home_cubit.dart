// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'home_state.dart';

// class HomeCubit extends Cubit<DashboardState> {
//   HomeCubit() : super(DashboardState.initial());

//   void selectTab(int index) {
//     emit(state.copyWith(currentIndex: index));
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';
import 'package:tutorme/features/tutors/domain/usecase/get_all_tutors_usecase.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<DashboardState> {
  final GetAllTutorsUsecase getAllTutorsUsecase;
  int currentPage = 1;

  HomeCubit({required this.getAllTutorsUsecase})
      : super(DashboardState.initial()) {
    fetchTutors(); // Fetch tutors on home load
  }

  void selectTab(int index) {
    emit(state.copyWith(currentIndex: index));
    if (index == 0) {
      fetchTutors();
    }
  }

  Future<void> fetchTutors({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      currentPage = 1;
      emit(state.copyWith(isLoading: true, tutors: []));
    } else {
      currentPage++;
    }

    final Either<Failure, List<TutorEntity>> result =
        await getAllTutorsUsecase(GetTutorsParams(page: currentPage, limit: 5));

    result.fold(
      (failure) {
        emit(
            state.copyWith(isLoading: false, errorMessage: failure.toString()));
      },
      (newTutors) {
        if (isLoadMore) {
          // Append new tutors to the existing list
          final updatedTutors = List<TutorEntity>.from(state.tutors)
            ..addAll(newTutors);
          emit(state.copyWith(
              isLoading: false, tutors: updatedTutors, errorMessage: null));
        } else {
          emit(state.copyWith(
              isLoading: false, tutors: newTutors, errorMessage: null));
        }
      },
    );
  }
}

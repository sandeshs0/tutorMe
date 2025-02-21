import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/student/domain/entity/student_entity.dart';
import 'package:tutorme/features/student/domain/usecase/get_student_profile_usecase.dart';

part 'student_profile_event.dart';
part 'student_profile_state.dart';

class StudentProfileBloc
    extends Bloc<StudentProfileEvent, StudentProfileState> {
  final GetStudentProfileUsecase _getStudentProfileUsecase;

  StudentProfileBloc(
      {required GetStudentProfileUsecase getStudentProfileUsecase})
      : _getStudentProfileUsecase = getStudentProfileUsecase,
        super(StudentProfileInitial()) {
    on<FetchStudentProfile>(_onFetchStudentProfile);
  }

  Future<void> _onFetchStudentProfile(
      FetchStudentProfile event, Emitter<StudentProfileState> emit) async {
    emit(StudentProfileLoading());

    final result = await _getStudentProfileUsecase();

    result.fold(
      (failure) =>
          emit(StudentProfileError(message: _mapFailureToMessage(failure))),
      (student) => emit(StudentProfileLoaded(student: student)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ApiFailure) {
      return failure.message;
    } else if (failure is SharedPrefsFailure) {
      return "Failed to retrieve user authentication details.";
    } else {
      return "An unexpected error occurred.";
    }
  }
}

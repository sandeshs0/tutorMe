import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/student/data/dto/update_student_profile_dto.dart';
import 'package:tutorme/features/student/domain/entity/student_entity.dart';
import 'package:tutorme/features/student/domain/usecase/get_student_profile_usecase.dart';
import 'package:tutorme/features/student/domain/usecase/update_student_profile_usecase.dart';

part 'student_profile_event.dart';
part 'student_profile_state.dart';

class StudentProfileBloc
    extends Bloc<StudentProfileEvent, StudentProfileState> {
  final GetStudentProfileUsecase _getStudentProfileUsecase;
  final UpdateStudentProfileUsecase _updateStudentProfileUsecase;

  StudentProfileBloc({
    required GetStudentProfileUsecase getStudentProfileUsecase,
    required UpdateStudentProfileUsecase updateStudentProfileUsecase,
  })  : _getStudentProfileUsecase = getStudentProfileUsecase,
        _updateStudentProfileUsecase = updateStudentProfileUsecase,
        super(StudentProfileInitial()) {
    on<FetchStudentProfile>(_onFetchStudentProfile);
    on<UpdateStudentProfile>(_onUpdateStudentProfile);
  }

  /// 🔹 Fetch Student Profile
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

  /// 🔹 Update Student Profile
  Future<void> _onUpdateStudentProfile(
      UpdateStudentProfile event, Emitter<StudentProfileState> emit) async {
    emit(StudentProfileLoading());

    final result = await _updateStudentProfileUsecase(event.updatedData);

    result.fold(
      (failure) =>
          emit(StudentProfileError(message: _mapFailureToMessage(failure))),
       (updatedStudent) {
      emit(StudentProfileUpdated(student: updatedStudent));
      // emit(StudentProfileLoaded(student: updatedStudent)); // ✅ Update UI immediately
    },
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

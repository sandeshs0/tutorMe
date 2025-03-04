import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/session/domain/entity/session_entity.dart';
import 'package:tutorme/features/session/domain/usecase/get_student_session_usecase.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final GetStudentSessionsUsecase getStudentSessionsUsecase;

  SessionBloc({required this.getStudentSessionsUsecase})
      : super(SessionInitial()) {
    on<FetchStudentSessions>(_onFetchStudentSessions);
  }

  Future<void> _onFetchStudentSessions(
      FetchStudentSessions event, Emitter<SessionState> emit) async {
    emit(SessionLoading()); // Show loading state

    final result = await getStudentSessionsUsecase();

    result.fold(
      (failure) => emit(SessionError(message: _mapFailureToMessage(failure))),
      (sessions) => emit(SessionLoaded(sessions: sessions)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ApiFailure) {
      return failure.message;
    } else {
      return "An unexpected error occurred.";
    }
  }
}

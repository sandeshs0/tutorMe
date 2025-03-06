import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/session/domain/entity/session_entity.dart';
import 'package:tutorme/features/session/domain/usecase/get_student_session_usecase.dart';
import 'package:tutorme/features/session/domain/usecase/join_session_usecase.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final GetStudentSessionsUsecase getStudentSessionsUsecase;
  final JoinSessionUseCase joinSessionUseCase;

  SessionBloc(
      {required this.getStudentSessionsUsecase,
      required this.joinSessionUseCase})
      : super(SessionInitial()) {
    on<FetchStudentSessions>(_onFetchStudentSessions);
    on<JoinSession>(_onJoinSession);
  }

  Future<void> _onFetchStudentSessions(
      FetchStudentSessions event, Emitter<SessionState> emit) async {
    emit(SessionLoading()); 

    final result = await getStudentSessionsUsecase();

    result.fold(
      (failure) => emit(SessionError(message: _mapFailureToMessage(failure))),
      (sessions) => emit(SessionLoaded(sessions: sessions)),
    );
  }

  Future<void> _onJoinSession(
      JoinSession event, Emitter<SessionState> emit) async {
    emit(SessionJoining()); 
    final cameraPermission = await Permission.camera.status;
    final micPermission = await Permission.microphone.status;

    if (!cameraPermission.isGranted || !micPermission.isGranted) {
      final cameraResult = await Permission.camera.request();
      final micResult = await Permission.microphone.request();

      if (!cameraResult.isGranted || !micResult.isGranted) {
        emit(const SessionError(
            message:
                'Camera and microphone permissions are required to join the session.'));
        return;
      }
    }
    final result = await joinSessionUseCase(event.bookingId);

    result.fold(
      (failure) => emit(SessionError(message: failure.message)),
      (data) async {
     
        final roomUrl = data['roomUrl'] as String;
        emit(SessionJoined(roomUrl: roomUrl));
      },
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

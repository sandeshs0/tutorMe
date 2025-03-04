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
    emit(SessionLoading()); // Show loading state

    final result = await getStudentSessionsUsecase();

    result.fold(
      (failure) => emit(SessionError(message: _mapFailureToMessage(failure))),
      (sessions) => emit(SessionLoaded(sessions: sessions)),
    );
  }

  Future<void> _onJoinSession(
      JoinSession event, Emitter<SessionState> emit) async {
    emit(SessionJoining()); // Show joining state
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
        // final jwtToken = data['jwtToken'] as String;
        // final roomId = data['roomId'] as String;
        // _joinJitsiMeeting(jwtToken, roomId);
        // emit(SessionJoined(roomId: roomId, jwtToken: jwtToken));
        final roomUrl = data['roomUrl'] as String;
        emit(SessionJoined(roomUrl: roomUrl)); // Emit state with room URL for WebView
      },
    );
  }

  // void _joinJitsiMeeting(String jwtToken, String roomId) async {
  //   final options = JitsiMeetConferenceOptions(
  //     serverURL: "https://8x8.vc", // JAAS domain
  //     room: roomId.split('/').last, // Extract room name (e.g., bookingId)
  //     token: jwtToken,
  //     userInfo: JitsiMeetUserInfo(
  //       displayName: "Sandesh", // Use actual user name from auth
  //     ),
  //     configOverrides: {
  //       "startWithAudioMuted": false,
  //       "startWithVideoMuted": false,
  //       "prejoinPageEnabled": false,
  //       "requireDisplayName": false,
  //     },
  //     // interfaceConfigOverrides: {
  //     //   "DISABLE_JOIN_LEAVE_NOTIFICATIONS": true,
  //     //   "MOBILE_APP_PROMO": false,
  //     //   "TOOLBAR_BUTTONS": [
  //     //     "microphone",
  //     //     "camera",
  //     //     "desktop",
  //     //     "fullscreen",
  //     //     "hangup",
  //     //     "chat",
  //     //   ],
  //     // },
  //   );

  //   final jitsiMeet = JitsiMeet();
  //   try {
  //     final response = await jitsiMeet.join(
  //       options,
  //       JitsiMeetEventListener(
  //         conferenceWillJoin: (url) {
  //           debugPrint("Joining conference at $url");
  //         },
  //         conferenceJoined: (url) {
  //           debugPrint("Successfully joined conference at $url");
  //         },
  //         conferenceTerminated: (url, error) {
  //           debugPrint("Conference terminated: $url, Error: $error");
  //           add(FetchStudentSessions()); // Refresh sessions after closing
  //         },
  //         // onError: (error) {
  //         //   debugPrint("Jitsi Meet error: $error");
  //         //   emit(SessionError(message: 'Jitsi Meet error: ${error.message ?? error.toString()}'));
  //         // },
  //       ),
  //     );
  //     debugPrint("Join response: $response");
  //   } catch (e) {
  //     debugPrint("Error joining Jitsi Meet: $e");
  //     emit(SessionError(message: 'Failed to join Jitsi Meet: $e'));
  //   }
  // }


  String _mapFailureToMessage(Failure failure) {
    if (failure is ApiFailure) {
      return failure.message;
    } else {
      return "An unexpected error occurred.";
    }
  }
}

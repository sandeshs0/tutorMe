import 'package:dio/dio.dart';
import 'package:tutorme/app/constants/api_endpoints.dart';
import 'package:tutorme/app/shared_prefs/token_shared_prefs.dart';
import 'package:tutorme/features/session/data/datasource/session_datasource.dart';
import 'package:tutorme/features/session/data/dto/get_my_sessions_dto.dart';
import 'package:tutorme/features/session/domain/entity/session_entity.dart';

class SessionRemoteDataSource implements ISessionDataSource {
  final Dio _dio;
  final TokenSharedPrefs _tokenSharedPrefs;

  SessionRemoteDataSource({
    required Dio dio,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _dio = dio,
        _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<List<SessionEntity>> getStudentSessions() async {
    try {
      // Get the token from Shared Preferences
      final tokenResult = await _tokenSharedPrefs.getToken();
      final token = tokenResult.fold((failure) => null, (token) => token);

      if (token == null || token.isEmpty) {
        throw Exception("Authentication token missing.");
      }

      // API Call with token in headers
      final response = await _dio.get(
        ApiEndpoints.getStudentSessions,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        final data = GetStudentSessionsDTO.fromJson(response.data);
        // debugPrint(response.toString());
        return data.sessions.map((session) => session.toEntity()).toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw Exception("Something went wrong (datasource): $e");
    }
  }

  @override
  Future<Map<String, dynamic>> joinSession(String bookingId) async {
    try {
      final tokenResult = await _tokenSharedPrefs.getToken();
      final token = tokenResult.fold((failure) => null, (token) => token);

      if (token == null || token.isEmpty) {
        throw Exception("Authentication token missing.");
      }

      // Fetch Jitsi JWT token
      final tokenResponse = await _dio.get(
        '${ApiEndpoints.baseUrl}api/sessions/jaas-token/$bookingId',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (tokenResponse.statusCode != 200) {
        throw Exception(
            'Failed to fetch Jitsi token: ${tokenResponse.statusMessage}');
      }

      final jwtToken = tokenResponse.data['token'] as String;

      // Fetch session room details
      final roomResponse = await _dio.get(
        '${ApiEndpoints.baseUrl}api/sessions/room/$bookingId',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (roomResponse.statusCode != 200) {
        throw Exception(
            'Failed to fetch session room: ${roomResponse.statusMessage}');
      }

      final roomData = roomResponse.data as Map<String, dynamic>;
      final roomId = roomData['roomId'] as String;
      final jitsiUrl = 'https://8x8.vc/$roomId?jwt=$jwtToken';
      return {
        'roomUrl': jitsiUrl,
        'jwtToken': jwtToken,
        // 'roomId': roomData['roomId'] as String,
      };
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw Exception("Something went wrong (joining session): $e");
    }
  }
}

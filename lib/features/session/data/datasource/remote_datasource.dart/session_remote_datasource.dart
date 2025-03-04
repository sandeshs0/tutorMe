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
}

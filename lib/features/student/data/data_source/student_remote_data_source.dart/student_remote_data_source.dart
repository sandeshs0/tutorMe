import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorme/app/constants/api_endpoints.dart';
import 'package:tutorme/app/shared_prefs/token_shared_prefs.dart';
import 'package:tutorme/features/student/data/data_source/student_data_source.dart';
import 'package:tutorme/features/student/data/dto/get_student_profile_dto.dart';
import 'package:tutorme/features/student/domain/entity/student_entity.dart';

class StudentRemoteDataSource implements IStudentDataSource {
  final Dio _dio;
    final TokenSharedPrefs _tokenSharedPrefs;


  StudentRemoteDataSource({
    required Dio dio,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _dio = dio,
        _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<StudentEntity> getStudentProfile() async {
    try {
      // Get token from shared preferences
      final tokenResult = await _tokenSharedPrefs.getToken();
      final token = tokenResult.fold((failure) => '', (token) => token);

      if (token.isEmpty) {
        throw Exception("Token not found in shared prefs");
      }

      // Send API request with Authorization header
      final response = await _dio.get(
        ApiEndpoints.getStudentProfile,
        options: Options(
          headers: {
            "Authorization": "Bearer $token", // Send JWT token
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = GetStudentProfileDTO.fromJson(response.data);
        return data.student.toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw Exception("Something went wrong (StudentRemoteDataSource): $e");
    }
  }
}

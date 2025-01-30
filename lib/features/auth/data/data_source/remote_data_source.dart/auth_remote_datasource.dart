import 'package:dio/dio.dart';
import 'package:tutorme/app/constants/api_endpoints.dart';
import 'package:tutorme/features/auth/data/data_source/auth_data_source.dart';
import 'package:tutorme/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final str = response.data['token'];
        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      final formData = FormData.fromMap({
        "name": user.fullName,
        "email": user.email,
        "phone": user.phone,
        "password": user.password,
        "role": user.role,
        "profileImage": await MultipartFile.fromFile(user.profileImage!),
      });

      Response response = await _dio.post(
        ApiEndpoints.register,
        data: formData,
      );

      if (response.statusCode != 201) {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> verifyEmail(String email, String otp) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.verifyEmail,
        data: {
          "username": email,
          "otp": otp,
        },
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}

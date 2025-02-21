import 'package:tutorme/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<String> loginUser(String email, String password);
  Future<void> registerUser(AuthEntity user);
  Future<void> verifyEmail(String email, String otp);
  Future<AuthEntity> getCurrentUser();
}

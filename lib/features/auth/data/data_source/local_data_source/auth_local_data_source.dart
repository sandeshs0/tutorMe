import 'package:tutorme/core/network/hive_service.dart';
import 'package:tutorme/features/auth/data/data_source/auth_data_source.dart';
import 'package:tutorme/features/auth/data/model/auth_hive_model.dart';
import 'package:tutorme/features/auth/domain/entity/auth_entity.dart';

class AuthLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentUser() {
    return Future.value(const AuthEntity(
        id: "1", fullName: "", email: "", phone: "", password: ""));
  }

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      final user = await _hiveService.login(email, password);
      if (user != null) {
        return Future.value("Success");
      } else {
        return Future.error("Invalid credentials");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      // converting AuthEntity to UserHiveModel
      final userHiveModel = UserHiveModel(
        id: user.id,
        fullName: user.fullName,
        email: user.email,
        phone: user.phone,
        password: user.password,
      );

      await _hiveService.addUser(userHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }
}

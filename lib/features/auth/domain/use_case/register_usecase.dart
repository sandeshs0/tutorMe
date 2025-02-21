import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tutorme/app/usecase/usecase.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/auth/domain/entity/auth_entity.dart';
import 'package:tutorme/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String fullName;
  final String username;
  final String email;
  final String phone;
  final String password;
  final String role;
  final String profileImage;

  const RegisterUserParams(
      {required this.fullName,
      required this.username,
      required this.email,
      required this.phone,
      required this.password,
      required this.profileImage,
      required this.role});
  const RegisterUserParams.initial()
      : fullName = '',
      username='',
        email = '',
        phone = '',
        password = '',
        role='',
        profileImage=''
        ;

  @override
  // TODO: implement props
  List<Object?> get props => [fullName, username, email, phone, password, role, profileImage];
}

class RegisterUsecase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;
  RegisterUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
        id: null,
        fullName: params.fullName,
        username:params.username,
        email: params.email,
        phone: params.phone,
        password: params.password,
        role: params.role,
        profileImage: params.profileImage);
    return repository.registerUser(authEntity);
  }
}

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tutorme/app/usecase/usecase.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/auth/domain/entity/auth_entity.dart';
import 'package:tutorme/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String fullName;
  final String email;
  final String phone;
  final String password;

  const RegisterUserParams(
      {required this.fullName,
      required this.email,
      required this.phone,
      required this.password});
  const RegisterUserParams.initial()
      : fullName = '',
        email = '',
        phone = '',
        password = '';

  @override
  // TODO: implement props
  List<Object?> get props => [fullName, email, phone, password];
}

class RegisterUsecase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;
  RegisterUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
        id: null,
        fullName: params.fullName,
        email: params.email,
        phone: params.phone,
        password: params.password);
    return repository.registerUser(authEntity);
  }
}

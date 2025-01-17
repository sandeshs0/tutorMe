import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tutorme/app/usecase/usecase.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/auth/domain/repository/auth_repository.dart';

class LoginParams extends Equatable{
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });

  const LoginParams.initial()
      :email='',
      password='';
      
        @override
        // TODO: implement props
        List<Object?> get props => [email,password];
      
}

class LoginUsecase implements UsecaseWithParams<String,LoginParams>{
  final IAuthRepository repository;

  LoginUsecase(this.repository);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    return repository.loginUser(params.email, params.password);
  }
  
}
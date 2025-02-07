import 'package:dartz/dartz.dart';
import 'package:tutorme/app/usecase/usecase.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/auth/domain/repository/auth_repository.dart';

class VerifyEmailParams {
  final String email;
  final String otp;

  VerifyEmailParams({required this.email, required this.otp});
// Empty constructor
  const VerifyEmailParams.empty()
      : email = '_empty.email',
        otp = '_empty.otp';
}

class VerifyEmailUsecase implements UsecaseWithParams<void, VerifyEmailParams> {
  final IAuthRepository repository;

  VerifyEmailUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(VerifyEmailParams params) {
    return repository.verifyEmail(params.email, params.otp);
  }
}

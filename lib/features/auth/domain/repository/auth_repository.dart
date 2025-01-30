import 'package:dartz/dartz.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthRepository{
  Future<Either<Failure,void>>registerUser(AuthEntity user);
  Future<Either<Failure,String>> loginUser(String email, String password);
  Future<Either<Failure,void>> verifyEmail(String email, String otp);
  Future<Either<Failure,AuthEntity>>getCurrentUser();
}
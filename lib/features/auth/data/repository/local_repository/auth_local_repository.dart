import 'package:dartz/dartz.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:tutorme/features/auth/domain/entity/auth_entity.dart';
import 'package:tutorme/features/auth/domain/repository/auth_repository.dart';

class AuthLocalRepository implements IAuthRepository{
  final AuthLocalDataSource _authLocalDataSource;
  
  AuthLocalRepository(this._authLocalDataSource);

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async{
    try {
      final currentUser = await _authLocalDataSource.getCurrentUser();
      return Right(currentUser);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginUser(String email, String password) async{
  try{
    final result=await _authLocalDataSource.loginUser(email, password);
    return Right(result);
  }catch(e){
    return Left(LocalDatabaseFailure(message: e.toString()));
  }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user)async {
    try{
      await _authLocalDataSource.registerUser(user);
      return const Right(null);
    }catch(e){
      return Left(LocalDatabaseFailure(message: e.toString()));
    }

  }
}
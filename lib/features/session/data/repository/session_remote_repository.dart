import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/session/data/datasource/remote_datasource.dart/session_remote_datasource.dart';
import 'package:tutorme/features/session/domain/entity/session_entity.dart';
import 'package:tutorme/features/session/domain/repository/session_repository.dart';

class SessionRemoteRepository implements ISessionRepository {
  final SessionRemoteDataSource _sessionRemoteDataSource;

  SessionRemoteRepository(this._sessionRemoteDataSource);

  @override
  Future<Either<Failure, List<SessionEntity>>> getStudentSessions() async {
    try {
      debugPrint("Fetching student sessions");
      final sessions = await _sessionRemoteDataSource.getStudentSessions();
      return Right(sessions);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
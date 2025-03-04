import 'package:dartz/dartz.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/session/domain/entity/session_entity.dart';

abstract interface class ISessionRepository {
  Future<Either<Failure, List<SessionEntity>>> getStudentSessions();
}
import 'package:dartz/dartz.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/session/domain/entity/session_entity.dart';
import 'package:tutorme/features/session/domain/repository/session_repository.dart';

class GetStudentSessionsUsecase {
  final ISessionRepository sessionRepository;

  GetStudentSessionsUsecase({required this.sessionRepository});

  Future<Either<Failure, List<SessionEntity>>> call() async {
    return await sessionRepository.getStudentSessions();
  }
}

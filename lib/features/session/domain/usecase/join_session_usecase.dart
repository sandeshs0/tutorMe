import 'package:dartz/dartz.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/session/domain/repository/session_repository.dart';

class JoinSessionUseCase {
  final ISessionRepository sessionRepository;

  JoinSessionUseCase({required this.sessionRepository});

  Future<Either<Failure, Map<String, dynamic>>> call(String bookingId) async {
    return await sessionRepository.joinSession(bookingId);
  }
}
import 'package:dartz/dartz.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';

abstract interface class ITutorRepository {
  Future<Either<Failure, List<TutorEntity>>> getAllTutors({int page, int limit});

  Future<Either<Failure, TutorEntity>> getTutorByUsername(String username);
}

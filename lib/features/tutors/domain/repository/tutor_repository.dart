import 'package:dartz/dartz.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';

abstract interface class ITutorRepository {
  Future<Either<Failure, List<TutorEntity>>> getAllTutors(
      {int page, int limit});

  Future<Either<Failure, TutorEntity>> getTutorByUsername(String username);

  Future<void> saveTutors(List<TutorEntity> tutors) {
    throw UnimplementedError('Save tutors not implemented for this repository');
  }

  Future<void> saveTutor(TutorEntity tutor) {
    throw UnimplementedError('Save tutor not implemented for this repository');
  }
}

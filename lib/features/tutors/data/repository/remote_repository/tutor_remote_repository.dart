import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/tutors/data/data_source/remote_data_source/tutor_remote_data_source.dart';
import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';
import 'package:tutorme/features/tutors/domain/repository/tutor_repository.dart';

class TutorRemoteRepository implements ITutorRepository {
  final TutorRemoteDataSource _tutorRemoteDataSource;

  TutorRemoteRepository(this._tutorRemoteDataSource);

  @override
  Future<Either<Failure, List<TutorEntity>>> getAllTutors(
      {int page = 1, int limit = 10}) async {
    try {
      debugPrint("Fetching all tutors page: $page, limit: $limit");
      final tutors =
          await _tutorRemoteDataSource.getAllTutors(page: page, limit: limit);
      return Right(tutors);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TutorEntity>> getTutorByUsername(
      String username) async {
    try {
      debugPrint("Fetching tutor with username: $username");
      final tutor = await _tutorRemoteDataSource.getTutorByUsername(username);
      return Right(tutor);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<void> saveTutors(List<TutorEntity> tutors) async {
    throw UnimplementedError(
        'Saving tutors is not supported in the remote repository');
  }

  @override
  Future<void> saveTutor(TutorEntity tutor) async {
    throw UnimplementedError(
        'Saving a tutor is not supported in the remote repository');
  }
}

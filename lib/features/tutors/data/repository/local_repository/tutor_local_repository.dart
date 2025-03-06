import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/tutors/data/data_source/local_data_source/tutor_local_data_source.dart';
import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';
import 'package:tutorme/features/tutors/domain/repository/tutor_repository.dart';

class TutorLocalRepository implements ITutorRepository {
  final TutorLocalDataSource _tutorLocalDataSource;

  TutorLocalRepository(this._tutorLocalDataSource);

  @override
  Future<Either<Failure, List<TutorEntity>>> getAllTutors({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      debugPrint(
          "Fetching all tutors from local storage - page: $page, limit: $limit");
      final tutors = await _tutorLocalDataSource.getAllTutors();

      final startIndex = (page - 1) * limit;
      final endIndex = startIndex + limit;

      if (startIndex >= tutors.length) {
        return const Right(
            []);
      }

      final paginatedTutors = tutors.sublist(
        startIndex,
        endIndex > tutors.length ? tutors.length : endIndex,
      );

      return Right(paginatedTutors);
    } catch (e) {
      return Left(
          ApiFailure(message: "Failed to fetch tutors from local storage: $e"));
    }
  }

  @override
  Future<Either<Failure, TutorEntity>> getTutorByUsername(
      String username) async {
    try {
      debugPrint("Fetching tutor with username from local storage: $username");
      final tutor = await _tutorLocalDataSource.getTutorByUsername(username);
      return Right(tutor);
    } catch (e) {
      return Left(
          ApiFailure(message: "Failed to fetch tutor from local storage: $e"));
    }
  }
  
  @override
  Future<void> saveTutors(List<TutorEntity> tutors) async {
    try {
      debugPrint("Saving ${tutors.length} tutors to local storage");
      await _tutorLocalDataSource.saveTutors(tutors);
    } catch (e) {
      throw Exception("Failed to save tutors to local storage: $e");
    }
  }

  @override
  Future<void> saveTutor(TutorEntity tutor) async {
    try {
      debugPrint("Saving tutor ${tutor.username} to local storage");
      await _tutorLocalDataSource.saveTutor(tutor);
    } catch (e) {
      throw Exception("Failed to save tutor to local storage: $e");
    }
  }
}

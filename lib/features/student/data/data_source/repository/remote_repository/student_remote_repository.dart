import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/student/data/data_source/student_remote_data_source.dart/student_remote_data_source.dart';
import 'package:tutorme/features/student/domain/entity/student_entity.dart';
import 'package:tutorme/features/student/domain/repository/student_repository.dart';

class StudentRemoteRepository implements IStudentRepository {
  final StudentRemoteDataSource _studentRemoteDataSource;

  StudentRemoteRepository(this._studentRemoteDataSource);

  @override
  Future<Either<Failure, StudentEntity>> getStudentProfile() async {
    try {
      debugPrint("Fetching student profile...");
      final student = await _studentRemoteDataSource.getStudentProfile();
      return Right(student);
    } catch (e) {
      debugPrint("Error fetching student profile: $e");
      return Left(ApiFailure(message: e.toString()));
    }
  }
}

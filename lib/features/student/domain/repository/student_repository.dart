import 'package:dartz/dartz.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/student/data/dto/update_student_profile_dto.dart';
import 'package:tutorme/features/student/domain/entity/student_entity.dart';

abstract class IStudentRepository {
  Future<Either<Failure, StudentEntity>> getStudentProfile();
  Future<Either<Failure, StudentEntity>> updateStudentProfile(UpdateStudentProfileDTO updatedData);
}

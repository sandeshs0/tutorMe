import 'package:dartz/dartz.dart';
import 'package:tutorme/app/usecase/usecase.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/student/domain/entity/student_entity.dart';
import 'package:tutorme/features/student/domain/repository/student_repository.dart';

class GetStudentProfileUsecase implements UsecaseWithoutParams<StudentEntity> {
  final IStudentRepository repository;

  GetStudentProfileUsecase({required this.repository});

  @override
  Future<Either<Failure, StudentEntity>> call() async {
    return await repository.getStudentProfile();
  }
}

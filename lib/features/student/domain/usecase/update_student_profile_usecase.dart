import 'package:dartz/dartz.dart';
import 'package:tutorme/app/usecase/usecase.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/student/data/dto/update_student_profile_dto.dart';
import 'package:tutorme/features/student/domain/entity/student_entity.dart';
import 'package:tutorme/features/student/domain/repository/student_repository.dart';

class UpdateStudentProfileUsecase implements UsecaseWithParams<StudentEntity, UpdateStudentProfileDTO> {
  final IStudentRepository studentRepository;

  UpdateStudentProfileUsecase({required this.studentRepository});

  @override
  Future<Either<Failure, StudentEntity>> call(UpdateStudentProfileDTO params) async {
    return await studentRepository.updateStudentProfile(params);
  }
}

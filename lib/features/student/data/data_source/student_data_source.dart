import 'package:tutorme/features/student/data/dto/update_student_profile_dto.dart';
import 'package:tutorme/features/student/domain/entity/student_entity.dart';

abstract interface class IStudentDataSource {
  Future<StudentEntity> getStudentProfile();
    Future<StudentEntity> updateStudentProfile(UpdateStudentProfileDTO updatedData);

}

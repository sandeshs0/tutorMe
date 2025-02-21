import 'package:tutorme/features/student/domain/entity/student_entity.dart';

abstract interface class IStudentDataSource {
  Future<StudentEntity> getStudentProfile();
}

import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';

abstract interface class ITutorDataSource {
  Future<List<TutorEntity>> getAllTutors();

  Future<TutorEntity> getTutorByUsername(String username);
}

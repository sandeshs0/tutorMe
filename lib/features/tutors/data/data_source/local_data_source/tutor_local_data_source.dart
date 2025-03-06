// features/tutors/data/data_source/local_data_source/tutor_local_data_source.dart
import 'package:tutorme/core/network/hive_service.dart';
import 'package:tutorme/features/tutors/data/model/tutor_hive_model.dart';
import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';

abstract class ITutorLocalDataSource {
  Future<List<TutorEntity>> getAllTutors();
  Future<TutorEntity> getTutorByUsername(String username);
  Future<void> saveTutors(List<TutorEntity> tutors);
  Future<void> saveTutor(TutorEntity tutor);
}

class TutorLocalDataSource implements ITutorLocalDataSource {
  final HiveService _hiveService;

  TutorLocalDataSource(this._hiveService);

  @override
  Future<List<TutorEntity>> getAllTutors() async {
    final tutors = await _hiveService.getAllTutors();
    return tutors.map((tutor) => tutor.toEntity()).toList();
  }

  @override
  Future<TutorEntity> getTutorByUsername(String username) async {
    final tutor = await _hiveService.getTutorByUsername(username);
    if (tutor == null) {
      throw Exception('Tutor not found in local storage');
    }
    return tutor.toEntity();
  }

  @override
  Future<void> saveTutors(List<TutorEntity> tutors) async {
    for (var tutor in tutors) {
      await _hiveService.addTutor(TutorHiveModel.fromEntity(tutor));
    }
  }

  @override
  Future<void> saveTutor(TutorEntity tutor) async {
    await _hiveService.addTutor(TutorHiveModel.fromEntity(tutor));
  }
}

import 'package:hive_flutter/hive_flutter.dart';
import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';

part 'tutor_hive_model.g.dart';

@HiveType(typeId: 1)  // Matches tutorTableId from HiveTableConstant
class TutorHiveModel extends HiveObject {
  @HiveField(0)
  final String? id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String email;
  
  @HiveField(3)
  final String username;
  
  @HiveField(4)
  final String profileImage;
  
  @HiveField(5)
  final String bio;
  
  @HiveField(6)
  final double hourlyRate;
  
  @HiveField(7)
  final String description;
  
  @HiveField(8)
  final double rating;
  
  @HiveField(9)
  final List<String> subjects;

  TutorHiveModel({
    this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.profileImage,
    required this.bio,
    required this.hourlyRate,
    required this.description,
    required this.rating,
    required this.subjects,
  });

  factory TutorHiveModel.fromEntity(TutorEntity entity) {
    return TutorHiveModel(
      id: entity.tutorId,
      name: entity.name,
      email: entity.email,
      username: entity.username,
      profileImage: entity.profileImage,
      bio: entity.bio,
      hourlyRate: entity.hourlyRate,
      description: entity.description,
      rating: entity.rating,
      subjects: entity.subjects,
    );
  }

  TutorEntity toEntity() {
    return TutorEntity(
      tutorId: id,
      name: name,
      email: email,
      username: username,
      profileImage: profileImage,
      bio: bio,
      description: description,
      hourlyRate: hourlyRate,
      rating: rating,
      subjects: subjects,
    );
  }
}
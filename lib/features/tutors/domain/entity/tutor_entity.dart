import 'package:equatable/equatable.dart';

class TutorEntity extends Equatable {
  final String? tutorId;
  final String name;
  final String profileImage;
  final String email;
  final String username;
  final String bio;
  final String description;
  final double hourlyRate;
  final double rating;
  final List<String> subjects;

  const TutorEntity({
    this.tutorId,
    required this.name,
    required this.email,
    required this.bio,
    required this.description,
    required this.hourlyRate,
    required this.profileImage,
    required this.rating,
    required this.subjects,
    required this.username,
  });
  @override
  List<Object?> get props => [
        tutorId,
        name,
        email,
        profileImage,
        bio,
        description,
        subjects,
        rating,
        hourlyRate,
        username,
      ];
}

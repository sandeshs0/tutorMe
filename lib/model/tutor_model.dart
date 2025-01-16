import 'package:equatable/equatable.dart';

class TutorModel extends Equatable {
  final String name;
  final String age;
  final int hourlyRate;
  final List<String> subjects;
  final int minutesTutored;
  final double rating;
  final String bio;
  final String description;
  final String totalStudents;

  const TutorModel({
    required this.name,
    required this.age,
    required this.hourlyRate,
    required this.subjects,
    required this.rating,
    required this.minutesTutored,
    required this.bio,
    required this.description,
    required this.totalStudents,
  });

  @override
  List<Object> get props => [
        name,
        age,
        hourlyRate,
        subjects,
        rating,
        minutesTutored,
        bio,
        description,
        totalStudents,
      ];
}

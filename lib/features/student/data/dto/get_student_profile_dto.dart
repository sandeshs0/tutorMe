import 'package:json_annotation/json_annotation.dart';
import 'package:tutorme/features/student/domain/entity/student_entity.dart';

part 'get_student_profile_dto.g.dart';

@JsonSerializable()
class GetStudentProfileDTO {
  final String message;
  final StudentProfileDTO student;

  GetStudentProfileDTO({
    required this.message,
    required this.student,
  });

  factory GetStudentProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$GetStudentProfileDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetStudentProfileDTOToJson(this);
}

@JsonSerializable()
class StudentProfileDTO {
  final String studentId;
  final String name;
  final String email;
  final String phone;
  final String profileImage;
  final String role;
  final double walletBalance;

  StudentProfileDTO({
    required this.studentId,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.role,
    required this.walletBalance,
  });

  factory StudentProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$StudentProfileDTOFromJson(json);

  Map<String, dynamic> toJson() => _$StudentProfileDTOToJson(this);

  StudentEntity toEntity() {
    return StudentEntity(
      studentId: studentId,
      name: name,
      email: email,
      phone: phone,
      profileImage: profileImage,
      role: role,
      walletBalance: walletBalance,
    );
  }
}

import 'package:json_annotation/json_annotation.dart';

part 'update_student_profile_dto.g.dart';

@JsonSerializable()
class UpdateStudentProfileDTO {
  final String? name;
  final String? email;
  final String? phone;
  final String? profileImage; // Optional

  UpdateStudentProfileDTO({
    this.name,
    this.email,
    this.phone,
    this.profileImage,
  });

  factory UpdateStudentProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$UpdateStudentProfileDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateStudentProfileDTOToJson(this);
}

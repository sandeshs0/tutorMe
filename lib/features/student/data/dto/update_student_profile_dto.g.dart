// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_student_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateStudentProfileDTO _$UpdateStudentProfileDTOFromJson(
        Map<String, dynamic> json) =>
    UpdateStudentProfileDTO(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      profileImage: json['profileImage'] as String?,
    );

Map<String, dynamic> _$UpdateStudentProfileDTOToJson(
        UpdateStudentProfileDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'profileImage': instance.profileImage,
    };

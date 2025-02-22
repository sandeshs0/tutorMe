// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_student_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetStudentProfileDTO _$GetStudentProfileDTOFromJson(
        Map<String, dynamic> json) =>
    GetStudentProfileDTO(
      message: json['message'] as String,
      student:
          StudentProfileDTO.fromJson(json['student'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetStudentProfileDTOToJson(
        GetStudentProfileDTO instance) =>
    <String, dynamic>{
      'message': instance.message,
      'student': instance.student,
    };

StudentProfileDTO _$StudentProfileDTOFromJson(Map<String, dynamic> json) =>
    StudentProfileDTO(
      studentId: json['studentId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      profileImage: json['profileImage'] as String,
      role: json['role'] as String,
      walletBalance: (json['walletBalance'] as num).toDouble(),
    );

Map<String, dynamic> _$StudentProfileDTOToJson(StudentProfileDTO instance) =>
    <String, dynamic>{
      'studentId': instance.studentId,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'profileImage': instance.profileImage,
      'role': instance.role,
      'walletBalance': instance.walletBalance,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentApiModel _$StudentApiModelFromJson(Map<String, dynamic> json) =>
    StudentApiModel(
      studentId: json['_id'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      profileImage: json['profileImage'] as String,
      role: json['role'] as String,
      walletBalance: (json['walletBalance'] as num).toDouble(),
    );

Map<String, dynamic> _$StudentApiModelToJson(StudentApiModel instance) =>
    <String, dynamic>{
      '_id': instance.studentId,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'profileImage': instance.profileImage,
      'role': instance.role,
      'walletBalance': instance.walletBalance,
    };

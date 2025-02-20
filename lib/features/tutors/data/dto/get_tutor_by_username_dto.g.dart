// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_tutor_by_username_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTutorByUsernameDTO _$GetTutorByUsernameDTOFromJson(
        Map<String, dynamic> json) =>
    GetTutorByUsernameDTO(
      message: json['message'] as String,
      tutor: TutorApiModel.fromJson(json['tutor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetTutorByUsernameDTOToJson(
        GetTutorByUsernameDTO instance) =>
    <String, dynamic>{
      'message': instance.message,
      'tutor': instance.tutor,
    };

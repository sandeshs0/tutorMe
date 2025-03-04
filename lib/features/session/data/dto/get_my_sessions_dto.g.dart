// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_my_sessions_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetStudentSessionsDTO _$GetStudentSessionsDTOFromJson(
        Map<String, dynamic> json) =>
    GetStudentSessionsDTO(
      success: json['success'] as bool,
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) => SessionApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetStudentSessionsDTOToJson(
        GetStudentSessionsDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'sessions': instance.sessions,
    };

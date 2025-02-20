// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_tutors_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllTutorsDTO _$GetAllTutorsDTOFromJson(Map<String, dynamic> json) =>
    GetAllTutorsDTO(
      message: json['message'] as String,
      tutors: (json['tutors'] as List<dynamic>)
          .map((e) => TutorApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination:
          PaginationDTO.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetAllTutorsDTOToJson(GetAllTutorsDTO instance) =>
    <String, dynamic>{
      'message': instance.message,
      'tutors': instance.tutors,
      'pagination': instance.pagination,
    };

PaginationDTO _$PaginationDTOFromJson(Map<String, dynamic> json) =>
    PaginationDTO(
      currentPage: (json['currentPage'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      totalTutors: (json['totalTutors'] as num).toInt(),
    );

Map<String, dynamic> _$PaginationDTOToJson(PaginationDTO instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'totalTutors': instance.totalTutors,
    };

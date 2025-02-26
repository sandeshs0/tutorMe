// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_booking_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBookingDTO _$CreateBookingDTOFromJson(Map<String, dynamic> json) =>
    CreateBookingDTO(
      tutorId: json['tutorId'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      note: json['note'] as String,
    );

Map<String, dynamic> _$CreateBookingDTOToJson(CreateBookingDTO instance) =>
    <String, dynamic>{
      'tutorId': instance.tutorId,
      'date': instance.date,
      'time': instance.time,
      'note': instance.note,
    };

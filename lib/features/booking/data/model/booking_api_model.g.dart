// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingApiModel _$BookingApiModelFromJson(Map<String, dynamic> json) =>
    BookingApiModel(
      bookingId: json['_id'] as String?,
      tutorId: json['tutorId'] as String,
      studentId: json['studentId'] as String,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      note: json['note'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$BookingApiModelToJson(BookingApiModel instance) =>
    <String, dynamic>{
      '_id': instance.bookingId,
      'tutorId': instance.tutorId,
      'studentId': instance.studentId,
      'date': instance.date,
      'startTime': instance.startTime,
      'note': instance.note,
      'status': instance.status,
    };

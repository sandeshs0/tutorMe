// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionApiModel _$SessionApiModelFromJson(Map<String, dynamic> json) =>
    SessionApiModel(
      sessionId: json['sessionId'] as String?,
      bookingId: json['bookingId'] as String?,
      tutorId: json['tutorId'] as String?,
      tutorName: json['tutorName'] as String,
      tutorEmail: json['tutorEmail'] as String,
      roomId: json['roomId'] as String?,
      date: SessionApiModel._dateFromJson(json['date'] as String),
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      status: json['status'] as String,
      duration: (json['duration'] as num).toDouble(),
      actualDuration: (json['actualDuration'] as num).toDouble(),
      totalFee: (json['totalFee'] as num).toDouble(),
      platformFee: (json['platformFee'] as num).toDouble(),
      tutorEarnings: (json['tutorEarnings'] as num).toDouble(),
    );

Map<String, dynamic> _$SessionApiModelToJson(SessionApiModel instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'bookingId': instance.bookingId,
      'tutorId': instance.tutorId,
      'tutorName': instance.tutorName,
      'tutorEmail': instance.tutorEmail,
      'roomId': instance.roomId,
      'date': SessionApiModel._dateToJson(instance.date),
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'status': instance.status,
      'duration': instance.duration,
      'actualDuration': instance.actualDuration,
      'totalFee': instance.totalFee,
      'platformFee': instance.platformFee,
      'tutorEarnings': instance.tutorEarnings,
    };

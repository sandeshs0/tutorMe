// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_student_bookings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetStudentBookingsDTO _$GetStudentBookingsDTOFromJson(
        Map<String, dynamic> json) =>
    GetStudentBookingsDTO(
      message: json['message'] as String,
      bookings: (json['bookings'] as List<dynamic>)
          .map((e) => BookingApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetStudentBookingsDTOToJson(
        GetStudentBookingsDTO instance) =>
    <String, dynamic>{
      'message': instance.message,
      'bookings': instance.bookings,
    };

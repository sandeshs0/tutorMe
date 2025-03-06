import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/booking_entity.dart';

part 'booking_api_model.g.dart';

@JsonSerializable()
class BookingApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? bookingId;
  final String? tutorId;
  final String? tutorName;
  final String? profileImage;
  final int? hourlyRate;
  final String studentId;
  final String date;
  final String startTime;
  final String note;
  final String status;
  final int? bookingFee;

  const BookingApiModel({
    this.bookingId,
    this.tutorId,
    required this.studentId,
    required this.date,
    required this.startTime,
    required this.note,
    required this.status,
    this.hourlyRate,
    this.tutorName,
    this.profileImage,
    this.bookingFee,
  });


  factory BookingApiModel.fromJson(Map<String, dynamic> json) {
    debugPrint("Raw Booking Data: $json");

    return BookingApiModel(
      bookingId:
          json['_id']?.toString() ?? '', 
      tutorId: json['tutorId']?.toString() ?? '',
      studentId: json['studentId']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      startTime: json['startTime']?.toString() ?? '',
      note: json['note']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      bookingFee: json['bookingFee'] as int? ?? 0, 
      tutorName: json['tutorName']?.toString() ?? '',
      profileImage: json['profileImage']?.toString() ?? '',
      hourlyRate: json['hourlyRate'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => _$BookingApiModelToJson(this);

  BookingEntity toEntity() {
    return BookingEntity(
      id: bookingId ?? '',
      tutorId: tutorId,
      studentId: studentId,
      date: date,
      tutorName: tutorName,
      profileImage: profileImage,
      hourlyRate: hourlyRate,
      startTime: startTime,
      note: note,
      status: status,
      bookingFee: bookingFee,
    );
  }

  factory BookingApiModel.fromEntity(BookingEntity entity) {
    return BookingApiModel(
      bookingId: entity.id,
      tutorId: entity.tutorId,
      studentId: entity.studentId,
      date: entity.date,
      startTime: entity.startTime,
      tutorName: entity.tutorName,
      profileImage: entity.profileImage,
      hourlyRate: entity.hourlyRate,
      note: entity.note,
      status: entity.status,
      bookingFee: entity.bookingFee,
    );
  }

  @override
  List<Object?> get props => [
        bookingId,
        tutorId,
        studentId,
        tutorName,
        profileImage,
        hourlyRate,
        date,
        startTime,
        note,
        status,
        bookingFee,
      ];
}

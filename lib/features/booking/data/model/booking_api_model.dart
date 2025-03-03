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
  // @JsonKey(name: 'tutorObj')
  // final TutorApiModel? tutorObj;
  final String studentId;
  final String date;
  final String startTime;
  final String note;
  final String status;
  final int? bookingFee;
  // final String? updatedAt;
  // final String? createdAt;

  const BookingApiModel({
    this.bookingId,
    this.tutorId,
    required this.studentId,
    required this.date,
    required this.startTime,
    required this.note,
    required this.status,
    // this.tutorObj,
    this.hourlyRate,
    this.tutorName,
    this.profileImage,
    this.bookingFee,
    //  this.updatedAt,
  });

  /// **Convert from JSON**
  // factory BookingApiModel.fromJson(Map<String, dynamic> json) =>
  //     _$BookingApiModelFromJson(json);

  factory BookingApiModel.fromJson(Map<String, dynamic> json) {
    debugPrint("📌 Raw Booking Data: $json"); // <-- Log raw data

    return BookingApiModel(
      bookingId:
          json['_id']?.toString() ?? '', // ✅ Ensure _id is always a String
      tutorId: json['tutorId']?.toString() ?? '',
      studentId: json['studentId']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      startTime: json['startTime']?.toString() ?? '',
      note: json['note']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      bookingFee: json['bookingFee'] as int? ?? 0, // ✅ Handle null integer case
      tutorName: json['tutorName']?.toString() ?? '',
      profileImage: json['profileImage']?.toString() ?? '',
      hourlyRate: json['hourlyRate'] as int? ?? 0,
    );
  }

  /// **Convert to JSON**
  Map<String, dynamic> toJson() => _$BookingApiModelToJson(this);

  /// **Convert to Domain Entity**
  BookingEntity toEntity() {
    return BookingEntity(
      id: bookingId ?? '',
      tutorId: tutorId,
      studentId: studentId,
      // tutorObj: tutorObj,
      date: date,
      tutorName: tutorName,
      profileImage: profileImage,
      hourlyRate: hourlyRate,
      startTime: startTime,
      note: note,
      status: status,
      bookingFee: bookingFee,
      // updatedAt: updatedAt,
    );
  }

  /// **Convert from Domain Entity**
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
      // tutorObj: entity.tutorObj,
      bookingFee: entity.bookingFee,
      // updatedAt: entity.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        bookingId,
        tutorId,
        // tutorObj,
        // updatedAt,
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

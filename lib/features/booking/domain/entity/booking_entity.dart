import 'package:equatable/equatable.dart';

class BookingEntity extends Equatable {
  final String id;
  final String? tutorId;
  final String studentId;
  final String date;
  final String startTime;
  final String note;
  final String status;
  final int? bookingFee;
  final String? tutorName;
  final String? profileImage;
  final int? hourlyRate;

  const BookingEntity({
    required this.id,
    required this.tutorId,
    required this.studentId,
    this.bookingFee,
    required this.date,
    required this.startTime,
    required this.note,
    required this.status,
    this.hourlyRate,
    this.profileImage,
    this.tutorName,
  });

  @override
  List<Object?> get props => [
        id,
        tutorId,
        bookingFee,
        studentId,
        date,
        startTime,
        note,
        status,
        tutorName,
        hourlyRate,
        profileImage,
      ];
}

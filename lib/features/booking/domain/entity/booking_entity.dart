import 'package:equatable/equatable.dart';

class BookingEntity extends Equatable {
  final String id;
  final String tutorId;
  final String studentId;
  final String date;
  final String startTime;
  final String note;
  final String status;

  const BookingEntity({
    required this.id,
    required this.tutorId,
    required this.studentId,
    required this.date,
    required this.startTime,
    required this.note,
    required this.status,
  });

  @override
  List<Object?> get props => [id, tutorId, studentId, date, startTime, note, status];
}
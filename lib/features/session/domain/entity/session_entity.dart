import 'package:equatable/equatable.dart';

class SessionEntity extends Equatable {
  final String? sessionId;
  final String? bookingId;
  final String? tutorId;
  final String tutorName;
  final String tutorEmail;
  final String? roomId;
  final DateTime date;
  final String? startTime;
  final String? endTime;
  final String status;
  final double duration;
  final double actualDuration;
  final double totalFee;
  final double platformFee;
  final double tutorEarnings;

  const SessionEntity({
    this.sessionId,
    this.bookingId,
    this.tutorId,
    required this.tutorName,
    required this.tutorEmail,
    this.roomId,
    required this.date,
    this.startTime,
    this.endTime,
    required this.status,
    required this.duration,
    required this.actualDuration,
    required this.totalFee,
    required this.platformFee,
    required this.tutorEarnings,
  });

  @override
  List<Object?> get props => [
        sessionId,
        bookingId,
        tutorId,
        tutorName,
        tutorEmail,
        roomId,
        date,
        startTime,
        endTime,
        status,
        duration,
        actualDuration,
        totalFee,
        platformFee,
        tutorEarnings,
      ];
}
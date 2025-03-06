import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tutorme/features/session/domain/entity/session_entity.dart';

part 'session_api_model.g.dart';

@JsonSerializable()
class SessionApiModel extends Equatable {
  final String? sessionId;
  final String? bookingId;
  final String? tutorId;
  final String tutorName;
  final String tutorEmail;
  final String? roomId;
  @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime date;
  final String? startTime;
  final String? endTime;
  final String status;
  final double duration;
  final double actualDuration;
  final double totalFee;
  final double platformFee;
  final double tutorEarnings;

  const SessionApiModel({
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

  // From JSON
  factory SessionApiModel.fromJson(Map<String, dynamic> json) =>
      _$SessionApiModelFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$SessionApiModelToJson(this);

  // Convert to Domain Entity
  SessionEntity toEntity() {
    return SessionEntity(
      sessionId: sessionId,
      bookingId: bookingId,
      tutorId: tutorId,
      tutorName: tutorName,
      tutorEmail: tutorEmail,
      roomId: roomId,
      date: date,
      startTime: startTime,
      endTime: endTime,
      status: status,
      duration: duration,
      actualDuration: actualDuration,
      totalFee: totalFee,
      platformFee: platformFee,
      tutorEarnings: tutorEarnings,
    );
  }

  factory SessionApiModel.fromEntity(SessionEntity entity) {
    return SessionApiModel(
      sessionId: entity.sessionId,
      bookingId: entity.bookingId,
      tutorId: entity.tutorId,
      tutorName: entity.tutorName,
      tutorEmail: entity.tutorEmail,
      roomId: entity.roomId,
      date: entity.date,
      startTime: entity.startTime,
      endTime: entity.endTime,
      status: entity.status,
      duration: entity.duration,
      actualDuration: entity.actualDuration,
      totalFee: entity.totalFee,
      platformFee: entity.platformFee,
      tutorEarnings: entity.tutorEarnings,
    );
  }

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

  // Helper method to parse DateTime from JSON string
  static DateTime _dateFromJson(String dateStr) {
    return DateTime.parse(dateStr).toLocal();
  }

  // Helper method to convert DateTime to JSON string
  static String _dateToJson(DateTime date) {
    return date.toUtc().toIso8601String();
  }
}
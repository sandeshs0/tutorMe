import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/booking_entity.dart';

part 'booking_api_model.g.dart';

@JsonSerializable()
class BookingApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? bookingId;
  final String tutorId;
  final String studentId;
  final String date;
  final String startTime;
  final String note;
  final String status;

  const BookingApiModel({
    this.bookingId,
    required this.tutorId,
    required this.studentId,
    required this.date,
    required this.startTime,
    required this.note,
    required this.status,
  });

  /// **Convert from JSON**
  factory BookingApiModel.fromJson(Map<String, dynamic> json) =>
      _$BookingApiModelFromJson(json);

  /// **Convert to JSON**
  Map<String, dynamic> toJson() => _$BookingApiModelToJson(this);

  /// **Convert to Domain Entity**
  BookingEntity toEntity() {
    return BookingEntity(
      id: bookingId ?? '',
      tutorId: tutorId,
      studentId: studentId,
      date: date,
      startTime: startTime,
      note: note,
      status: status,
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
      note: entity.note,
      status: entity.status,
    );
  }

  @override
  List<Object?> get props => [
        bookingId,
        tutorId,
        studentId,
        date,
        startTime,
        note,
        status,
      ];
}

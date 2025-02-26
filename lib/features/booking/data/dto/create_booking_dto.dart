import 'package:json_annotation/json_annotation.dart';

part 'create_booking_dto.g.dart';

@JsonSerializable()
class CreateBookingDTO {
  final String tutorId;
  final String date;
  final String time;
  final String note;

  CreateBookingDTO({
    required this.tutorId,
    required this.date,
    required this.time,
    required this.note,
  });

  /// Convert from JSON
  factory CreateBookingDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateBookingDTOFromJson(json);

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$CreateBookingDTOToJson(this);
}
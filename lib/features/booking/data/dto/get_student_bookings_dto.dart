import 'package:json_annotation/json_annotation.dart';
import 'package:tutorme/features/booking/data/model/booking_api_model.dart';

part 'get_student_bookings_dto.g.dart';

@JsonSerializable()
class GetStudentBookingsDTO {
  final String message;
  final List<BookingApiModel> bookings;

  GetStudentBookingsDTO({
    required this.message,
    required this.bookings,
  });

  /// Convert from JSON
  factory GetStudentBookingsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetStudentBookingsDTOFromJson(json);

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$GetStudentBookingsDTOToJson(this);
}

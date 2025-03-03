// import 'package:json_annotation/json_annotation.dart';
// import 'package:tutorme/features/tutors/data/model/tutor_api_model.dart';
// import 'package:tutorme/features/booking/domain/entity/booking_entity.dart';

// part 'student_bookings_api_model.g.dart';

// @JsonSerializable()
// class StudentBookingsApiModel {
//   @JsonKey(name: '_id')
//   final String bookingId;
  
//   @JsonKey(name: 'tutorId')
//   final TutorApiModel tutor;
  
//   @JsonKey(name: 'studentId')
//   final String studentId;

//   final String date;
//   final String startTime;
//   final String note;
//   final String status;
//   final double bookingFee;
//   final String createdAt;
//   final String updatedAt;

//   StudentBookingsApiModel({
//     required this.bookingId,
//     required this.tutor,
//     required this.studentId,
//     required this.date,
//     required this.startTime,
//     required this.note,
//     required this.status,
//     required this.bookingFee,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory StudentBookingsApiModel.fromJson(Map<String, dynamic> json) =>
//       _$StudentBookingsApiModelFromJson(json);

//   Map<String, dynamic> toJson() => _$StudentBookingsApiModelToJson(this);

//   /// Convert API model to domain entity
//   BookingEntity toEntity() {
//     return BookingEntity(
//       bookingId: bookingId,
//       tutor: tutor.toEntity(),  // Convert Tutor API Model to Entity
//       studentId: studentId,
//       date: date,
//       startTime: startTime,
//       note: note,
//       status: status,
//       bookingFee: bookingFee,
//       createdAt: createdAt,
//       updatedAt: updatedAt,
//     );
//   }
// }

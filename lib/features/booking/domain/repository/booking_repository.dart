import 'package:dartz/dartz.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/booking/data/dto/create_booking_dto.dart';
import 'package:tutorme/features/booking/domain/entity/booking_entity.dart';

abstract class IBookingRepository {
  // Future<Either<Failure, BookingEntity>> createBooking({
  //   required String tutorId,
  //   required String date,
  //   required String time,
  //   required String note,
  // });
  Future<Either<Failure, BookingEntity>> createBooking(
      CreateBookingDTO bookingData);

  Future<Either<Failure, List<BookingEntity>>> getStudentBookings();
}

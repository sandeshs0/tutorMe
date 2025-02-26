import 'package:dartz/dartz.dart';
import 'package:tutorme/app/usecase/usecase.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/booking/data/dto/create_booking_dto.dart';
import 'package:tutorme/features/booking/domain/entity/booking_entity.dart';
import 'package:tutorme/features/booking/domain/repository/booking_repository.dart';

class CreateBookingUseCase
    implements UsecaseWithParams<BookingEntity, CreateBookingParams> {
  final IBookingRepository bookingRepository;

  CreateBookingUseCase({required this.bookingRepository});

  @override
  Future<Either<Failure, BookingEntity>> call(
      CreateBookingParams params) async {
    return await bookingRepository.createBooking(
      CreateBookingDTO(
        tutorId: params.tutorId,
        date: params.date,
        time: params.time,
        note: params.note,
      ),
    );
  }
}

/// **Parameters for Booking Creation**
class CreateBookingParams {
  final String tutorId;
  final String date;
  final String time;
  final String note;

  CreateBookingParams({
    required this.tutorId,
    required this.date,
    required this.time,
    required this.note,
  });
}

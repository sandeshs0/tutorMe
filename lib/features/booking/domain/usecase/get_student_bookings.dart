import 'package:dartz/dartz.dart';
import 'package:tutorme/app/usecase/usecase.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/booking/domain/entity/booking_entity.dart';
import 'package:tutorme/features/booking/domain/repository/booking_repository.dart';

class GetStudentBookingsUseCase implements UsecaseWithoutParams<List<BookingEntity>> {
  final IBookingRepository bookingRepository;

  GetStudentBookingsUseCase({required this.bookingRepository});

  @override
  Future<Either<Failure, List<BookingEntity>>> call() async {
    return await bookingRepository.getStudentBookings();
  }
}
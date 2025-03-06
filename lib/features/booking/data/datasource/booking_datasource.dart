import 'package:tutorme/features/booking/data/dto/create_booking_dto.dart';
import 'package:tutorme/features/booking/domain/entity/booking_entity.dart';

abstract interface class IBookingRemoteDataSource {
    Future<BookingEntity> createBooking(CreateBookingDTO bookingData);


  Future<List<BookingEntity>> getStudentBookings();
}

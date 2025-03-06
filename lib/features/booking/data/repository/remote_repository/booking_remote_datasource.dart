import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/booking/data/datasource/booking_datasource.dart';
import 'package:tutorme/features/booking/data/dto/create_booking_dto.dart';
import 'package:tutorme/features/booking/domain/entity/booking_entity.dart';
import 'package:tutorme/features/booking/domain/repository/booking_repository.dart';

class RemoteBookingRepository implements IBookingRepository {
  final IBookingRemoteDataSource _bookingRemoteDataSource;

  RemoteBookingRepository(this._bookingRemoteDataSource);

  @override
  Future<Either<Failure, BookingEntity>> createBooking(CreateBookingDTO bookingData) async {
    try {
      debugPrint(" Creating booking...");
      final booking = await _bookingRemoteDataSource.createBooking(bookingData);
      debugPrint(" Booking created successfully: ${booking.id}");
      return Right(booking);
    } catch (e) {
      debugPrint(" Error creating booking: $e");
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookingEntity>>> getStudentBookings() async {
    try {
      debugPrint(" Fetching student bookings...");
      final bookings = await _bookingRemoteDataSource.getStudentBookings();
      debugPrint(" Fetched ${bookings.length} bookings.");
      return Right(bookings);
    } catch (e) {
      debugPrint(" Error fetching bookings: $e");
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
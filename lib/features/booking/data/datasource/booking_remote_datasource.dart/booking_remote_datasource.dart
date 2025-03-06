import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tutorme/app/constants/api_endpoints.dart';
import 'package:tutorme/app/shared_prefs/token_shared_prefs.dart';
import 'package:tutorme/features/booking/data/datasource/booking_datasource.dart';
import 'package:tutorme/features/booking/data/dto/create_booking_dto.dart';
import 'package:tutorme/features/booking/data/model/booking_api_model.dart';
import 'package:tutorme/features/booking/domain/entity/booking_entity.dart';

class BookingRemoteDataSource implements IBookingRemoteDataSource {
  final Dio _dio;
  final TokenSharedPrefs _tokenSharedPrefs;

  BookingRemoteDataSource({
    required Dio dio,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _dio = dio,
        _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<BookingEntity> createBooking(CreateBookingDTO bookingData) async {
    try {
      final tokenResult = await _tokenSharedPrefs.getToken();
      final token = tokenResult.fold((failure) => null, (token) => token);

      if (token == null || token.isEmpty) {
        throw Exception("Token not found in shared prefs");
      }

      final response = await _dio.post(
        ApiEndpoints.createBooking,
        options: Options(
          headers: {
            "Authorization": "Bearer $token", 
          },
        ),
        data: bookingData.toJson(),
      );

      if (response.statusCode == 201) {
        final bookingApiModel =
            BookingApiModel.fromJson(response.data['booking']);
        return bookingApiModel.toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw Exception("Something went wrong (BookingRemoteDataSource): $e");
    }
  }

  @override
  Future<List<BookingEntity>> getStudentBookings() async {
    try {
      final tokenResult = await _tokenSharedPrefs.getToken();
      final token = tokenResult.fold((failure) => null, (token) => token);

      if (token == null || token.isEmpty) {
        throw Exception("Token not found in shared prefs");
      }

      final response = await _dio.get(
        ApiEndpoints.getStudentBookings,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      debugPrint("Full API Response: ${response.data}");

      final rawData = response.data;
      final bookingsData = rawData['bookings'] as List<dynamic>? ?? [];

      final parsedBookings = bookingsData.map((booking) {
        debugPrint(" Parsing Booking: $booking");
        return BookingApiModel.fromJson(booking as Map<String, dynamic>)
            .toEntity();
      }).toList();

      debugPrint(" Parsed ${parsedBookings.length} bookings successfully");
      return parsedBookings;
    } catch (e, stacktrace) {
      debugPrint(" Parsing Error: $e");
      debugPrint(" Stacktrace: $stacktrace");
      throw Exception("Failed to fetch bookings");
    }
  }
}

import 'package:dio/dio.dart';
import 'package:tutorme/app/constants/api_endpoints.dart';
import 'package:tutorme/app/shared_prefs/token_shared_prefs.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/booking/data/datasource/booking_datasource.dart';
import 'package:tutorme/features/booking/data/dto/create_booking_dto.dart';
import 'package:tutorme/features/booking/data/dto/get_student_bookings_dto.dart';
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

  /// **🔹 Create a New Booking**
  @override
  Future<BookingEntity> createBooking(CreateBookingDTO bookingData) async {
    try {
      // ✅ Retrieve the stored JWT token
      final tokenResult = await _tokenSharedPrefs.getToken();
      final token = tokenResult.fold((failure) => null, (token) => token);

      if (token == null || token.isEmpty) {
        throw Exception("Token not found in shared prefs");
      }

      // ✅ API Request to Create a Booking
      final response = await _dio.post(
        ApiEndpoints.createBooking,
        options: Options(
          headers: {
            "Authorization": "Bearer $token", // ✅ Send JWT token
          },
        ),
        data: bookingData.toJson(),
      );

      if (response.statusCode == 201) {
        final bookingApiModel = BookingApiModel.fromJson(response.data['booking']);
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

  /// **🔹 Fetch Student Bookings**
  @override
  Future<List<BookingEntity>> getStudentBookings() async {
    try {
      // ✅ Retrieve the stored JWT token
      final tokenResult = await _tokenSharedPrefs.getToken();
      final token = tokenResult.fold((failure) => null, (token) => token);

      if (token == null || token.isEmpty) {
        throw Exception("Token not found in shared prefs");
      }

      // ✅ API Request to Fetch Student's Bookings
      final response = await _dio.get(
        ApiEndpoints.getStudentBookings,
        options: Options(
          headers: {
            "Authorization": "Bearer $token", // ✅ Send JWT token
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = GetStudentBookingsDTO.fromJson(response.data);
        return data.bookings.map((booking) => booking.toEntity()).toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }
}

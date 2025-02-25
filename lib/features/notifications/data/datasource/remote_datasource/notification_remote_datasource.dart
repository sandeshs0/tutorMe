import 'package:dio/dio.dart';
import 'package:tutorme/app/constants/api_endpoints.dart';
import 'package:tutorme/app/shared_prefs/token_shared_prefs.dart';
import 'package:tutorme/features/notifications/data/datasource/notification_datasource.dart';
import 'package:tutorme/features/notifications/data/dto/get_all_notifications_dto.dart';
import 'package:tutorme/features/notifications/domain/entity/notification_entity.dart';

class NotificationRemoteDataSource implements INotificationRemoteDataSource {
  final Dio _dio;
  final TokenSharedPrefs _tokenSharedPrefs;

  NotificationRemoteDataSource({
    required Dio dio,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _dio = dio,
        _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<List<NotificationEntity>> fetchNotifications() async {
    try {
      final tokenResult = await _tokenSharedPrefs.getToken();
      final token = tokenResult.fold((failure) => null, (token) => token);

      if (token == null || token.isEmpty) {
        throw Exception("Token not found in shared prefs");
      }
      final response = await _dio.get(
        ApiEndpoints.fetchNotifications,
        options: Options(
          headers: {
            "Authorization": "Bearer $token", // Send JWT token
          },
        ),
      );
      if (response.statusCode == 200) {
        final data = GetNotificationsDTO.fromJson(response.data);
        return data.notifications
            .map((notification) => notification.toEntity())
            .toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  @override
  Future<void> markNotificationsAsRead() async {
    try {
      final tokenResult = await _tokenSharedPrefs.getToken();
      final token = tokenResult.fold((failure) => null, (token) => token);

      if (token == null || token.isEmpty) {
        throw Exception("Token not found in shared prefs");
      }

      final response = await _dio.put(
        ApiEndpoints.readNotification,
        options: Options(
          headers: {
            "Authorization": "Bearer $token", // Send JWT token
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw Exception("Something went wrong (datasource): $e");
    }
  }
}

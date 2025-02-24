import 'package:dio/dio.dart';
import 'package:tutorme/app/constants/api_endpoints.dart';
import 'package:tutorme/features/notifications/data/datasource/notification_datasource.dart';
import 'package:tutorme/features/notifications/data/dto/get_all_notifications_dto.dart';
import 'package:tutorme/features/notifications/domain/entity/notification_entity.dart';

class NotificationRemoteDataSource implements INotificationRemoteDataSource {
  final Dio _dio;

  NotificationRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<NotificationEntity>> fetchNotifications() async {
    try {
      final response = await _dio.get(ApiEndpoints.fetchNotifications);

      if (response.statusCode == 200) {
        final data = GetNotificationsDTO.fromJson(response.data);
        return data.notifications.map((notification) => notification.toEntity()).toList();
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
      final response = await _dio.put(ApiEndpoints.readNotification);

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

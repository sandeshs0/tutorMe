import 'package:json_annotation/json_annotation.dart';
import 'package:tutorme/features/notifications/data/model/notification_api_model.dart';

part 'get_all_notifications_dto.g.dart';

@JsonSerializable()
class GetNotificationsDTO {
  final List<NotificationApiModel> notifications;

  GetNotificationsDTO({
    required this.notifications,
  });

  /// **Fix: Handle list response properly**
  factory GetNotificationsDTO.fromJson(List<dynamic> jsonList) {
    return GetNotificationsDTO(
      notifications: jsonList
          .map((json) => NotificationApiModel.fromJson(json as Map<String, dynamic>))
          .toList(),
    );
  }

  /// **Convert to JSON** (Not really needed for list responses, but keeping for consistency)
  Map<String, dynamic> toJson() => {
        'notifications': notifications.map((notification) => notification.toJson()).toList(),
      };
}

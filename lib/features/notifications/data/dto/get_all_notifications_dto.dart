import 'package:json_annotation/json_annotation.dart';
import 'package:tutorme/features/notifications/data/model/notification_api_model.dart';

part 'get_all_notifications_dto.g.dart';

@JsonSerializable()
class GetNotificationsDTO {
  final String message;
  final List<NotificationApiModel> notifications;

  GetNotificationsDTO({
    required this.message,
    required this.notifications,
  });

  /// **Convert from JSON**
  factory GetNotificationsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetNotificationsDTOFromJson(json);

  /// **Convert to JSON**
  Map<String, dynamic> toJson() => _$GetNotificationsDTOToJson(this);
}

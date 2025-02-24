// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_notifications_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNotificationsDTO _$GetNotificationsDTOFromJson(Map<String, dynamic> json) =>
    GetNotificationsDTO(
      notifications: (json['notifications'] as List<dynamic>)
          .map((e) => NotificationApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetNotificationsDTOToJson(
        GetNotificationsDTO instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
    };

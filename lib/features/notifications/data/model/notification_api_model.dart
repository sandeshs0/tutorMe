import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tutorme/features/notifications/domain/entity/notification_entity.dart';

part 'notification_api_model.g.dart';

@JsonSerializable()
class NotificationApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String userId;
  final String message;
  final String type;
  final bool isRead;
  final String createdAt;

  const NotificationApiModel({
    required this.id,
    required this.userId,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });

  /// **Convert from JSON**
  factory NotificationApiModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationApiModelFromJson(json);

  /// **Convert to JSON**
  Map<String, dynamic> toJson() => _$NotificationApiModelToJson(this);

  /// **Convert API Model to Domain Entity**
  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      userId: userId,
      message: message,
      type: type,
      isRead: isRead,
      createdAt: DateTime.parse(createdAt),
    );
  }

  /// **Create API Model from Domain Entity**
  factory NotificationApiModel.fromEntity(NotificationEntity entity) {
    return NotificationApiModel(
      id: entity.id,
      userId: entity.userId,
      message: entity.message,
      type: entity.type,
      isRead: entity.isRead,
      createdAt: entity.createdAt.toIso8601String(),
    );
  }

  @override
  List<Object?> get props => [id, userId, message, type, isRead, createdAt];
}
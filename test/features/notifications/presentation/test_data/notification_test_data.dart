import 'package:tutorme/features/notifications/domain/entity/notification_entity.dart';

final List<NotificationEntity> notifications = [
  NotificationEntity(
    id: 'n1',
    userId: 'user123',
    message:
        'Your session has ended. Rs.0.7720194444444444 has been deducted from your wallet.',
    type: 'session',
    isRead: false,
    createdAt: DateTime(2025, 3, 5, 12, 18),
  ),
  NotificationEntity(
    id: 'n2',
    userId: 'user123',
    message: 'Your session has started! Join now.',
    type: 'session',
    isRead: false,
    createdAt: DateTime(2025, 3, 5, 12, 17),
  ),
  NotificationEntity(
    id: 'n3',
    userId: 'user123',
    message:
        'Harvey Specter has accepted your session request. Check the sessions tab.',
    type: 'session_request',
    isRead: false,
    createdAt: DateTime(2025, 3, 5, 12, 16),
  ),
  NotificationEntity(
    id: 'n4',
    userId: 'user123',
    message: 'Your tutorMe Wallet has been credited by Rs.950.',
    type: 'wallet',
    isRead: false,
    createdAt: DateTime(2025, 3, 5, 12, 15),
  ),
];

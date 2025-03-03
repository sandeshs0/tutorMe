import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/core/services/notification_service.dart';
import 'package:tutorme/features/notifications/domain/entity/notification_entity.dart';
import 'package:tutorme/features/notifications/domain/usecase/get_notification_usecase.dart';
import 'package:tutorme/features/notifications/domain/usecase/mark_notification_usecase.dart';
import 'package:tutorme/features/notifications/presentation/view_model/notification_bloc.dart';

class MockGetNotificationsUsecase extends Mock
    implements GetNotificationsUsecase {}

class MockMarkNotificationsAsReadUsecase extends Mock
    implements MarkNotificationsAsReadUsecase {}

class MockNotificationService extends Mock implements NotificationService {}

void main() {
  late GetNotificationsUsecase getNotificationsUsecase;
  late MarkNotificationsAsReadUsecase markNotificationsAsReadUsecase;
  late NotificationService notificationService;
  late NotificationBloc notificationBloc;

  setUp(() {
    getNotificationsUsecase = MockGetNotificationsUsecase();
    markNotificationsAsReadUsecase = MockMarkNotificationsAsReadUsecase();
    notificationService = MockNotificationService();

    notificationBloc = NotificationBloc(
      getNotificationsUsecase: getNotificationsUsecase,
      markNotificationsAsReadUsecase: markNotificationsAsReadUsecase,
      notificationService: notificationService,
    );
    registerFallbackValue(NotificationEntity(
      id: '123',
      userId: 'Ramesh',
      message: 'test notification',
      type: 'booking',
      isRead: false,
      createdAt: DateTime.now(),
    ));
  });

  final notification = NotificationEntity(
    id: '1',
    userId: 'Ramesh',
    message: 'test notification',
    type: 'booking',
    isRead: false,
    createdAt: DateTime.now(),
  );
  final notificationList = [notification];

  group('notification bloc test', () {
    blocTest<NotificationBloc, NotificationState>(
      'emits [NotificationLoading, NotificationLoaded] when FetchNotificationsEvent is added',
      build: () {
        when(() => getNotificationsUsecase())
            .thenAnswer((_) async => Right(notificationList));
        return notificationBloc;
      },
      act: (bloc) => bloc.add(FetchNotificationsEvent()),
      expect: () => [
        NotificationLoading(),
        NotificationLoaded(notificationList),
      ],
      verify: (_) {
        verify(() => getNotificationsUsecase()).called(1);
      },
    );

    blocTest<NotificationBloc, NotificationState>(
      'emits [NotificationLoaded] when FetchNotificationsEvent is added with skip 1',
      build: () {
        when(() => getNotificationsUsecase())
            .thenAnswer((_) async => Right(notificationList));
        return notificationBloc;
      },
      act: (bloc) => bloc.add(FetchNotificationsEvent()),
      skip: 1,
      expect: () => [
        NotificationLoaded(notificationList),
      ],
      verify: (_) {
        verify(() => getNotificationsUsecase()).called(1);
      },
    );

    blocTest<NotificationBloc, NotificationState>(
      'emits [NotificationLoading, NotificationError] when FetchNotificationsEvent fails',
      build: () {
        when(() => getNotificationsUsecase()).thenAnswer(
            (_) async => const Left(ApiFailure(message: 'Failed to fetch')));
        return notificationBloc;
      },
      act: (bloc) => bloc.add(FetchNotificationsEvent()),
      expect: () => [
        NotificationLoading(),
        const NotificationError('Failed to fetch'),
      ],
      verify: (_) {
        verify(() => getNotificationsUsecase()).called(1);
      },
    );

    blocTest<NotificationBloc, NotificationState>(
      'emits [NotificationsMarkedAsRead, NotificationLoading, NotificationLoaded] when MarkNotificationsAsReadEvent succeeds',
      build: () {
        when(() => markNotificationsAsReadUsecase())
            .thenAnswer((_) async => const Right(null));
        when(() => getNotificationsUsecase())
            .thenAnswer((_) async => Right(notificationList));
        return notificationBloc;
      },
      act: (bloc) => bloc.add(MarkNotificationsAsReadEvent()),
      expect: () => [
        NotificationsMarkedAsRead(),
        NotificationLoading(),
        NotificationLoaded(notificationList),
      ],
      verify: (_) {
        verify(() => markNotificationsAsReadUsecase()).called(1);
        verify(() => getNotificationsUsecase()).called(1);
      },
    );

    blocTest<NotificationBloc, NotificationState>(
      'emits [NotificationError] when MarkNotificationsAsReadEvent fails',
      build: () {
        when(() => markNotificationsAsReadUsecase()).thenAnswer(
            (_) async => const Left(ApiFailure(message: 'Failed to mark')));
        return notificationBloc;
      },
      act: (bloc) => bloc.add(MarkNotificationsAsReadEvent()),
      expect: () => [
        const NotificationError('Failed to mark'),
      ],
      verify: (_) {
        verify(() => markNotificationsAsReadUsecase()).called(1);
        verifyNever(() => getNotificationsUsecase());
      },
    );

    blocTest<NotificationBloc, NotificationState>(
      'does not emit when AddNewNotificationEvent is added from initial state',
      build: () {
        return notificationBloc;
      },
      act: (bloc) => bloc.add(AddNewNotificationEvent(notification)),
      expect: () => [],
      verify: (_) {
        verifyNever(() => notificationService.showNotification(any()));
      },
    );
  });
}

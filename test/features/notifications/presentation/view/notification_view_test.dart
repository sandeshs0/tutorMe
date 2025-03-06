import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tutorme/features/notifications/presentation/view/notification_view.dart';
import 'package:tutorme/features/notifications/presentation/view_model/notification_bloc.dart';

import '../test_data/notification_test_data.dart'; 

class MockNotificationBloc
    extends MockBloc<NotificationEvent, NotificationState>
    implements NotificationBloc {}

void main() {
  late MockNotificationBloc notificationBloc;

  setUp(() {
    notificationBloc = MockNotificationBloc();

    when(() => notificationBloc.state).thenReturn(NotificationInitial());
  });

  Widget loadNotificationScreen() {
    return BlocProvider<NotificationBloc>(
      create: (context) => notificationBloc,
      child: const MaterialApp(home: NotificationScreen()),
    );
  }

  group('NotificationScreen Widget Tests', () {
    testWidgets('Check for UI elements in Notification screen', (tester) async {
      await tester.pumpWidget(loadNotificationScreen());
      await tester.pumpAndSettle();

      expect(find.text('Notifications'), findsOneWidget);

      expect(find.byIcon(Icons.done_all), findsOneWidget);
    });

    testWidgets('Check for notifications loaded successfully', (tester) async {
      when(() => notificationBloc.state)
          .thenReturn(NotificationLoaded(notifications));

      await tester.pumpWidget(loadNotificationScreen());
      await tester.pumpAndSettle();

      expect(
          find.text(
              'Your session has ended. Rs.0.7720194444444444 has been deducted from your wallet.'),
          findsOneWidget);
      expect(find.text('Your session has started! Join now.'), findsOneWidget);
      expect(
          find.text(
              'Harvey Specter has accepted your session request. Check the sessions tab.'),
          findsOneWidget);
      expect(find.text('Your tutorMe Wallet has been credited by Rs.950.'),
          findsOneWidget);

      expect(find.byIcon(Icons.notifications_active), findsNWidgets(4));
    });

    testWidgets('Check for error state', (tester) async {
      const errorMessage = 'Failed to load notifications';
      whenListen(
        notificationBloc,
        Stream.fromIterable([
          NotificationLoading(),
          const NotificationError(errorMessage),
        ]),
        initialState: NotificationInitial(),
      );

      await tester.pumpWidget(loadNotificationScreen());
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      expect(find.text(errorMessage), findsAtLeast(1));
    });
  });
}

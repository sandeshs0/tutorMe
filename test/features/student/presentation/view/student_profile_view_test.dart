import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tutorme/features/student/presentation/view/student_profile_view.dart';
import 'package:tutorme/features/student/presentation/view_model/bloc/student_profile_bloc.dart';

import '../test_data/student_test_data.dart'; // Import the updated test data

class MockStudentProfileBloc
    extends MockBloc<StudentProfileEvent, StudentProfileState>
    implements StudentProfileBloc {}

void main() {
  late MockStudentProfileBloc studentProfileBloc;

  setUp(() {
    studentProfileBloc = MockStudentProfileBloc();

    // Set up the initial state to simulate loading, then loaded after fetch
    when(() => studentProfileBloc.state).thenReturn(StudentProfileLoading());
    when(() => studentProfileBloc.state).thenAnswer((_) {
      return const StudentProfileLoaded(student: student);
    });
  });

  Widget loadStudentProfileView() {
    return MaterialApp(
      home: BlocProvider<StudentProfileBloc>(
        create: (context) => studentProfileBloc,
        child: const StudentProfileView(),
      ),
    );
  }

  group('StudentProfileView Widget Tests', () {
    testWidgets('Check for profile UI elements', (tester) async {
      await tester.pumpWidget(loadStudentProfileView());
      await tester.pumpAndSettle();

      studentProfileBloc.add(const FetchStudentProfile());
      await tester.pumpAndSettle();

      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Sandesh Sapkota'), findsOneWidget);
      expect(find.text('sandeshsapkota@example.com'), findsOneWidget);
      expect(find.text('Wallet Balance'), findsOneWidget);
      expect(find.text('Rs. 950.00'), findsOneWidget);
      expect(
          find.descendant(
              of: find.byType(ListTile),
              matching: find.byIcon(Icons.notifications)),
          findsOneWidget);
      expect(
          find.descendant(
              of: find.byType(ListTile),
              matching: find.byIcon(Icons.dark_mode)),
          findsOneWidget);
      expect(
          find.descendant(
              of: find.byType(ListTile), matching: find.byIcon(Icons.security)),
          findsOneWidget);
    });

    testWidgets('Check for profile image display', (tester) async {
      await tester.pumpWidget(loadStudentProfileView());
      await tester.pumpAndSettle();

      studentProfileBloc.add(const FetchStudentProfile());
      await tester.pumpAndSettle();

      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('Check for error handling', (tester) async {
      const errorMessage = 'Failed to load profile';
      when(() => studentProfileBloc.state)
          .thenReturn(const StudentProfileError(message: errorMessage));
      await tester.pumpWidget(loadStudentProfileView());
      await tester.pumpAndSettle();
      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('Check for loading state', (tester) async {
      when(() => studentProfileBloc.state).thenReturn(StudentProfileLoading());
      await tester.pumpWidget(loadStudentProfileView());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}

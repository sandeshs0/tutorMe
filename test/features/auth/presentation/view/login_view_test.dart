import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tutorme/features/auth/presentation/view/login_view.dart';
import 'package:tutorme/features/auth/presentation/view_model/login/login_bloc.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  late MockLoginBloc loginBloc;

  setUp(() {
    loginBloc = MockLoginBloc();

    when(() => loginBloc.state)
        .thenReturn(const LoginState(isLoading: false, isSuccess: false));
  });

  Widget loadLoginView() {
    return BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
      child: MaterialApp(home: LoginScreen()),
    );
  }

  testWidgets('Checking for Ui to render', (tester) async {
    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();
    
    final result = find.widgetWithText(ElevatedButton, 'Login');
    expect(result, findsOneWidget);
  });

  testWidgets('Check for Text Fields', (tester) async {
    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'sandesh@gmail.com');
    await tester.enterText(find.byType(TextField).at(1), 'password');

    await tester.tap(find.byType(ElevatedButton).first);

    await tester.pumpAndSettle();

    expect(find.text('sandesh@gmail.com'), findsOneWidget);
    expect(find.text('password'), findsOneWidget);
  });

  testWidgets('Check for validation Errors', (tester) async {
    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ElevatedButton).first);

    await tester.pumpAndSettle();

    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('Check for Login Successful', (tester) async {
    when(() => loginBloc.state)
        .thenReturn(const LoginState(isLoading: true, isSuccess: true));

    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'sandesh@gmail.com');
    await tester.enterText(find.byType(TextField).at(1), 'password');

    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();

    expect(loginBloc.state.isSuccess, true);
  });
}

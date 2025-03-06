import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/auth/domain/use_case/login_usecase.dart';

import 'repository.mock.dart';
import 'token.mock.dart';

void main() {
  late MockAuthRepository repository;
  late LoginUsecase usecase;
  late MockTokenSharedPrefs tokenSharedPrefs;

  setUp(() {
    repository = MockAuthRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    usecase = LoginUsecase(repository, tokenSharedPrefs);
  });

  const userLoginParams =
      LoginParams(email: "hellosandesh0@gmail.com", password: "password");

  const generatedToken = "fake_jwt_token";

  group('Login Usecase Tests', () {
    test('login fails when incorrect credentials', () async {
      
      when(() => repository.loginUser(any(), any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: "Invalid Credentials")));

      
      final result = await usecase(userLoginParams);
      expect(result, const Left(ApiFailure(message: "Invalid Credentials")));
      verify(() => repository.loginUser(any(), any())).called(1);
      verifyNever(() => tokenSharedPrefs.saveToken(any()));
    });

    test('returns token when login is successful', () async {
      // Arrange
      when(() => repository.loginUser(any(), any()))
          .thenAnswer((_) async => const Right(generatedToken));
      when(() => tokenSharedPrefs.saveToken(any()))
          .thenAnswer((_) async => const Right(null));
      when(() => tokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(generatedToken));

      // Act
      final result = await usecase(userLoginParams);

      // Assert
      expect(result, const Right(generatedToken));
      verify(() => repository.loginUser(
          userLoginParams.email, userLoginParams.password)).called(1);
      verify(() => tokenSharedPrefs.saveToken(generatedToken)).called(1);
      verify(() => tokenSharedPrefs.getToken()).called(1);
    });

    test('should fail when email is empty', () async {
      // Arrange
      const userLoginParams = LoginParams(email: '', password: 'password');
      when(() => repository.loginUser(any(), any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Email cannot be empty")));

      // Act
      final result = await usecase(userLoginParams);

      // Assert
      expect(result, const Left(ApiFailure(message: 'Email cannot be empty')));
      verify(() => repository.loginUser(any(), any())).called(1);
      verifyNever(() => tokenSharedPrefs.saveToken(any()));
    });

    test('should fail when password is empty', () async {
      // Arrange
      const userLoginParams =
          LoginParams(email: 'hellosandesh0@gmail.com', password: '');
      when(() => repository.loginUser(any(), any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: 'Password cannot be empty')));

      // Act
      final result = await usecase(userLoginParams);

      // Assert
      expect(
          result, const Left(ApiFailure(message: 'Password cannot be empty')));
      verify(() => repository.loginUser(any(), any())).called(1);
      verifyNever(() => tokenSharedPrefs.saveToken(any()));
    });

    test("should fail when there is server error", () async {
      // Arrange
      when(() => repository.loginUser(any(), any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Internal Server Error")));

      // Act
      final result = await usecase(userLoginParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Internal Server Error")));
      verify(() => repository.loginUser(any(), any())).called(1);
      verifyNever(() => tokenSharedPrefs.saveToken(any()));
    });
  });
}

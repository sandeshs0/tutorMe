import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/auth/domain/entity/auth_entity.dart';
import 'package:tutorme/features/auth/domain/use_case/register_usecase.dart';

import 'repository.mock.dart';

void main() {
  late MockAuthRepository repository;
  late RegisterUsecase usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = RegisterUsecase(repository);
    registerFallbackValue(const AuthEntity.empty());
  });

  const userParams = RegisterUserParams(
      fullName: "Sandesh Sapkota",
      email: "hellosandes0@gmail.com",
      username: "sandesh123",
      phone: "9869118472",
      password: "password",
      profileImage: "imageurl.png",
      role: "student");

  group('Register Usecase test', () {
    test('should fail when email already exists', () async {
      // Arrange
      when(() => repository.registerUser(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: "Email already exists")));

      // Act
      final result = await usecase(userParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Email already exists")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('should fail if all fields are not filled', () async {
      // Arrange
      when(() => repository.registerUser(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "All fields are not filled")));
      const userParams = RegisterUserParams(
          fullName: "Sandesh Sapkota",
          email: "",
          username: "",
          phone: "",
          password: "password",
          profileImage: "imageurl.png",
          role: "student");
      // Act
      final result = await usecase(userParams);

      // Assert
      expect(
          result, const Left(ApiFailure(message: "All fields are not filled")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('should fail when there is a server error', () async {
      // Arrange
      when(() => repository.registerUser(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Internal Server Error")));

      // Act
      final result = await usecase(userParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Internal Server Error")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('successful registration and return Right(null)', () async {
      // Arrange
      when(() => repository.registerUser(any()))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(userParams);

      // Assert
      expect(result, const Right(null));
      verify(() => repository.registerUser(any())).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}

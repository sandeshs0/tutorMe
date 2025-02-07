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
      email: "hellosandesh0@gmail.com",
      phone: "9869118472",
      password: "password",
      profileImage: "imageurl.png",
      role: "student");

  group('Register Usecase test', () {
    test('should fail when email already exists', () async {
      // Arrange
      when(() => repository.registerUser(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: "Email already taken")));

      // Act
      final result = await usecase(userParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Email already exists")));
      verify(() => repository.registerUser(any())).called(1);
    });

     test('should fail if all fields are not filled',
        () async {
      // Arrange
      when(() => repository.registerUser(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "One or more credentials is empty")));

      // Act
      final result = await usecase(userParams.copyWith(userName: ""));

      // Assert
      expect(result,
          const Left(ApiFailure(message: "One or more credentials is empty")));
      verify(() => repository.registerUser(any())).called(1);
    });
  });
}

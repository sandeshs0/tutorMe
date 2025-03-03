import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/auth/domain/use_case/verify_usecase.dart';

import 'repository.mock.dart';

// flutter test --coverage
//  flutter pub run test_cov_console
void main() {
  late MockAuthRepository repository;
  late VerifyEmailUsecase usecase;
  setUp(() {
    repository = MockAuthRepository();
    usecase = VerifyEmailUsecase(repository);
  });

  const params = VerifyEmailParams.empty();
  
  group('Verify Email Tests', () {
    test('should return true for successful verification', () async {
      when(() => repository.verifyEmail(any(), any())).thenAnswer(
        (_) async => const Right(true),
      );
      final result = await usecase(params);

      expect(result, const Right(true));

      verify(() => repository.verifyEmail(params.email, params.otp)).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('should fail for incorrect otp', () async {
      when(() => repository.verifyEmail(any(), any())).thenAnswer(
        (_) async => const Left(ApiFailure(message: "Incorrect OTP")),
      );
      final result = await usecase(params);

      expect(result, const Left(ApiFailure(message: 'Incorrect OTP')));
      verify(() => repository.verifyEmail(params.email, params.otp)).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}

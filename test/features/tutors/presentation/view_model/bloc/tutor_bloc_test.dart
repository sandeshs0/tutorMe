import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';
import 'package:tutorme/features/tutors/domain/usecase/get_all_tutors_usecase.dart';
import 'package:tutorme/features/tutors/domain/usecase/get_tutor_by_username_usecase.dart';
import 'package:tutorme/features/tutors/presentation/view_model/bloc/tutor_bloc.dart';

class MockGetAllTutorsUsecase extends Mock implements GetAllTutorsUsecase {}
class MockGetTutorByUsernameUsecase extends Mock implements GetTutorByUsernameUsecase {}

void main() {
  late GetAllTutorsUsecase getAllTutorsUsecase;
  late GetTutorByUsernameUsecase getTutorByUsernameUsecase;
  late TutorBloc tutorBloc;

  setUp(() {
    getAllTutorsUsecase = MockGetAllTutorsUsecase();
    getTutorByUsernameUsecase = MockGetTutorByUsernameUsecase();

    tutorBloc = TutorBloc(
      getAllTutorsUsecase: getAllTutorsUsecase,
      getTutorByUsernameUsecase: getTutorByUsernameUsecase,
    );
      registerFallbackValue(const GetTutorsParams(page: 1, limit: 10));
    registerFallbackValue(const GetTutorByUsernameParams(username: 'ramesh'));
  });

  const tutorEntity = TutorEntity(
    tutorId: '1',
    name: 'Ramesh',
    username: 'ramesh',
    subjects: ['Math', 'Java'],
    email: 'ramesh@gmail.com',
    profileImage: '',
    bio: 'bio',
    description: 'this is description',
    rating: 4,
    hourlyRate: 200,
  );
  final tutorList = [tutorEntity];
  const failure = ApiFailure(message: 'Test failure', statusCode: 500);

  group('tutor bloc test', () {
    blocTest<TutorBloc, TutorState>(
      'emits [TutorLoading, TutorLoaded] when GetAllTutorsEvent succeeds',
      setUp: () {
        when(() => getAllTutorsUsecase(const GetTutorsParams(page: 1, limit: 10)))
            .thenAnswer((_) async => Right(tutorList));
      },
      build: () => tutorBloc,
      act: (bloc) => bloc.add(const GetAllTutorsEvent(page: 1, limit: 10)),
      expect: () => [
        TutorLoading(),
        TutorLoaded(tutors: tutorList),
      ],
      verify: (_) {
        verify(() => getAllTutorsUsecase(
              const GetTutorsParams(page: 1, limit: 10),
            )).called(1);
      },
    );

    blocTest<TutorBloc, TutorState>(
      'emits [TutorLoaded] when GetAllTutorsEvent succeeds with skip 1',
      setUp: () {
        when(() => getAllTutorsUsecase(const GetTutorsParams(page: 1, limit: 10)))
            .thenAnswer((_) async => Right(tutorList));
      },
      build: () => tutorBloc,
      act: (bloc) => bloc.add(const GetAllTutorsEvent(page: 1, limit: 10)),
      skip: 1,
      expect: () => [
        TutorLoaded(tutors: tutorList),
      ],
      verify: (_) {
        verify(() => getAllTutorsUsecase(
              const GetTutorsParams(page: 1, limit: 10),
            )).called(1);
      },
    );

    blocTest<TutorBloc, TutorState>(
      'emits [TutorLoading, TutorError] when GetAllTutorsEvent fails',
      setUp: () {
        when(() => getAllTutorsUsecase(const GetTutorsParams(page: 1, limit: 10)))
            .thenAnswer((_) async => const Left(failure));
      },
      build: () => tutorBloc,
      act: (bloc) => bloc.add(const GetAllTutorsEvent(page: 1, limit: 10)),
      expect: () => [
        TutorLoading(),
        TutorError(message: failure.toString()),
      ],
      verify: (_) {
        verify(() => getAllTutorsUsecase(
              const GetTutorsParams(page: 1, limit: 10),
            )).called(1);
      },
    );

    blocTest<TutorBloc, TutorState>(
      'emits [TutorLoading, TutorProfileLoaded] when GetTutorByUsernameEvent succeeds',
      setUp: () {
        when(() => getTutorByUsernameUsecase(const GetTutorByUsernameParams(username: 'ramesh')))
            .thenAnswer((_) async => const Right(tutorEntity));
      },
      build: () => tutorBloc,
      act: (bloc) => bloc.add(const GetTutorByUsernameEvent(username: 'ramesh')),
      expect: () => [
        TutorLoading(),
        const TutorProfileLoaded(tutor: tutorEntity),
      ],
      verify: (_) {
        verify(() => getTutorByUsernameUsecase(
              const GetTutorByUsernameParams(username: 'ramesh'),
            )).called(1);
      },
    );

    blocTest<TutorBloc, TutorState>(
      'emits [TutorLoading, TutorError] when GetTutorByUsernameEvent fails',
      setUp: () {
        when(() => getTutorByUsernameUsecase(const GetTutorByUsernameParams(username: 'ramesh')))
            .thenAnswer((_) async => const Left(failure));
      },
      build: () => tutorBloc,
      act: (bloc) => bloc.add(const GetTutorByUsernameEvent(username: 'ramesh')),
      expect: () => [
        TutorLoading(),
        TutorError(message: failure.toString()),
      ],
      verify: (_) {
        verify(() => getTutorByUsernameUsecase(
              const GetTutorByUsernameParams(username: 'ramesh'),
            )).called(1);
      },
    );
  });
}
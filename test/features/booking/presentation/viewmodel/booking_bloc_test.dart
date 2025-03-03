import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/booking/domain/entity/booking_entity.dart';
import 'package:tutorme/features/booking/domain/usecase/create_booking_usecase.dart';
import 'package:tutorme/features/booking/domain/usecase/get_student_bookings.dart';
import 'package:tutorme/features/booking/presentation/viewmodel/booking_bloc.dart';

class MockCreateBookingUseCase extends Mock implements CreateBookingUseCase {}

class MockGetStudentBookingsUseCase extends Mock
    implements GetStudentBookingsUseCase {}

void main() {
  late CreateBookingUseCase createBookingUseCase;
  late GetStudentBookingsUseCase getStudentBookingsUseCase;
  late BookingBloc bookingBloc;

  // setUpAll(() {
  //   registerFallbackValue(const CreateBookingParams(
  //     tutorId: '1',
  //     date: '2025-03-03',
  //     time: '10:00',
  //     note: 'Test booking',
  //   ));
  // });

  setUp(() {
    createBookingUseCase = MockCreateBookingUseCase();
    getStudentBookingsUseCase = MockGetStudentBookingsUseCase();

    bookingBloc = BookingBloc(
      createBookingUseCase: createBookingUseCase,
      getStudentBookingsUseCase: getStudentBookingsUseCase,
    );
    registerFallbackValue(const CreateBookingParams(
      tutorId: '1',
      date: '2025-03-03',
      time: '10:00',
      note: 'Test booking',
    ));
  });

  const booking = BookingEntity(
    id: '1',
    tutorId: 'tutor1',
    studentId: 'student1',
    date: '2025-03-03',
    startTime: '10:00',
    note: 'Test booking',
    status: 'pending',
    bookingFee: 50,
    tutorName: 'Ramesh',
    profileImage: '',
    hourlyRate: 200,
  );
  final bookingList = [booking];
  const failure = ApiFailure(message: 'Test failure', statusCode: 500);

  group('Booking bloc test', () {
    blocTest<BookingBloc, BookingState>(
      'emits [BookingLoading, BookingCreated] when CreateBookingEvent succeeds',
      build: () {
        when(() => createBookingUseCase.call(const CreateBookingParams(
              tutorId: 'tutor123',
              date: '2025-03-03',
              time: '10:00',
              note: 'Test booking',
            ))).thenAnswer((_) async => const Right(booking));
        return bookingBloc;
      },
      act: (bloc) => bloc.add(const CreateBookingEvent(
        tutorId: 'tutor1',
        date: '2025-03-03',
        time: '10:00',
        note: 'Test booking',
      )),
      expect: () => [
        BookingLoading(),
        const BookingCreated(booking: booking),
      ],
      verify: (_) {
        verify(() => createBookingUseCase.call(const CreateBookingParams(
              tutorId: 'tutor1',
              date: '2025-03-03',
              time: '10:00',
              note: 'Test booking',
            ))).called(1);
      },
    );

    blocTest<BookingBloc, BookingState>(
      'emits [BookingCreated] when CreateBookingEvent succeeds with skip 1',
      build: () {
        when(() => createBookingUseCase.call(const CreateBookingParams(
              tutorId: 'tutor1',
              date: '2025-03-03',
              time: '10:00',
              note: 'Test booking',
            ))).thenAnswer((_) async => const Right(booking));
        return bookingBloc;
      },
      act: (bloc) => bloc.add(const CreateBookingEvent(
        tutorId: 'tutor1',
        date: '2025-03-03',
        time: '10:00',
        note: 'Test booking',
      )),
      skip: 1,
      expect: () => [
        const BookingCreated(booking: booking),
      ],
      verify: (_) {
        verify(() => createBookingUseCase.call(const CreateBookingParams(
              tutorId: 'tutor1',
              date: '2025-03-03',
              time: '10:00',
              note: 'Test booking',
            ))).called(1);
      },
    );

    blocTest<BookingBloc, BookingState>(
      'emits [BookingLoading, BookingError] when CreateBookingEvent fails',
      build: () {
        when(() => createBookingUseCase.call(const CreateBookingParams(
              tutorId: 'tutor1',
              date: '2025-03-03',
              time: '10:00',
              note: 'Test booking',
            ))).thenAnswer((_) async => const Left(failure));
        return bookingBloc;
      },
      act: (bloc) => bloc.add(const CreateBookingEvent(
        tutorId: 'tutor1',
        date: '2025-03-03',
        time: '10:00',
        note: 'Test booking',
      )),
      expect: () => [
        BookingLoading(),
        const BookingError(message: 'Test failure'),
      ],
      verify: (_) {
        verify(() => createBookingUseCase.call(const CreateBookingParams(
              tutorId: 'tutor1',
              date: '2025-03-03',
              time: '10:00',
              note: 'Test booking',
            ))).called(1);
      },
    );

    blocTest<BookingBloc, BookingState>(
      'emits [BookingLoading, StudentBookingsLoaded] when FetchStudentBookingsEvent succeeds',
      build: () {
        when(() => getStudentBookingsUseCase.call())
            .thenAnswer((_) async => Right(bookingList));
        return bookingBloc;
      },
      act: (bloc) => bloc.add(FetchStudentBookingsEvent()),
      expect: () => [
        BookingLoading(),
        StudentBookingsLoaded(bookings: bookingList),
      ],
      verify: (_) {
        verify(() => getStudentBookingsUseCase.call()).called(1);
      },
    );

    blocTest<BookingBloc, BookingState>(
      'emits [StudentBookingsLoaded] when FetchStudentBookingsEvent succeeds with skip 1',
      build: () {
        when(() => getStudentBookingsUseCase.call())
            .thenAnswer((_) async => Right(bookingList));
        return bookingBloc;
      },
      act: (bloc) => bloc.add(FetchStudentBookingsEvent()),
      skip: 1,
      expect: () => [
        StudentBookingsLoaded(bookings: bookingList),
      ],
      verify: (_) {
        verify(() => getStudentBookingsUseCase.call()).called(1);
      },
    );

    blocTest<BookingBloc, BookingState>(
      'emits [BookingLoading, BookingError] when FetchStudentBookingsEvent fails',
      build: () {
        when(() => getStudentBookingsUseCase.call())
            .thenAnswer((_) async => const Left(failure));
        return bookingBloc;
      },
      act: (bloc) => bloc.add(FetchStudentBookingsEvent()),
      expect: () => [
        BookingLoading(),
        const BookingError(message: 'Test failure'),
      ],
      verify: (_) {
        verify(() => getStudentBookingsUseCase.call()).called(1);
      },
    );
  });
}

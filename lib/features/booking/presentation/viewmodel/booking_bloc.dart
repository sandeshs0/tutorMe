import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/booking/domain/entity/booking_entity.dart';
import 'package:tutorme/features/booking/domain/usecase/create_booking_usecase.dart';
import 'package:tutorme/features/booking/domain/usecase/get_student_bookings.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final CreateBookingUseCase _createBookingUseCase;
  final GetStudentBookingsUseCase _getStudentBookingsUseCase;

  BookingBloc({
    required CreateBookingUseCase createBookingUseCase,
    required GetStudentBookingsUseCase getStudentBookingsUseCase,
  })  : _createBookingUseCase = createBookingUseCase,
        _getStudentBookingsUseCase = getStudentBookingsUseCase,
        super(BookingInitial()) {
    on<CreateBookingEvent>(_onCreateBooking);
    on<FetchStudentBookingsEvent>(_onFetchStudentBookings);
  }

  /// 🔹 Handle Creating a Booking
  Future<void> _onCreateBooking(
      CreateBookingEvent event, Emitter<BookingState> emit) async {
    emit(BookingLoading());

    final result = await _createBookingUseCase(
      CreateBookingParams(
        tutorId: event.tutorId,
        date: event.date,
        time: event.time,
        note: event.note,
      ),
    );

    result.fold(
      (failure) => emit(BookingError(message: _mapFailureToMessage(failure))),
      (booking) => emit(BookingCreated(booking: booking)),
    );
  }

  /// 🔹 Handle Fetching Student's Bookings
  Future<void> _onFetchStudentBookings(
      FetchStudentBookingsEvent event, Emitter<BookingState> emit) async {
    emit(BookingLoading());

    final result = await _getStudentBookingsUseCase();

    result.fold(
      (failure) => emit(BookingError(message: _mapFailureToMessage(failure))),
      (bookings) => emit(StudentBookingsLoaded(bookings: bookings)),
    );
  }

  /// 🔹 Maps API failures to readable messages
  String _mapFailureToMessage(Failure failure) {
    if (failure is ApiFailure) {
      return failure.message;
    } else {
      return "An unexpected error occurred.";
    }
  }
}

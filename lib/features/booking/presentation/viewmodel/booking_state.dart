part of 'booking_bloc.dart';

sealed class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

final class BookingInitial extends BookingState {}

final class BookingLoading extends BookingState {}

final class BookingCreated extends BookingState {
  final BookingEntity booking;

  const BookingCreated({required this.booking});

  @override
  List<Object> get props => [booking];
}

final class StudentBookingsLoaded extends BookingState {
  final List<BookingEntity> bookings;

  const StudentBookingsLoaded({required this.bookings});

  @override
  List<Object> get props => [bookings];
}

final class BookingError extends BookingState {
  final String message;

  const BookingError({required this.message});

  @override
  List<Object> get props => [message];
}

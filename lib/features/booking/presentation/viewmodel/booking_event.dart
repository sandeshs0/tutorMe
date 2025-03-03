part of 'booking_bloc.dart';

sealed class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class CreateBookingEvent extends BookingEvent {
  final String tutorId;
  final String date;
  final String time;
  final String note;

  const CreateBookingEvent({
    required this.tutorId,
    required this.date,
    required this.time,
    required this.note,
  });

  @override
  List<Object> get props => [tutorId, date, time, note];
}

class FetchStudentBookingsEvent extends BookingEvent {}

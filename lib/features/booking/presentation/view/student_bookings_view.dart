import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorme/features/booking/domain/entity/booking_entity.dart';
import 'package:tutorme/features/booking/presentation/viewmodel/booking_bloc.dart';

class StudentBookingsView extends StatefulWidget {
  const StudentBookingsView({super.key});

  @override
  _StudentBookingsViewState createState() => _StudentBookingsViewState();
}

class _StudentBookingsViewState extends State<StudentBookingsView> {
  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(FetchStudentBookingsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // ✅ No back button
        title: const Text("My Bookings"),
      ),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookingError) {
            return Center(
              child: Text(state.message,
                  style: const TextStyle(color: Colors.red)),
            );
          } else if (state is StudentBookingsLoaded) {
            final upcomingBookings = state.bookings
                .where((booking) =>
                    booking.status == "pending" || booking.status == "accepted")
                .toList();
            final pastBookings = state.bookings
                .where((booking) =>
                    booking.status == "completed" ||
                    booking.status == "declined")
                .toList();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (upcomingBookings.isNotEmpty) ...[
                    const Text("Upcoming Bookings",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildBookingList(upcomingBookings),
                  ],
                  if (pastBookings.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text("Past Bookings",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildBookingList(pastBookings),
                  ],
                  if (upcomingBookings.isEmpty && pastBookings.isEmpty)
                    const Center(child: Text("No bookings found.")),
                ],
              ),
            );
          }
          return const Center(child: Text("No bookings available."));
        },
      ),
    );
  }

  /// Builds a list of booking cards
  Widget _buildBookingList(List<BookingEntity> bookings) {
    return Expanded(
      child: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(booking.profileImage ?? ""),
              ),
              // title: Text(booking.tutorO.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date: ${booking.date}"),
                  Text("Time: ${booking.startTime}"),
                  Text("Status: ${booking.status}",
                      style: TextStyle(
                        color: _getStatusColor(booking.status),
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                // TODO: Navigate to booking details if needed
              },
            ),
          );
        },
      ),
    );
  }

  /// Get color for booking status
  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return Colors.orange;
      case "accepted":
        return Colors.green;
      case "completed":
        return Colors.blue;
      case "declined":
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}

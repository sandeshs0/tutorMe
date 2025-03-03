import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
        automaticallyImplyLeading: false,
        title: const Text("Activity",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookingError) {
            return Center(
              child: Text(state.message,
                  style: const TextStyle(color: Colors.red, fontSize: 16)),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (upcomingBookings.isNotEmpty) ...[
                    const Text("Upcoming Bookings",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Expanded(child: _buildBookingList(upcomingBookings)),
                  ],
                  if (pastBookings.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text("Past Bookings",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Expanded(child: _buildBookingList(pastBookings)),
                  ],
                  if (upcomingBookings.isEmpty && pastBookings.isEmpty)
                    const Expanded(
                      child: Center(
                        child: Text(
                          "No bookings found.",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
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
    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: booking.profileImage != null &&
                      booking.profileImage!.isNotEmpty
                  ? NetworkImage(booking.profileImage!)
                  : null,
              child:
                  booking.profileImage == null || booking.profileImage!.isEmpty
                      ? const Icon(Icons.person, color: Colors.white, size: 30)
                      : null,
            ),
            title: Text(
              booking.tutorName ?? "Unknown Tutor",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 16, color: Colors.blue),
                    const SizedBox(width: 6),
                    Text(
                      "Date: ${_formatDate(booking.date)}", // ✅ Format date
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded,
                        size: 16, color: Colors.red),
                    const SizedBox(width: 6),
                    Text("Time: ${booking.startTime}",
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 6),
                _buildStatusBadge(booking.status),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.note, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        booking.note.isNotEmpty ? booking.note : "No notes",
                        style: const TextStyle(
                            fontSize: 14, fontStyle: FontStyle.italic),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              // TODO: Navigate to booking details if needed
            },
          ),
        );
      },
    );
  }

  /// Convert the date format to `February 26, 2025`
  String _formatDate(String rawDate) {
    try {
      DateTime date = DateTime.parse(rawDate);
      return DateFormat('MMMM d, y')
          .format(date); // ✅ Converts to February 26, 2025
    } catch (e) {
      return "Invalid date";
    }
  }

  /// Builds a status badge with color
  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case "pending":
        bgColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        break;
      case "accepted":
        bgColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;
      case "completed":
        bgColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        break;
      case "declined":
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;
      default:
        bgColor = Colors.grey.shade300;
        textColor = Colors.black;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}

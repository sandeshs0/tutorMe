// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:tutorme/features/booking/domain/entity/booking_entity.dart';
// import 'package:tutorme/features/booking/presentation/viewmodel/booking_bloc.dart';

// class StudentBookingsView extends StatefulWidget {
//   const StudentBookingsView({super.key});

//   @override
//   _StudentBookingsViewState createState() => _StudentBookingsViewState();
// }

// class _StudentBookingsViewState extends State<StudentBookingsView> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<BookingBloc>().add(FetchStudentBookingsEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("Activity",
//             style: TextStyle(fontWeight: FontWeight.bold)),
//       ),
//       body: BlocBuilder<BookingBloc, BookingState>(
//         builder: (context, state) {
//           if (state is BookingLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is BookingError) {
//             return Center(
//               child: Text(state.message,
//                   style: const TextStyle(color: Colors.red, fontSize: 16)),
//             );
//           } else if (state is StudentBookingsLoaded) {
//             final upcomingBookings = state.bookings
//                 .where((booking) =>
//                     booking.status == "pending" || booking.status == "accepted")
//                 .toList();
//             final pastBookings = state.bookings
//                 .where((booking) =>
//                     booking.status == "completed" ||
//                     booking.status == "declined")
//                 .toList();

//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if (upcomingBookings.isNotEmpty) ...[
//                     const Text("My Bookings",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 8),
//                     Expanded(child: _buildBookingList(upcomingBookings)),
//                   ],
//                   if (pastBookings.isNotEmpty) ...[
//                     const SizedBox(height: 16),
//                     const Text("Past Bookings",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 8),
//                     Expanded(child: _buildBookingList(pastBookings)),
//                   ],
//                   if (upcomingBookings.isEmpty && pastBookings.isEmpty)
//                     const Expanded(
//                       child: Center(
//                         child: Text(
//                           "No bookings found.",
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             );
//           }
//           return const Center(child: Text("No bookings available."));
//         },
//       ),
//     );
//   }

//   /// Builds a list of booking cards
//   Widget _buildBookingList(List<BookingEntity> bookings) {
//     return ListView.builder(
//       itemCount: bookings.length,
//       itemBuilder: (context, index) {
//         final booking = bookings[index];
//         return Card(
//           elevation: 4,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           margin: const EdgeInsets.symmetric(vertical: 8),
//           child: ListTile(
//             contentPadding: const EdgeInsets.all(12),
//             leading: CircleAvatar(
//               radius: 30,
//               backgroundColor: Colors.grey.shade300,
//               backgroundImage: booking.profileImage != null &&
//                       booking.profileImage!.isNotEmpty
//                   ? NetworkImage(booking.profileImage!)
//                   : null,
//               child:
//                   booking.profileImage == null || booking.profileImage!.isEmpty
//                       ? const Icon(Icons.person, color: Colors.white, size: 30)
//                       : null,
//             ),
//             title: Text(
//               booking.tutorName ?? "Unknown Tutor",
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     const Icon(Icons.calendar_today,
//                         size: 16, color: Colors.blue),
//                     const SizedBox(width: 6),
//                     Text(
//                       "Date: ${_formatDate(booking.date)}", // ✅ Format date
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     const Icon(Icons.access_time_rounded,
//                         size: 16, color: Colors.red),
//                     const SizedBox(width: 6),
//                     Text("Time: ${booking.startTime}",
//                         style: const TextStyle(fontSize: 14)),
//                   ],
//                 ),
//                 const SizedBox(height: 6),
//                 _buildStatusBadge(booking.status),
//                 const SizedBox(height: 6),
//                 Row(
//                   children: [
//                     const Icon(Icons.note, size: 16, color: Colors.grey),
//                     const SizedBox(width: 6),
//                     Expanded(
//                       child: Text(
//                         booking.note.isNotEmpty ? booking.note : "No notes",
//                         style: const TextStyle(
//                             fontSize: 14, fontStyle: FontStyle.italic),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             trailing: const Icon(Icons.arrow_forward_ios, size: 18),
//             onTap: () {
//               // TODO: Navigate to booking details if needed
//             },
//           ),
//         );
//       },
//     );
//   }

//   /// Convert the date format to `February 26, 2025`
//   String _formatDate(String rawDate) {
//     try {
//       DateTime date = DateTime.parse(rawDate);
//       return DateFormat('MMMM d, y')
//           .format(date); // ✅ Converts to February 26, 2025
//     } catch (e) {
//       return "Invalid date";
//     }
//   }

//   /// Builds a status badge with color
//   Widget _buildStatusBadge(String status) {
//     Color bgColor;
//     Color textColor;

//     switch (status.toLowerCase()) {
//       case "pending":
//         bgColor = Colors.orange.shade100;
//         textColor = Colors.orange.shade800;
//         break;
//       case "accepted":
//         bgColor = Colors.green.shade100;
//         textColor = Colors.green.shade800;
//         break;
//       case "completed":
//         bgColor = Colors.blue.shade100;
//         textColor = Colors.blue.shade800;
//         break;
//       case "declined":
//         bgColor = Colors.red.shade100;
//         textColor = Colors.red.shade800;
//         break;
//       default:
//         bgColor = Colors.grey.shade300;
//         textColor = Colors.black;
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: bgColor,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(
//         status.toUpperCase(),
//         style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
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
    // Get the current theme
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("My Bookings",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          if (state is BookingLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.primaryColor,
              ),
            );
          } else if (state is BookingError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline,
                      size: 60, color: theme.colorScheme.error),
                  const SizedBox(height: 16),
                  Text(state.message,
                      style: TextStyle(
                          color: theme.colorScheme.error, fontSize: 16)),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<BookingBloc>()
                          .add(FetchStudentBookingsEvent());
                    },
                    child: const Text('Try Again'),
                  )
                ],
              ),
            );
          } else if (state is StudentBookingsLoaded) {
            // Combine all bookings into a single list
            final allBookings = state.bookings;

            // Sort bookings - active/pending first, then completed/declined
            allBookings.sort((a, b) {
              // First prioritize active statuses
              final aIsActive = a.status == "pending" || a.status == "accepted";
              final bIsActive = b.status == "pending" || b.status == "accepted";

              if (aIsActive && !bIsActive) return -1;
              if (!aIsActive && bIsActive) return 1;

              // Then sort by date (most recent first)
              try {
                final aDate = DateTime.parse(a.date);
                final bDate = DateTime.parse(b.date);
                return bDate.compareTo(aDate);
              } catch (_) {
                return 0;
              }
            });

            return allBookings.isEmpty
                ? _buildEmptyState(theme)
                : _buildBookingsList(allBookings, theme, isDarkMode);
          }
          return Center(
            child: Text(
              "No bookings available.",
              style: theme.textTheme.bodyMedium,
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            size: 80,
            color: theme.brightness == Brightness.dark
                ? Colors.grey.shade700
                : Colors.grey.shade300,
          ),
          const SizedBox(height: 24),
          Text(
            "No bookings yet",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Your booking history will appear here",
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsList(
      List<BookingEntity> bookings, ThemeData theme, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: bookings.length,
        padding: const EdgeInsets.only(top: 16, bottom: 24),
        itemBuilder: (context, index) {
          final booking = bookings[index];

          // Get base color for status
          final statusColor = _getStatusColor(booking.status, theme);

          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: statusColor.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                // TODO: Navigate to booking details
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: isDarkMode
                              ? Colors.grey.shade800
                              : Colors.grey.shade200,
                          backgroundImage: booking.profileImage != null &&
                                  booking.profileImage!.isNotEmpty
                              ? NetworkImage(booking.profileImage!)
                              : null,
                          child: booking.profileImage == null ||
                                  booking.profileImage!.isEmpty
                              ? Icon(
                                  Icons.person,
                                  color: isDarkMode
                                      ? Colors.grey.shade500
                                      : Colors.grey,
                                  size: 26,
                                )
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                booking.tutorName ?? "Unknown Tutor",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              _buildStatusBadge(booking.status, theme),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? theme.cardColor.withOpacity(0.5)
                            : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDarkMode
                              ? theme.dividerColor
                              : Colors.grey.shade200,
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildInfoRow(
                            Icons.calendar_today,
                            theme.primaryColor,
                            _formatDate(booking.date),
                            theme,
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow(
                            Icons.access_time_rounded,
                            isDarkMode ? Colors.redAccent : Colors.red,
                            booking.startTime,
                            theme,
                          ),
                        ],
                      ),
                    ),
                    if (booking.note.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      _buildNoteSection(booking.note, theme, isDarkMode),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(
      IconData icon, Color color, String text, ThemeData theme) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoteSection(String note, ThemeData theme, bool isDarkMode) {
    final noteColor = isDarkMode ? Colors.amber.shade700 : Colors.amber;
    final backgroundColor = isDarkMode
        ? Colors.amber.shade900.withOpacity(0.2)
        : const Color.fromARGB(184, 68, 30, 1);
    final borderColor = isDarkMode
        ? Colors.amber.shade800.withOpacity(0.3)
        : Colors.yellow.shade200;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.note, size: 16, color: noteColor),
              const SizedBox(width: 8),
              Text(
                "Notes",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: noteColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            note,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.4,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  /// Convert the date format to `February 26, 2025`
  String _formatDate(String rawDate) {
    try {
      DateTime date = DateTime.parse(rawDate);
      return DateFormat('EEEE, MMMM d, y')
          .format(date); // Monday, February 26, 2025
    } catch (e) {
      return "Invalid date";
    }
  }

  Color _getStatusColor(String status, ThemeData theme) {
    final bool isDark = theme.brightness == Brightness.dark;

    switch (status.toLowerCase()) {
      case "pending":
        return isDark ? Colors.orange.shade300 : Colors.orange;
      case "accepted":
        return isDark ? Colors.green.shade300 : Colors.green;
      case "completed":
        return theme.primaryColor;
      case "declined":
        return isDark ? Colors.red.shade300 : Colors.red;
      default:
        return isDark ? Colors.grey.shade400 : Colors.grey;
    }
  }

  /// Builds a status badge with color
  Widget _buildStatusBadge(String status, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case "pending":
        bgColor = isDark
            ? Colors.orange.shade900.withOpacity(0.4)
            : Colors.orange.shade100;
        textColor = isDark ? Colors.orange.shade300 : Colors.orange.shade800;
        break;
      case "accepted":
        bgColor = isDark
            ? Colors.green.shade900.withOpacity(0.4)
            : Colors.green.shade100;
        textColor = isDark ? Colors.green.shade300 : Colors.green.shade800;
        break;
      case "completed":
        bgColor =
            isDark ? theme.primaryColor.withOpacity(0.2) : Colors.blue.shade100;
        textColor =
            isDark ? theme.primaryColor.withAlpha(240) : Colors.blue.shade800;
        break;
      case "declined":
        bgColor =
            isDark ? Colors.red.shade900.withOpacity(0.4) : Colors.red.shade100;
        textColor = isDark ? Colors.red.shade300 : Colors.red.shade800;
        break;
      default:
        bgColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
        textColor = isDark ? Colors.grey.shade300 : Colors.black;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

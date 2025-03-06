// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tutorme/features/booking/presentation/viewmodel/booking_bloc.dart';
// import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';

// class BookingConfirmationView extends StatefulWidget {
//   final TutorEntity tutor;

//   const BookingConfirmationView({super.key, required this.tutor});

//   @override
//   _BookingConfirmationViewState createState() =>
//       _BookingConfirmationViewState();
// }

// class _BookingConfirmationViewState extends State<BookingConfirmationView> {
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _timeController = TextEditingController();
//   final TextEditingController _noteController = TextEditingController();

//   @override
//   void dispose() {
//     _dateController.dispose();
//     _timeController.dispose();
//     _noteController.dispose();
//     super.dispose();
//   }

//   /// **Open Date Picker (Disables Past Dates)**
//   Future<void> _selectDate() async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(), // Default: today
//       firstDate: DateTime.now(), // Disable past dates
//       lastDate: DateTime(DateTime.now().year + 1), // Limit to one year ahead
//     );

//     if (pickedDate != null) {
//       setState(() {
//         _dateController.text =
//             "${pickedDate.toLocal()}".split(' ')[0]; // Format: YYYY-MM-DD
//       });
//     }
//   }

//   /// **Open Time Picker**
//   Future<void> _selectTime() async {
//     TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(), // Default: current time
//     );

//     if (pickedTime != null) {
//       setState(() {
//         _timeController.text =
//             pickedTime.format(context); // Format: HH:MM AM/PM
//       });
//     }
//   }

//   /// **Handle Booking Confirmation**
//   void _confirmBooking() {
//     final tutor = widget.tutor;
//     final date = _dateController.text.trim();
//     final time = _timeController.text.trim();
//     final note = _noteController.text.trim();

//     if (date.isEmpty || time.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter date and time.")),
//       );
//       return;
//     }
//     debugPrint(
//         "📅 Booking for: ${tutor.name} with id : ${tutor.tutorId}, Date: $date, Time: $time");

//     if (tutor.tutorId == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Error: Tutor information missing.")),
//       );
//       return;
//     }
//     context.read<BookingBloc>().add(
//           CreateBookingEvent(
//             tutorId: tutor.tutorId ?? "",
//             date: date,
//             time: time,
//             note: note.isNotEmpty ? note : "No additional notes",
//           ),
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Confirm Booking")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// **Tutor Information**
//             _buildTutorInfo(widget.tutor),
//             const SizedBox(height: 16),

//             /// **Date Field**
//             TextField(
//               controller: _dateController,
//               readOnly: true,
//               onTap: _selectDate, // Opens date picker
//               decoration: const InputDecoration(
//                 labelText: "Date",
//                 prefixIcon: Icon(Icons.calendar_today),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 12),

//             /// **Time Field**
//             TextField(
//               controller: _timeController,
//               readOnly: true,
//               onTap: _selectTime, // Opens time picker
//               decoration: const InputDecoration(
//                 labelText: "Time",
//                 prefixIcon: Icon(Icons.access_time),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 12),

//             /// **Note Field**
//             TextField(
//               controller: _noteController,
//               maxLines: 3,
//               decoration: const InputDecoration(
//                 labelText: "Additional Notes",
//                 prefixIcon: Icon(Icons.edit),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),

//             /// **Confirm Button**
//             BlocConsumer<BookingBloc, BookingState>(
//               listener: (context, state) {
//                 if (state is BookingCreated) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Booking Successful!")),
//                   );
//                   Navigator.pop(context); // Close the booking page
//                 } else if (state is BookingError) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text(state.message)),
//                   );
//                 }
//               },
//               builder: (context, state) {
//                 return SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: state is BookingLoading ? null : _confirmBooking,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF0961F5),
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                     ),
//                     child: state is BookingLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                             "Confirm Booking",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// **Tutor Information Card**
//   Widget _buildTutorInfo(TutorEntity tutor) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 6,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Image.network(
//               tutor.profileImage,
//               width: 80,
//               height: 80,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 80),
//             ),
//           ),
//           const SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 tutor.name,
//                 style:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 4),
//               Text("Rate: Rs. ${tutor.hourlyRate.toStringAsFixed(2)}/hr",
//                   style: const TextStyle(fontSize: 16)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorme/features/booking/presentation/viewmodel/booking_bloc.dart';
import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';

class BookingConfirmationView extends StatefulWidget {
  final TutorEntity tutor;

  const BookingConfirmationView({super.key, required this.tutor});

  @override
  _BookingConfirmationViewState createState() =>
      _BookingConfirmationViewState();
}

class _BookingConfirmationViewState extends State<BookingConfirmationView> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  /// **Open Date Picker (Disables Past Dates)**
  Future<void> _selectDate() async {
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Default: today
      firstDate: DateTime.now(), // Disable past dates
      lastDate: DateTime(DateTime.now().year + 1), // Limit to one year ahead
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: theme.primaryColor, // Header background
              onPrimary: Colors.white, // Header text
              onSurface: Colors.black87, // Calendar text
            ),
            dialogBackgroundColor:
                isDarkMode ? const Color(0xFF121212) : Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text =
            "${pickedDate.toLocal()}".split(' ')[0]; // Format: YYYY-MM-DD
      });
    }
  }

  /// **Open Time Picker**
  Future<void> _selectTime() async {
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(), // Default: current time
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: theme.primaryColor, // Header background
              onPrimary: Colors.white, // Header text
              onSurface: Colors.black87, // Clock text
            ),
            dialogBackgroundColor:
                isDarkMode ? const Color(0xFF121212) : Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        _timeController.text =
            pickedTime.format(context); // Format: HH:MM AM/PM
      });
    }
  }

  /// **Handle Booking Confirmation**
  void _confirmBooking() {
    final tutor = widget.tutor;
    final date = _dateController.text.trim();
    final time = _timeController.text.trim();
    final note = _noteController.text.trim();

    if (date.isEmpty || time.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please enter date and time."),
          backgroundColor: Theme.of(context).primaryColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }
    debugPrint(
        "📅 Booking for: ${tutor.name} with id : ${tutor.tutorId}, Date: $date, Time: $time");

    if (tutor.tutorId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Error: Tutor information missing."),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }
    context.read<BookingBloc>().add(
          CreateBookingEvent(
            tutorId: tutor.tutorId ?? "",
            date: date,
            time: time,
            note: note.isNotEmpty ? note : "No additional notes",
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final primaryColor = theme.primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Booking"),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [
                    theme.appBarTheme.backgroundColor ?? primaryColor,
                    theme.scaffoldBackgroundColor
                  ]
                : [const Color(0xFFE3F2FD), theme.scaffoldBackgroundColor],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Animated header
                _buildAnimatedHeader(),
                const SizedBox(height: 24),

                // Tutor information card
                _buildTutorInfo(widget.tutor),
                const SizedBox(height: 24),

                // Booking form section
                _buildBookingForm(isDarkMode, primaryColor),

                // Bottom section with confirmation button
                const SizedBox(height: 32),
                _buildConfirmButton(isDarkMode),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// **Animated Booking Header**
  Widget _buildAnimatedHeader() {
    return const Text(
      "Book Your Session",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Montserrat Bold',
      ),
    );
  }

  Widget _buildTutorInfo(TutorEntity tutor) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Hero(
                tag: 'tutor_${tutor.tutorId}',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: theme.primaryColor,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      tutor.profileImage,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 100,
                        height: 100,
                        color: isDarkMode
                            ? Colors.grey.shade800
                            : Colors.grey.shade200,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: isDarkMode
                              ? Colors.grey.shade600
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tutor.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat Bold',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${tutor.rating}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.school,
                          color: isDarkMode
                              ? Colors.lightBlueAccent
                              : theme.primaryColor,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        const Expanded(
                          child: Text(
                            "Expert Tutor",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Rs. ${tutor.hourlyRate.toStringAsFixed(2)}/hr",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode
                              ? Colors.lightBlueAccent
                              : theme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// **Booking Form Section**
  Widget _buildBookingForm(bool isDarkMode, Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Session Details",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 16),

        // Date & Time Row
        Row(
          children: [
            // Date Field
            Expanded(
              child: _buildInputField(
                controller: _dateController,
                label: "Select Date",
                hint: "YYYY-MM-DD",
                icon: Icons.calendar_today,
                onTap: _selectDate,
                isDarkMode: isDarkMode,
              ),
            ),
            const SizedBox(width: 16),
            // Time Field
            Expanded(
              child: _buildInputField(
                controller: _timeController,
                label: "Select Time",
                hint: "HH:MM",
                icon: Icons.access_time,
                onTap: _selectTime,
                isDarkMode: isDarkMode,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Notes Field
        _buildInputField(
          controller: _noteController,
          label: "Additional Notes",
          hint: "Any specific requirements or topics...",
          icon: Icons.edit_note,
          maxLines: 3,
          isDarkMode: isDarkMode,
        ),
      ],
    );
  }

  /// **Custom Input Field**
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    Function()? onTap,
    int maxLines = 1,
    required bool isDarkMode,
  }) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              readOnly: onTap != null,
              onTap: onTap,
              maxLines: maxLines,
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color:
                      isDarkMode ? Colors.grey.shade500 : Colors.grey.shade400,
                ),
                prefixIcon: Icon(
                  icon,
                  color: isDarkMode ? Colors.lightBlueAccent : primaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// **Enhanced Confirmation Button**
  Widget _buildConfirmButton(bool isDarkMode) {
    return BlocConsumer<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state is BookingCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 12),
                  Text(
                    "Booking Confirmed Successfully!",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              backgroundColor: Colors.green.shade700,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              duration: const Duration(seconds: 3),
            ),
          );
          Navigator.pop(context); // Close the booking page
        } else if (state is BookingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      state.message,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.red.shade700,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: state is BookingLoading ? null : _confirmBooking,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 0,
            ),
            child: state is BookingLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 20,
                        color: Colors.white,
                      ),
                      SizedBox(width: 12),
                      Text(
                        "Confirm Booking",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat Bold',
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

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
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Default: today
      firstDate: DateTime.now(), // Disable past dates
      lastDate: DateTime(DateTime.now().year + 1), // Limit to one year ahead
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
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(), // Default: current time
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
        const SnackBar(content: Text("Please enter date and time.")),
      );
      return;
    }
    debugPrint(
        "📅 Booking for: ${tutor.name} with id : ${tutor.tutorId}, Date: $date, Time: $time");

    if (tutor.tutorId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: Tutor information missing.")),
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
    return Scaffold(
      appBar: AppBar(title: const Text("Confirm Booking")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **Tutor Information**
            _buildTutorInfo(widget.tutor),
            const SizedBox(height: 16),

            /// **Date Field**
            TextField(
              controller: _dateController,
              readOnly: true,
              onTap: _selectDate, // Opens date picker
              decoration: const InputDecoration(
                labelText: "Date",
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            /// **Time Field**
            TextField(
              controller: _timeController,
              readOnly: true,
              onTap: _selectTime, // Opens time picker
              decoration: const InputDecoration(
                labelText: "Time",
                prefixIcon: Icon(Icons.access_time),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            /// **Note Field**
            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Additional Notes",
                prefixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            /// **Confirm Button**
            BlocConsumer<BookingBloc, BookingState>(
              listener: (context, state) {
                if (state is BookingCreated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Booking Successful!")),
                  );
                  Navigator.pop(context); // Close the booking page
                } else if (state is BookingError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state is BookingLoading ? null : _confirmBooking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0961F5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: state is BookingLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Confirm Booking",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// **Tutor Information Card**
  Widget _buildTutorInfo(TutorEntity tutor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              tutor.profileImage,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 80),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tutor.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text("Rate: Rs. ${tutor.hourlyRate.toStringAsFixed(2)}/hr",
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';

class TutorProfileView extends StatefulWidget {
  final TutorEntity tutor;

  const TutorProfileView({super.key, required this.tutor});

  @override
  _TutorProfileViewState createState() => _TutorProfileViewState();
}

class _TutorProfileViewState extends State<TutorProfileView> {
  @override
  Widget build(BuildContext context) {
    final tutor = widget.tutor;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        title: Text(tutor.name),
        backgroundColor: const Color(0xFF0961F5),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            _buildHeaderSection(tutor),
            const SizedBox(height: 16),

            // Rate, Minutes Tutored, Students
            _buildStatsCard(tutor),
            const SizedBox(height: 16),

            // Description
            _buildDescriptionSection(tutor),
            const SizedBox(height: 16),

            // Subjects
            _buildSubjectsSection(tutor),
            const SizedBox(height: 24),

            // Book Session Button
            _buildBookSessionButton(),

            const SizedBox(height: 24),

            // Reviews Section
            _buildReviewsSection(),
          ],
        ),
      ),
    );
  }

  /// Header Section with Avatar, Name, Rating, and Role
  Widget _buildHeaderSection(TutorEntity tutor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar + Rating
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(tutor.profileImage),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      tutor.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Example role/title
                    Text(
                      'Sr. Engineer • ${tutor.subjects.isNotEmpty ? tutor.subjects.first : "Expert"}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          tutor.rating.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0961F5),
                          ),
                        ),
                      ],
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

  /// Stats Card: Rate, Minutes Tutored, Students
  Widget _buildStatsCard(TutorEntity tutor) {
    // You can replace "Minutes tutored" and "Students" with real data if available
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem("Rate", "₹${tutor.hourlyRate}/hr"),
          _buildStatItem("Minutes tutored", "2223"), // Example static data
          _buildStatItem("Students", "222"), // Example static data
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  /// Description Section
  Widget _buildDescriptionSection(TutorEntity tutor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Description",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            tutor.description.isNotEmpty
                ? tutor.description
                : "No description provided.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  /// Subjects (Chips)
  Widget _buildSubjectsSection(TutorEntity tutor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "I can teach",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tutor.subjects.map((subject) {
              return Chip(
                label: Text(subject),
                backgroundColor: const Color(0xFF0961F5).withOpacity(0.1),
                labelStyle: const TextStyle(
                  color: Color(0xFF0961F5),
                  fontWeight: FontWeight.w600,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// Book a Session Button
  Widget _buildBookSessionButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Navigate to booking flow or open a bottom sheet
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0961F5),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "Book a Session",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /// Reviews Section
  Widget _buildReviewsSection() {
    // This is just sample data for demonstration
    final sampleReviews = [
      {
        "reviewer": "Will",
        "rating": 4.5,
        "text":
            "This course has been very helpful. Mentor was extremely knowledgeable."
      },
      {
        "reviewer": "Sophia",
        "rating": 5.0,
        "text":
            "Loved the sessions! The tutor was patient and explained everything clearly."
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title + "See All" button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Reviews",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // Navigate to a full reviews page
              },
              child: const Text(
                "SEE ALL",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // List of reviews
        Column(
          children: sampleReviews.map((review) {
            return _buildReviewItem(
              reviewer: review["reviewer"]!,
              rating: review["rating"] as double,
              text: review["text"]!,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildReviewItem({
    required String reviewer,
    required double rating,
    required String text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar placeholder
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFF0961F5).withOpacity(0.2),
            child: Text(
              reviewer[0], // initial
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFF0961F5),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Reviewer Name, Rating, and Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      reviewer,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(
                          rating.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0961F5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Review text
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

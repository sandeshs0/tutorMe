import 'package:flutter/material.dart';
import 'package:tutorme/features/booking/presentation/view/confirm_booking_view.dart';
import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';

class TutorProfileView extends StatefulWidget {
  final TutorEntity tutor;

  const TutorProfileView({super.key, required this.tutor});

  @override
  _TutorProfileViewState createState() => _TutorProfileViewState();
}

class _TutorProfileViewState extends State<TutorProfileView> {
  bool _isDescriptionExpanded = false;

  /// Builds a row of 5 stars (with half-star support) based on the given [rating].
  Widget _buildStarRating(double rating, {double size = 20}) {
    final int fullStars = rating.floor();
    final bool hasHalfStar = (rating - fullStars) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return Icon(Icons.star,
              color: const Color.fromARGB(255, 230, 158, 3), size: size);
        } else if (index == fullStars && hasHalfStar) {
          return Icon(Icons.star_half,
              color: const Color.fromARGB(255, 230, 158, 3), size: size);
        } else {
          return Icon(Icons.star_border,
              color: const Color.fromARGB(255, 230, 158, 3), size: size);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tutor = widget.tutor;

    return Scaffold(
      // backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          tutor.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0961F5),
        elevation: 4,
        shadowColor: Colors.blueAccent.withOpacity(0.2),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingConfirmationView(tutor: tutor),
            ),
          );
        },
        backgroundColor: const Color(0xFF0961F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Pill shape
        ),
        label: Row(
          // Ensures the contents are centered horizontally
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Book a Session",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            // Circular container for the arrow icon
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: Color(0xFF0961F5),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
        child: Column(
          children: [
            _buildProfileHeader(tutor),
            const SizedBox(height: 20),
            _buildBioSection(tutor),
            const SizedBox(height: 20),
            _buildSubjectsSection(tutor),
            const SizedBox(height: 24),
            _buildReviewsSection(),
          ],
        ),
      ),
    );
  }

// Somewhere in your code where you show the hourly rate:
  Widget _buildHourlyRate(double rate) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 70, 128)
            .withOpacity(0.1), // Light background
        borderRadius: BorderRadius.circular(16), // Pill shape
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Optional: Flutter 2.10+ has Icons.currency_rupee
          // Otherwise, you could just use a Text('₹') or 'Rs.'
          // const Icon(
          //   Icons.monetization_on,
          //   color: Color.fromARGB(255, 0, 70, 128),
          //   size: 18,
          // ),
          const Text(
            'Rs. ',
            style: TextStyle(
              fontSize: 16,
              // fontWeight: FontWeigh,
              color: Color.fromARGB(255, 0, 70, 128),
            ),
          ),
          Text(
            rate.toStringAsFixed(2),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 70, 128),
            ),
          ),
          const Text(
            ' /hour',
            style: TextStyle(
              fontSize: 14,
              // fontWeight: FontWeigh,
              color: Color.fromARGB(255, 0, 70, 128),
            ),
          ),
        ],
      ),
    );
  }

  /// A stack-based header that places the avatar partially overlapping the top container.
  Widget _buildProfileHeader(TutorEntity tutor) {
    final theme = Theme.of(context);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Background container (where the avatar is half inside/outside).
        Container(
          margin: const EdgeInsets.only(top: 60),
          padding:
              const EdgeInsets.only(top: 80, bottom: 16, right: 80, left: 80),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              // Tutor Name
              Text(
                tutor.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A237E),
                ),
              ),

              const SizedBox(height: 8),
              // Short bio
              Text(
                tutor.bio.isNotEmpty ? tutor.bio : "Expert Tutor",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              // Star rating (out of 5)
              _buildStarRating(tutor.rating, size: 26),
              const SizedBox(height: 8),
              // Hourly Rate (visual priority)
              // Text(
              //   'Rs. ${tutor.hourlyRate} /hr',
              //   style: const TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     color: Color.fromARGB(255, 91, 3, 3),
              //   ),
              // ),
              _buildHourlyRate(tutor.hourlyRate),
            ],
          ),
        ),
        // Avatar image
        Hero(
          tag: 'tutor-avatar-${tutor.tutorId}',
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                tutor.profileImage,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.person, size: 60),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Bio section with read more/less functionality.
  Widget _buildBioSection(TutorEntity tutor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About me',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A237E),
            ),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final textSpan = TextSpan(
                text: tutor.description.isNotEmpty
                    ? tutor.description
                    : "No description available.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              );

              final textPainter = TextPainter(
                text: textSpan,
                maxLines: 3,
                textDirection: TextDirection.ltr,
              )..layout(maxWidth: constraints.maxWidth);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    textSpan,
                    maxLines: _isDescriptionExpanded ? null : 3,
                    overflow: TextOverflow.fade,
                  ),
                  if (textPainter.didExceedMaxLines)
                    TextButton(
                      onPressed: () => setState(() {
                        _isDescriptionExpanded = !_isDescriptionExpanded;
                      }),
                      child: Text(
                        _isDescriptionExpanded ? 'Read Less' : 'Read More',
                        style: const TextStyle(color: Color(0xFF0961F5)),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  /// Section listing the tutor's teaching subjects.
  Widget _buildSubjectsSection(TutorEntity tutor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.05),
            blurRadius: 8,
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
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A237E),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: tutor.subjects.map((subject) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0961F5).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    subject,
                    style: const TextStyle(
                      color: Color(0xFF0961F5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// Section displaying sample reviews.
  Widget _buildReviewsSection() {
    final sampleReviews = [
      {
        "reviewer": "Will",
        "rating": 4.5,
        "text":
            "This course has been very helpful. Mentor was extremely knowledgeable.",
        "date": "2 days ago"
      },
      {
        "reviewer": "Sophia",
        "rating": 5.0,
        "text":
            "Loved the sessions! The tutor was patient and explained everything clearly.",
        "date": "1 week ago"
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Student Reviews",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A237E),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Text(
                      "View All",
                      style: TextStyle(
                        color: Color(0xFF0961F5),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward_rounded, size: 16),
                  ],
                ),
              ),
            ],
          ),
          // Review items
          ...sampleReviews.map((review) => _buildReviewItem(
                reviewer: review["reviewer"] as String,
                rating: review["rating"] as double,
                text: review["text"] as String,
                date: review["date"] as String,
              )),
        ],
      ),
    );
  }

  /// A single review item with star rating.
  Widget _buildReviewItem({
    required String reviewer,
    required double rating,
    required String text,
    required String date,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Initial letter avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blueAccent.withOpacity(0.1),
            child: Text(
              reviewer[0],
              style: const TextStyle(
                color: Color(0xFF0961F5),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Review details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Reviewer name & star rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      reviewer,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A237E),
                      ),
                    ),
                    Row(
                      children: [
                        _buildStarRating(rating, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
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
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                // Date
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
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

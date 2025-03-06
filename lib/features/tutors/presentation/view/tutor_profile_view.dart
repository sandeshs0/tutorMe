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
  final ScrollController _scrollController = ScrollController();
  bool _showBookButton = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final isBottom = _scrollController.offset >=
          _scrollController.position.maxScrollExtent - 50;
      setState(() {
        _showBookButton = !isBottom;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildStarRating(double rating, {double size = 20, Color? color}) {
    final int fullStars = rating.floor();
    final bool hasHalfStar = (rating - fullStars) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return Icon(Icons.star, color: color, size: size);
        } else if (index == fullStars && hasHalfStar) {
          return Icon(Icons.star_half, color: color, size: size);
        } else {
          return Icon(Icons.star_border, color: color, size: size);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tutor = widget.tutor;
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final isDark = theme.brightness == Brightness.dark;

    final textColor = isDark ? Colors.white : Colors.black87;
    final backgroundColor = theme.scaffoldBackgroundColor;
    final cardColor = theme.cardColor;

    final primaryDarkColor = isDark
        ? primaryColor.withOpacity(0.7)
        : const Color.fromARGB(255, 0, 74, 203);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: primaryColor,
            title: Text(tutor.name),
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeaderBackground(tutor),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: _buildProfileContent(
                tutor, primaryColor, primaryDarkColor, textColor, cardColor),
          ),
        ],
      ),
      floatingActionButton: _showBookButton
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingConfirmationView(tutor: tutor),
                  ),
                );
              },
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              label: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Book a Session",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildHeaderBackground(TutorEntity tutor) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black87],
            ).createShader(rect);
          },
          blendMode: BlendMode.darken,
          child: Image.network(
            tutor.profileImage,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Theme.of(context).primaryColor,
              child: const Icon(Icons.person, size: 80, color: Colors.white54),
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tutor.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  _buildStarRating(tutor.rating, size: 20, color: Colors.amber),
                  const SizedBox(width: 8),
                  Text(
                    "(${tutor.rating.toStringAsFixed(1)})",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileContent(TutorEntity tutor, Color primaryColor,
      Color primaryDarkColor, Color textColor, Color cardColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHourlyRateCard(tutor, primaryColor, textColor, cardColor),
          const SizedBox(height: 24),

          _buildSectionCard(
            title: "About",
            icon: Icons.person,
            iconColor: primaryColor,
            content: _buildAboutSection(tutor, primaryColor, textColor),
            cardColor: cardColor,
            textColor: textColor,
          ),
          const SizedBox(height: 16),

          _buildSectionCard(
            title: "Subjects",
            icon: Icons.school,
            iconColor: primaryColor,
            content: _buildSubjectsSection(tutor, primaryColor),
            cardColor: cardColor,
            textColor: textColor,
          ),
          const SizedBox(height: 16),

          _buildSectionCard(
            title: "Reviews",
            icon: Icons.star,
            iconColor: primaryColor,
            content: _buildReviewsSection(primaryColor, textColor),
            cardColor: cardColor,
            textColor: textColor,
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyRateCard(
      TutorEntity tutor, Color primaryColor, Color textColor, Color cardColor) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        color: cardColor,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Rs. ${tutor.hourlyRate.toStringAsFixed(2)}/hr",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode
                    ? const Color.fromARGB(255, 12, 167, 136)
                    : theme.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Widget content,
    required Color cardColor,
    required Color textColor,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: textColor.withOpacity(0.1), height: 1),
          content,
        ],
      ),
    );
  }

  Widget _buildAboutSection(
      TutorEntity tutor, Color primaryColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final textSpan = TextSpan(
                text: tutor.description.isNotEmpty
                    ? tutor.description
                    : "No Description",
                style: TextStyle(
                  fontSize: 14,
                  color: textColor.withOpacity(0.8),
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
                    overflow: _isDescriptionExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                  ),
                  if (textPainter.didExceedMaxLines)
                    TextButton(
                      onPressed: () => setState(() {
                        _isDescriptionExpanded = !_isDescriptionExpanded;
                      }),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        alignment: Alignment.centerLeft,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _isDescriptionExpanded ? 'Read Less' : 'Read More',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            _isDescriptionExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: primaryColor,
                            size: 16,
                          ),
                        ],
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

  Widget _buildSubjectsSection(TutorEntity tutor, Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: tutor.subjects.map((subject) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: primaryColor.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getSubjectIcon(subject),
                  color: primaryColor,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  subject,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  IconData _getSubjectIcon(String subject) {
    final subjectLow = subject.toLowerCase();
    if (subjectLow.contains('math')) return Icons.calculate;
    if (subjectLow.contains('science')) return Icons.science;
    if (subjectLow.contains('computer')) return Icons.computer;
    if (subjectLow.contains('history')) return Icons.history_edu;
    if (subjectLow.contains('english')) return Icons.menu_book;
    if (subjectLow.contains('language')) return Icons.language;
    if (subjectLow.contains('art')) return Icons.palette;
    if (subjectLow.contains('music')) return Icons.music_note;
    return Icons.school;
  }

  Widget _buildReviewsSection(Color primaryColor, Color textColor) {
    final sampleReviews = [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...sampleReviews.map((review) => _buildReviewItem(
              reviewer: review["reviewer"] as String,
              rating: review["rating"] as double,
              text: review["text"] as String,
              date: review["date"] as String,
              avatar: review["avatar"] as String,
              primaryColor: primaryColor,
              textColor: textColor,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: primaryColor,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: primaryColor.withOpacity(0.5)),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItem({
    required String reviewer,
    required double rating,
    required String text,
    required String date,
    required String avatar,
    required Color primaryColor,
    required Color textColor,
  }) {
    final colors = [
      primaryColor,
      primaryColor.withOpacity(0.7),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: textColor.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                avatar,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        reviewer,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          rating.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xFFFFC107),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFC107),
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: TextStyle(
                    color: textColor.withOpacity(0.8),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  date,
                  style: TextStyle(
                    color: textColor.withOpacity(0.5),
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

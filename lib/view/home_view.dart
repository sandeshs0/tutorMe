import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tutorme/view/tutor_profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> _promoCards = [
    {
      'title': '25% OFF*',
      'description':
          'New Year Offer! Use Promo Code "Everest20" to get 25% off from Jan 1 - Jan 7.'
    },
    {
      'title': 'Exclusive Access',
      'description':
          'Unlock premium features by subscribing to our annual plan.'
    },
    {
      'title': 'Special Discount',
      'description': 'Get a 15% discount on all tutoring sessions this month!'
    },
  ];

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _promoCards.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth >= 600;

    return Scaffold(
      backgroundColor: const Color(0xfff2fafa), // Set background color here

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(
                          8), // Adjust padding to match the design
                      decoration: BoxDecoration(
                        color: const Color(0xff0961f5), // Blue background color
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                      ),
                      child: const Icon(
                        Icons.tune,
                        color: Colors
                            .white, // White icon color to match the design
                        size: 20, // Adjust size if necessary
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Carousel Section
              _buildPromoCarousel(),
              const SizedBox(height: 20),
              // Popular Tutors Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Tutors',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'SEE ALL',
                          style: TextStyle(
                              color: Color(0xff0961f5),
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(width: 4), // Spacing between text and icon
                        Icon(
                          Icons.arrow_forward_ios, // Use an arrow icon
                          size: 16, // Adjust size to match design
                          color: Color(0xff0961f5),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildPopularTutorCard(context, isTablet),
                    _buildPopularTutorCard(context, isTablet),
                    _buildPopularTutorCard(context, isTablet),
                    _buildPopularTutorCard(context, isTablet),
                    _buildPopularTutorCard(context, isTablet),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Categories Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'SEE ALL',
                          style: TextStyle(
                              color: Color(0xff0961f5),
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(width: 4), // Spacing between text and icon
                        Icon(
                          Icons.arrow_forward_ios, // Use an arrow icon
                          size: 16, // Adjust size to match design
                          color: Color(0xff0961f5),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      'Physics',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Computer Science',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 40, 73),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Video Animation',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Computer Science',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 40, 73),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Video Animation',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Computer Science',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 40, 73),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Video Animation',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Video Animation',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Video Animation',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Video Animation',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Recommended Section
              const Text(
                'Recommended for you',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 2 : 1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: isTablet ? 3 : 2.1,
                ),
                itemCount: 4,
                itemBuilder: (context, index) => _buildCustomRecommendationCard(
                    screenHeight * 0.3, isTablet),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoCarousel() {
    return SizedBox(
      height: 150,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _promoCards.length,
        itemBuilder: (context, index) {
          final promo = _promoCards[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 28, 78, 244),
                  Color.fromARGB(255, 55, 3, 128)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  promo['title']!,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  promo['description']!,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCustomRecommendationCard(double cardHeight, bool isTablet) {
    return Container(
      height: cardHeight,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/avatar.jpg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Er. Narendra Kunwar',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'Senior Software Engineer',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
          // const SizedBox(height: 10),
          if (isTablet)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildSkillChip('JavaScript'),
                _buildSkillChip('Node.js'),
                _buildSkillChip('Data Structures'),
                _buildSkillChip('Generative AI'),
              ],
            ),
          if (isTablet) const SizedBox(height: 1),
          if (isTablet) const Divider(),
          // const SizedBox(height: 5),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Rate', style: TextStyle(color: Colors.grey)),
                    Text('Rs. 230 / hour',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Minutes tutored',
                        style: TextStyle(color: Colors.grey)),
                    Text('4311',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Students', style: TextStyle(color: Colors.grey)),
                    Text('140',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        skill,
        style: const TextStyle(
            fontSize: 12, color: Color.fromARGB(255, 16, 27, 40)),
      ),
    );
  }

  Widget _buildPopularTutorCard(BuildContext context, bool isTablet) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TutorProfile(
                      name: 'Er. Narendra Kunwar',
                      role: 'Data Scientist • Sr. Engineer',
                      rating: 4.8,
                      description:
                          'Hi, I am Narendra, a data scientist at XYZ company. I can help you with Data Science, Machine Learning concepts.',
                      rate: 230,
                      minutesTutored: 2223,
                      students: 222,
                      skills: [
                        'Data Science',
                        'Python',
                        'Career',
                        'Mathematics',
                        'Machine Learning'
                      ],
                      reviews: [
                        {
                          'name': 'Will',
                          'review':
                              'This course has been very useful. Mentor was great!',
                          'rating': 4.5,
                        },
                        {
                          'name': 'Emma',
                          'review':
                              'Amazing tutor! Helped me understand complex topics easily.',
                          'rating': 5.0,
                        },
                      ],
                    )),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.all(12),
          width: isTablet ? 400 : 350,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    radius: 30,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Er. Narendra Kunwar',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text('Machine Learning',
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '4.4',
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Icon(Icons.star, color: Colors.orange, size: 16),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Divider(color: Colors.grey[300]),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Rate',
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('Rs. 230/hour',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Minutes tutored',
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('4311',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Students',
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('140',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

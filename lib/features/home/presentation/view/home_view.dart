import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorme/features/home/presentation/view_model/home_cubit.dart';
import 'package:tutorme/features/home/presentation/view_model/home_state.dart';

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
    return BlocBuilder<HomeCubit, DashboardState>(
      builder: (context, state) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        final isTablet = screenWidth >= 600;

        return Scaffold(
          backgroundColor: const Color(0xfff2fafa),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: 20),
                  _buildPromoCarousel(),
                  const SizedBox(height: 20),
                  _buildSectionHeader('Popular Tutors'),
                  _buildPopularTutorsRow(isTablet),
                  const SizedBox(height: 20),
                  _buildSectionHeader('Categories'),
                  _buildCategoryList(),
                  const SizedBox(height: 20),
                  const Text(
                    'Recommended for you',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildRecommendationGrid(screenHeight, isTablet),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xff0961f5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.tune,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
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

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              SizedBox(width: 4),
              Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xff0961f5)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPopularTutorsRow(bool isTablet) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(5, (index) => _buildPopularTutorCard(isTablet)),
      ),
    );
  }

  Widget _buildPopularTutorCard(bool isTablet) {
    return Container(
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
      child: const Text('Tutor Card Placeholder'),
    );
  }

  Widget _buildCategoryList() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text('Physics', style: TextStyle(color: Colors.grey, fontSize: 14)),
          SizedBox(width: 20),
          Text('Computer Science',
              style: TextStyle(color: Colors.black, fontSize: 14)),
          SizedBox(width: 20),
          Text('Video Animation',
              style: TextStyle(color: Colors.grey, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildRecommendationGrid(double screenHeight, bool isTablet) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 2 : 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: isTablet ? 3 : 2.1,
      ),
      itemCount: 4,
      itemBuilder: (context, index) =>
          _buildCustomRecommendationCard(screenHeight),
    );
  }

  Widget _buildCustomRecommendationCard(double cardHeight) {
    return Container(
      height: cardHeight,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text('Recommendation Card Placeholder'),
    );
  }
}

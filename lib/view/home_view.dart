// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tutorme/features/home/presentation/view_model/home_cubit.dart';
// import 'package:tutorme/features/home/presentation/view_model/home_state.dart';
// import 'package:tutorme/view/tutor_profile.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final List<Map<String, String>> _promoCards = [
//     {
//       'title': '25% OFF*',
//       'description':
//           'New Year Offer! Use Promo Code "Everest20" to get 25% off from Jan 1 - Jan 7.'
//     },
//     {
//       'title': 'Exclusive Access',
//       'description':
//           'Unlock premium features by subscribing to our annual plan.'
//     },
//     {
//       'title': 'Special Discount',
//       'description': 'Get a 15% discount on all tutoring sessions this month!'
//     },
//   ];

//   late PageController _pageController;
//   int _currentPage = 0;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//     _startAutoSlide();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _startAutoSlide() {
//     Timer.periodic(const Duration(seconds: 3), (Timer timer) {
//       if (_currentPage < _promoCards.length - 1) {
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }

//       if (_pageController.hasClients) {
//         _pageController.animateToPage(
//           _currentPage,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final isTablet = screenWidth >= 600;

//     return BlocBuilder<HomeCubit, DashboardState>(
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: const Color(0xfff2fafa), // Set background color here

//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Search Bar
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.2),
//                           blurRadius: 5,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.search, color: Colors.grey),
//                         const SizedBox(width: 8),
//                         const Expanded(
//                           child: TextField(
//                             decoration: InputDecoration(
//                               hintText: 'Search for...',
//                               border: InputBorder.none,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(
//                               8), // Adjust padding to match the design
//                           decoration: BoxDecoration(
//                             color: const Color(
//                                 0xff0961f5), // Blue background color
//                             borderRadius:
//                                 BorderRadius.circular(8), // Rounded corners
//                           ),
//                           child: const Icon(
//                             Icons.tune,
//                             color: Colors
//                                 .white, // White icon color to match the design
//                             size: 20, // Adjust size if necessary
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // Carousel Section
//                   _buildPromoCarousel(),
//                   const SizedBox(height: 20),
//                   // Popular Tutors Section
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Popular Tutors',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       TextButton(
//                         onPressed: () {},
//                         child: const Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               'SEE ALL',
//                               style: TextStyle(
//                                   color: Color(0xff0961f5),
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w800),
//                             ),
//                             SizedBox(width: 4), // Spacing between text and icon
//                             Icon(
//                               Icons.arrow_forward_ios, // Use an arrow icon
//                               size: 16, // Adjust size to match design
//                               color: Color(0xff0961f5),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         _buildPopularTutorCard(context, isTablet),
//                         _buildPopularTutorCard(context, isTablet),
//                         _buildPopularTutorCard(context, isTablet),
//                         _buildPopularTutorCard(context, isTablet),
//                         _buildPopularTutorCard(context, isTablet),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Categories Section
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Categories',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       TextButton(
//                         onPressed: () {},
//                         child: const Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               'SEE ALL',
//                               style: TextStyle(
//                                   color: Color(0xff0961f5),
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w800),
//                             ),
//                             SizedBox(width: 4), // Spacing between text and icon
//                             Icon(
//                               Icons.arrow_forward_ios, // Use an arrow icon
//                               size: 16, // Adjust size to match design
//                               color: Color(0xff0961f5),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                   const SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         Text(
//                           'Physics',
//                           style: TextStyle(color: Colors.grey, fontSize: 14),
//                         ),
//                         SizedBox(width: 20),
//                         Text(
//                           'Computer Science',
//                           style: TextStyle(
//                               color: Color.fromARGB(255, 0, 40, 73),
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(width: 20),
//                         Text(
//                           'Video Animation',
//                           style: TextStyle(color: Colors.grey, fontSize: 14),
//                         ),
//                         SizedBox(width: 20),
//                         Text(
//                           'Computer Science',
//                           style: TextStyle(
//                               color: Color.fromARGB(255, 0, 40, 73),
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(width: 20),
//                         Text(
//                           'Video Animation',
//                           style: TextStyle(color: Colors.grey, fontSize: 14),
//                         ),
//                         SizedBox(width: 20),
//                         Text(
//                           'Computer Science',
//                           style: TextStyle(
//                               color: Color.fromARGB(255, 0, 40, 73),
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(width: 20),
//                         Text(
//                           'Video Animation',
//                           style: TextStyle(color: Colors.grey, fontSize: 14),
//                         ),
//                         SizedBox(width: 20),
//                         Text(
//                           'Video Animation',
//                           style: TextStyle(color: Colors.grey, fontSize: 14),
//                         ),
//                         SizedBox(width: 20),
//                         Text(
//                           'Video Animation',
//                           style: TextStyle(color: Colors.grey, fontSize: 14),
//                         ),
//                         SizedBox(width: 20),
//                         Text(
//                           'Video Animation',
//                           style: TextStyle(color: Colors.grey, fontSize: 14),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   // Recommended Section
//                   const Text(
//                     'Recommended for you',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   GridView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: isTablet ? 2 : 1,
//                       crossAxisSpacing: 16,
//                       mainAxisSpacing: 16,
//                       childAspectRatio: isTablet ? 3 : 2.1,
//                     ),
//                     itemCount: 4,
//                     itemBuilder: (context, index) =>
//                         _buildCustomRecommendationCard(
//                             screenHeight * 0.3, isTablet),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildPromoCarousel() {
//     return SizedBox(
//       height: 150,
//       child: PageView.builder(
//         controller: _pageController,
//         itemCount: _promoCards.length,
//         itemBuilder: (context, index) {
//           final promo = _promoCards[index];
//           return Container(
//             margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               gradient: const LinearGradient(
//                 colors: [
//                   Color.fromARGB(255, 28, 78, 244),
//                   Color.fromARGB(255, 55, 3, 128)
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   promo['title']!,
//                   style: const TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   promo['description']!,
//                   style: const TextStyle(fontSize: 14, color: Colors.white),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildCustomRecommendationCard(double cardHeight, bool isTablet) {
//     return Container(
//       height: cardHeight,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.asset(
//                   'assets/images/avatar.jpg',
//                   width: 80,
//                   height: 80,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               const Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Er. Narendra Kunwar',
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                     ),
//                     Text(
//                       'Senior Software Engineer',
//                       style: TextStyle(color: Colors.grey, fontSize: 14),
//                     ),
//                     SizedBox(height: 8),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           // const SizedBox(height: 10),
//           if (isTablet)
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: [
//                 _buildSkillChip('JavaScript'),
//                 _buildSkillChip('Node.js'),
//                 _buildSkillChip('Data Structures'),
//                 _buildSkillChip('Generative AI'),
//               ],
//             ),
//           if (isTablet) const SizedBox(height: 1),
//           if (isTablet) const Divider(),
//           // const SizedBox(height: 5),
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Flexible(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Rate', style: TextStyle(color: Colors.grey)),
//                     Text('Rs. 230 / hour',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16)),
//                   ],
//                 ),
//               ),
//               Flexible(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Minutes tutored',
//                         style: TextStyle(color: Colors.grey)),
//                     Text('4311',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16)),
//                   ],
//                 ),
//               ),
//               Flexible(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Students', style: TextStyle(color: Colors.grey)),
//                     Text('140',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSkillChip(String skill) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.blue[50],
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Text(
//         skill,
//         style: const TextStyle(
//             fontSize: 12, color: Color.fromARGB(255, 16, 27, 40)),
//       ),
//     );
//   }

//   Widget _buildPopularTutorCard(BuildContext context, bool isTablet) {
//     return GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => const TutorProfile(
//                       name: 'Er. Narendra Kunwar',
//                       role: 'Data Scientist • Sr. Engineer',
//                       rating: 4.8,
//                       description:
//                           'Hi, I am Narendra, a data scientist at XYZ company. I can help you with Data Science, Machine Learning concepts.',
//                       rate: 230,
//                       minutesTutored: 2223,
//                       students: 222,
//                       skills: [
//                         'Data Science',
//                         'Python',
//                         'Career',
//                         'Mathematics',
//                         'Machine Learning'
//                       ],
//                       reviews: [
//                         {
//                           'name': 'Will',
//                           'review':
//                               'This course has been very useful. Mentor was great!',
//                           'rating': 4.5,
//                         },
//                         {
//                           'name': 'Emma',
//                           'review':
//                               'Amazing tutor! Helped me understand complex topics easily.',
//                           'rating': 5.0,
//                         },
//                       ],
//                     )),
//           );
//         },
//         child: Container(
//           margin: const EdgeInsets.only(right: 16),
//           padding: const EdgeInsets.all(12),
//           width: isTablet ? 400 : 350,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 blurRadius: 5,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundImage: AssetImage('assets/images/avatar.jpg'),
//                     radius: 30,
//                   ),
//                   SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Er. Narendra Kunwar',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 16),
//                         ),
//                         Text('Machine Learning',
//                             style: TextStyle(color: Colors.grey, fontSize: 12)),
//                       ],
//                     ),
//                   ),
//                   Column(
//                     children: [
//                       Text(
//                         '4.4',
//                         style: TextStyle(
//                             color: Colors.orange,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16),
//                       ),
//                       Icon(Icons.star, color: Colors.orange, size: 16),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               Divider(color: Colors.grey[300]),
//               const SizedBox(height: 8),
//               const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Rate',
//                           style: TextStyle(color: Colors.grey, fontSize: 12)),
//                       Text('Rs. 230/hour',
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Minutes tutored',
//                           style: TextStyle(color: Colors.grey, fontSize: 12)),
//                       Text('4311',
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Students',
//                           style: TextStyle(color: Colors.grey, fontSize: 12)),
//                       Text('140',
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ));
//   }
// }

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tutorme/features/home/presentation/view_model/home_cubit.dart';
// import 'package:tutorme/features/home/presentation/view_model/home_state.dart';
// import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';
// // import 'package:tutorme/view/tutor_profile_view.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final List<Map<String, String>> _promoCards = [
//     {
//       'title': '25% OFF*',
//       'description':
//           'New Year Offer! Use Promo Code "Everest20" to get 25% off from Jan 1 - Jan 7.'
//     },
//     {
//       'title': 'Exclusive Access',
//       'description':
//           'Unlock premium features by subscribing to our annual plan.'
//     },
//     {
//       'title': 'Special Discount',
//       'description': 'Get a 15% discount on all tutoring sessions this month!'
//     },
//   ];

//   late PageController _pageController;
//   int _currentPage = 0;
//   int _loadedTutors = 10; // Number of tutors to load initially

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//     _startAutoSlide();
//     context.read<HomeCubit>().fetchTutors(); // ✅ Fetch tutors when home loads
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _startAutoSlide() {
//     Timer.periodic(const Duration(seconds: 3), (Timer timer) {
//       if (_currentPage < _promoCards.length - 1) {
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }

//       if (_pageController.hasClients) {
//         _pageController.animateToPage(
//           _currentPage,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, DashboardState>(
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: const Color(0xfff2fafa),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildSearchBar(),
//                   const SizedBox(height: 20),
//                   _buildPromoCarousel(),
//                   const SizedBox(height: 20),
//                   _buildSectionHeader('Popular Tutors'),
//                   _buildPopularTutorsSection(state),
//                   const SizedBox(height: 20),
//                   _buildSectionHeader('Browse Tutors'),
//                   _buildTutorList(state),
//                   _buildLoadMoreButton(state),
//                   const SizedBox(height: 20),
//                   _buildSectionHeader('Categories'),
//                   _buildCategoryList(),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   /// **Popular Tutors Section - Horizontally Scrollable**
//   Widget _buildPopularTutorsSection(DashboardState state) {
//     final List<TutorEntity> sortedTutors = List.from(state.tutors)
//       ..sort((a, b) => b.rating.compareTo(a.rating));
//     final List<TutorEntity> topTutors = sortedTutors.take(4).toList();

//     return SizedBox(
//       height: 200,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: topTutors.length,
//         itemBuilder: (context, index) {
//           return _buildPopularTutorCard(topTutors[index]);
//         },
//       ),
//     );
//   }

//   /// **Search Bar**
//   Widget _buildSearchBar() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.search, color: Colors.grey),
//           const SizedBox(width: 8),
//           const Expanded(
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search for tutors...',
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: const Color(0xff0961f5),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Icon(
//               Icons.tune,
//               color: Colors.white,
//               size: 20,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// **Promo Carousel**
//   Widget _buildPromoCarousel() {
//     return SizedBox(
//       height: 150,
//       child: PageView.builder(
//         controller: _pageController,
//         itemCount: _promoCards.length,
//         itemBuilder: (context, index) {
//           final promo = _promoCards[index];
//           return Container(
//             margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               gradient: const LinearGradient(
//                 colors: [Color(0xFF1C4EF4), Color(0xFF370380)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   promo['title']!,
//                   style: const TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   promo['description']!,
//                   style: const TextStyle(fontSize: 14, color: Colors.white),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   /// **Popular Tutors (Horizontally Scrollable)**
//   /// **Popular Tutor Card (Compact Horizontal Design)**
//   Widget _buildPopularTutorCard(TutorEntity tutor) {
//     return Container(
//       width: 160,
//       margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 8,
//             spreadRadius: 2,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           CircleAvatar(
//             backgroundImage: NetworkImage(tutor.profileImage),
//             radius: 35,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             tutor.name,
//             style: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 4),
//           Text(
//             tutor.subjects.take(2).join(', '),
//             style: const TextStyle(fontSize: 12, color: Colors.grey),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 6),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.star, color: Colors.amber, size: 18),
//               Text(
//                 tutor.rating.toString(),
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   /// **Tutor List with Pagination**
//   Widget _buildTutorList(DashboardState state) {
//     final tutorsToShow = state.tutors.take(_loadedTutors).toList();

//     return Column(
//       children: tutorsToShow.map((tutor) => _buildTutorCard(tutor)).toList(),
//     );
//   }

//   /// **Load More Button**
//   Widget _buildLoadMoreButton(DashboardState state) {
//     if (state.tutors.length <= _loadedTutors) return const SizedBox.shrink();

//     return Center(
//       child: ElevatedButton(
//         onPressed: () {
//           setState(() {
//             _loadedTutors += 10; // Load 10 more tutors
//           });
//         },
//         child: const Text('Load More'),
//       ),
//     );
//   }

//   /// **Tutor Card for Browse Tutors Section**
//   Widget _buildTutorCard(TutorEntity tutor) {
//     return GestureDetector(
//       onTap: () {
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (context) => TutorProfileView(tutor: tutor),
//         //   ),
//         // );
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               blurRadius: 8,
//               spreadRadius: 2,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.network(
//                     tutor.profileImage,
//                     height: 80,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Positioned(
//                   bottom: -20,
//                   child: CircleAvatar(
//                     backgroundImage: NetworkImage(tutor.profileImage),
//                     radius: 30,
//                     backgroundColor: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 25),
//             Text(
//               tutor.name,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             Text(
//               tutor.bio,
//               style: const TextStyle(
//                 fontSize: 13,
//                 color: Colors.grey,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.star, color: Colors.amber, size: 18),
//                 Text(
//                   tutor.rating.toString(),
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(width: 5),
//                 Text(
//                   '₹${tutor.hourlyRate}/hr',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Wrap(
//               spacing: 6,
//               children: tutor.subjects
//                   .take(3)
//                   .map((subject) => Chip(
//                         label: Text(subject),
//                         backgroundColor: const Color(0xFFD0E1FF),
//                       ))
//                   .toList(),
//             ),
//             const SizedBox(height: 12),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(
//                 //     builder: (context) => TutorProfileView(tutor: tutor),
//                 //   ),
//                 // );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff0961f5),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               ),
//               child: const Text(
//                 'View Profile',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// **Section Header Widget**
//   Widget _buildSectionHeader(String title, {VoidCallback? onSeeAllPressed}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         if (onSeeAllPressed != null) // If `SEE ALL` button is needed
//           TextButton(
//             onPressed: onSeeAllPressed,
//             child: const Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'SEE ALL',
//                   style: TextStyle(
//                       color: Color(0xff0961f5),
//                       fontSize: 15,
//                       fontWeight: FontWeight.w800),
//                 ),
//                 SizedBox(width: 4),
//                 Icon(Icons.arrow_forward_ios,
//                     size: 16, color: Color(0xff0961f5)),
//               ],
//             ),
//           ),
//       ],
//     );
//   }

//   /// **Category List**
//   Widget _buildCategoryList() {
//     return const SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//           Text('Physics', style: TextStyle(color: Colors.grey, fontSize: 14)),
//           SizedBox(width: 20),
//           Text('Computer Science',
//               style: TextStyle(color: Colors.black, fontSize: 14)),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorme/features/home/presentation/view_model/home_cubit.dart';
import 'package:tutorme/features/home/presentation/view_model/home_state.dart';
import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';

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
  int _loadedTutors = 10;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
    context.read<HomeCubit>().fetchTutors();
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
        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFF),
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  expandedHeight: 120,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _buildSearchBar(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPromoCarousel(),
                        const SizedBox(height: 24),
                        _buildSectionHeader('Popular Tutors',
                            onSeeAllPressed: () {/* Implementation */}),
                        const SizedBox(height: 16),
                        _buildPopularTutorsSection(state),
                        const SizedBox(height: 24),
                        _buildSectionHeader('Browse Tutors'),
                        const SizedBox(height: 16),
                        _buildTutorList(state),
                        _buildLoadMoreButton(state),
                        const SizedBox(height: 24),
                        _buildSectionHeader('Categories',
                            onSeeAllPressed: () {/* Implementation */}),
                        const SizedBox(height: 16),
                        _buildCategoryList(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Hero(
      tag: 'searchBar',
      child: Material(
        elevation: 4,
        shadowColor: Colors.black12,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Color(0xFF0961F5), size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Find your perfect tutor...',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF0961F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.tune,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _promoCards.length,
            itemBuilder: (context, index) {
              final promo = _promoCards[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2196F3), Color(0xFF673AB7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2196F3).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      promo['title']!,
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      promo['description']!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _promoCards.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? const Color(0xFF0961F5)
                    : Colors.grey.shade300,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// **Popular Tutors Section - Horizontally Scrollable**
  Widget _buildPopularTutorsSection(DashboardState state) {
    if (state.tutors.isEmpty) {
      return const Center(child: Text("No tutors available"));
    }

    final List<TutorEntity> sortedTutors = List.from(state.tutors);
    final List<TutorEntity> topTutors = sortedTutors.take(4).toList();

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: topTutors.length,
        itemBuilder: (context, index) {
          return _buildPopularTutorCard(topTutors[index]);
        },
      ),
    );
  }

  /// **🔥 FIXED Popular Tutor Card - Proper Data Display**
  Widget _buildPopularTutorCard(TutorEntity tutor) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF0961F5).withOpacity(0.1),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(tutor.profileImage),
                    radius: 40,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 45),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Text(
                  tutor.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  tutor.subjects.take(2).join(', '), // ✅ FIXED TEXT DISPLAY
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: Color(0xFFFFC107), size: 20),
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
    );
  }

  Widget _buildTutorList(DashboardState state) {
    final tutorsToShow = state.tutors.take(_loadedTutors).toList();
    return Column(
      children: tutorsToShow.map((tutor) => _buildTutorCard(tutor)).toList(),
    );
  }

  Widget _buildTutorCard(TutorEntity tutor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(tutor.profileImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: -40,
                left: 20,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(tutor.profileImage),
                    radius: 40,
                  ),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFFC107),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        tutor.rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tutor.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '₹${tutor.hourlyRate}₹${tutor.hourlyRate}/hr',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => TutorProfileView(tutor: tutor),
                        //   ),
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0961F5),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'View Profile',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  tutor.bio,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tutor.subjects.take(3).map((subject) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0961F5).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        subject,
                        style: const TextStyle(
                          color: Color(0xFF0961F5),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// **🔥 FIXED Load More Button - Appears Properly**
  Widget _buildLoadMoreButton(DashboardState state) {
    bool shouldShowButton = state.tutors.length > _loadedTutors; // ✅ FIXED

    return shouldShowButton
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _loadedTutors += 10; // ✅ Loads 10 more tutors
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0961F5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(
                      color: Color(0xFF0961F5),
                      width: 2,
                    ),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Load More Tutors',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAllPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        if (onSeeAllPressed != null)
          TextButton(
            onPressed: onSeeAllPressed,
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF0961F5),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCategoryList() {
    final categories = [
      'Physics',
      'Computer Science',
      'Mathematics',
      'Chemistry',
      'Biology',
      'Literature',
    ];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
              right: 12,
              left: index == 0 ? 0 : 0,
            ),
            child: Material(
              color: index == 1
                  ? const Color(0xFF0961F5)
                  : const Color(0xFF0961F5).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color:
                          index == 1 ? Colors.white : const Color(0xFF0961F5),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

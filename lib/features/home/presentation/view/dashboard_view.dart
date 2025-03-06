// import 'package:flutter/material.dart';
// import 'package:tutorme/view/browse_view.dart';
// import 'package:tutorme/view/home_view.dart';
// import 'package:tutorme/view/inbox_view.dart';
// import 'package:tutorme/view/profile_view.dart';
// import 'package:tutorme/view/wallet_view.dart';

// class DashboardView extends StatefulWidget {
//   const DashboardView({super.key});

//   @override
//   State<DashboardView> createState() => _DashboardViewState();
// }

// class _DashboardViewState extends State<DashboardView> {
//   int _currentIndex = 0;

//   // List of screens
//   final List<Widget> _screens = [
//     const HomeScreen(),
//     const BrowseScreen(),
//     const InboxScreen(),
//     const WalletScreen(),
//     const ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfff2fafa),
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: const Color(0xfff2fafa),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // const Text('TutorMe',
//             //     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//             Image.asset(
//               'assets/images/logo.png',
//               height: 30.0,
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications_active,
//                 color: Color.fromARGB(255, 4, 32, 91)),
//             onPressed: () {},
//           )
//         ],
//       ),
//       body: _screens[_currentIndex],
//       bottomNavigationBar: Container(
//         decoration: const BoxDecoration(
//           color: Color.fromARGB(255, 0, 40, 73),
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//         ),
//         child: BottomNavigationBar(
//           backgroundColor: Colors.transparent,
//           selectedItemColor: Colors.blue, // Selected item color
//           unselectedItemColor: Colors.grey, // Unselected item color
//           selectedFontSize: 14,
//           currentIndex: _currentIndex, // Sync the current index
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//           type: BottomNavigationBarType.fixed,
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
//             BottomNavigationBarItem(icon: Icon(Icons.search), label: 'BROWSE'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.mail_outline), label: 'INBOX'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.account_balance_wallet_outlined),
//                 label: 'WALLET'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.person_outline), label: 'PROFILE'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPopularTutorCard(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(right: 16),
//       padding: const EdgeInsets.all(12),
//       width: 350,
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
//           const Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: AssetImage('assets/images/avatar.jpg'),
//                 radius: 30,
//               ),
//               SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Er. Narendra Kunwar',
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                     ),
//                     Text('Machine Learning',
//                         style: TextStyle(color: Colors.grey, fontSize: 12)),
//                   ],
//                 ),
//               ),
//               Column(
//                 children: [
//                   Text(
//                     '4.4',
//                     style: TextStyle(
//                         color: Colors.orange,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16),
//                   ),
//                   Icon(Icons.star, color: Colors.orange, size: 16),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Divider(color: Colors.grey[300]),
//           const SizedBox(height: 8),
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Rate',
//                       style: TextStyle(color: Colors.grey, fontSize: 12)),
//                   Text('Rs. 230/hour',
//                       style: TextStyle(fontWeight: FontWeight.bold)),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Minutes tutored',
//                       style: TextStyle(color: Colors.grey, fontSize: 12)),
//                   Text('4311', style: TextStyle(fontWeight: FontWeight.bold)),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Students',
//                       style: TextStyle(color: Colors.grey, fontSize: 12)),
//                   Text('140', style: TextStyle(fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildRecommendationCard(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       padding: const EdgeInsets.all(12),
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
//           const CircleAvatar(
//             backgroundImage: AssetImage('assets/images/avatar.jpg'),
//             radius: 30,
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Er. Narendra Kunwar',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 const Text('Senior Software Engineer',
//                     style: TextStyle(color: Colors.grey, fontSize: 12)),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     _buildSkillChip('JavaScript'),
//                     const SizedBox(width: 5),
//                     _buildSkillChip('Node.js'),
//                   ],
//                 )
//               ],
//             ),
//           ),
//           const Column(
//             children: [
//               Text('Rate', style: TextStyle(color: Colors.grey)),
//               Text('Rs. 230/hour',
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildSkillChip(String skill) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.blue[100],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Text(
//         skill,
//         style: const TextStyle(
//             fontSize: 12, color: Color.fromARGB(255, 16, 27, 40)),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tutorme/app/di/di.dart';
// import 'package:tutorme/features/booking/presentation/view/student_bookings_view.dart';
// import 'package:tutorme/features/booking/presentation/viewmodel/booking_bloc.dart';
// import 'package:tutorme/features/home/presentation/view/home_view.dart';
// import 'package:tutorme/features/home/presentation/view_model/home_cubit.dart';
// import 'package:tutorme/features/home/presentation/view_model/home_state.dart';
// import 'package:tutorme/features/notifications/presentation/view/notification_view.dart';
// import 'package:tutorme/features/notifications/presentation/view_model/notification_bloc.dart';
// import 'package:tutorme/features/session/presentation/bloc/session_bloc.dart';
// import 'package:tutorme/features/session/presentation/view/sessions_view.dart';
// import 'package:tutorme/features/student/presentation/view/student_profile_view.dart';
// import 'package:tutorme/features/student/presentation/view_model/bloc/student_profile_bloc.dart';
// import 'package:tutorme/features/wallet/presentation/view/wallet_view.dart';
// import 'package:tutorme/features/wallet/presentation/view_model/bloc/wallet_bloc.dart';
// // import 'package:tutorme/view/profile_view.dart';

// class DashboardView extends StatefulWidget {
//   const DashboardView({super.key});

//   @override
//   State<DashboardView> createState() => _DashboardViewState();
// }

// class _DashboardViewState extends State<DashboardView> {
//   int _currentIndex = 0;

//   final List<Widget> _screens = [
//     const HomeScreen(),
//     // const InboxScreen(),
//     // ✅ Wrap WalletScreen with BlocProvider
//     BlocProvider(
//       create: (_) => getIt<BookingBloc>()..add(FetchStudentBookingsEvent()),
//       child: const StudentBookingsView(),
//     ),
//     BlocProvider(
//       create: (_) => getIt<SessionBloc>()..add(FetchStudentSessions()),
//       child: const SessionView(),
//     ),
//     BlocProvider(
//       create: (_) => getIt<WalletBloc>()
//         ..add(FetchWalletDetails()), // 👈 Fetch wallet on navigation
//       child: const WalletView(),
//     ),
//     // const WalletScreen(),
//     // const BrowseScreen(),

//     // const StudentProfileView(),
//     BlocProvider(
//       create: (_) => getIt<NotificationBloc>()
//         ..add(FetchNotificationsEvent()), // 👈 Fetch wallet on navigation
//       child: const NotificationScreen(),
//     ),

//     /// ✅ Wrap `StudentProfileView` with BlocProvider
//     BlocProvider(
//       create: (_) =>
//           getIt<StudentProfileBloc>()..add(const FetchStudentProfile()),
//       child: const StudentProfileView(),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return BlocProvider(
//       create: (_) => getIt<HomeCubit>(), // ✅ Inject HomeCubit
//       child: BlocBuilder<HomeCubit, DashboardState>(
//         builder: (context, state) {
//           return Scaffold(
//             backgroundColor: const Color(0xfff2fafa),
//             // appBar: AppBar(
//             //   automaticallyImplyLeading: false,
//             //   backgroundColor: const Color(0xfff2fafa),
//             //   title: Column(
//             //     crossAxisAlignment: CrossAxisAlignment.start,
//             //     children: [
//             //       Image.asset(
//             //         'assets/images/logo.png',
//             //         height: 30.0,
//             //       ),
//             //     ],
//             //   ),
//             //   actions: [
//             //     IconButton(
//             //       icon: const Icon(Icons.notifications_active,
//             //           color: Color.fromARGB(255, 4, 32, 91)),
//             //       onPressed: () {},
//             //     )
//             //   ],
//             // ),
//             body: _screens[_currentIndex],
//             bottomNavigationBar: _buildBottomNavigationBar(context),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildBottomNavigationBar(BuildContext context) {
//     return ClipRRect(
//       borderRadius: const BorderRadius.only(
//         topLeft: Radius.circular(20),
//         topRight: Radius.circular(20),
//       ),
//       child: BottomNavigationBar(
//         backgroundColor:
//             Theme.of(context).bottomNavigationBarTheme.backgroundColor,
//         selectedItemColor:
//             Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
//         unselectedItemColor:
//             Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
//         selectedFontSize: 14,
//         unselectedFontSize: 12,
//         showUnselectedLabels: false,
//         showSelectedLabels: false,
//         elevation: 0,
//         currentIndex: _currentIndex,
//         type: BottomNavigationBarType.fixed,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//           if (index == 2) {
//             context.read<WalletBloc>().add(FetchWalletDetails());
//           }
//           if (index == 4) {
//             context.read<StudentProfileBloc>().add(const FetchStudentProfile());
//           }
//           context.read<HomeCubit>().selectTab(index);
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: _buildNavIcon(Icons.home, 0),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: _buildNavIcon(Icons.document_scanner, 1),
//             label: "Activity",
//           ),
//           BottomNavigationBarItem(
//             icon: _buildNavIcon(Icons.video_call_rounded, 2),
//             label: "Sessions",
//           ),
//           BottomNavigationBarItem(
//             icon: _buildNavIcon(Icons.account_balance_wallet_outlined, 3),
//             label: "Wallet",
//           ),
//           BottomNavigationBarItem(
//             icon: _buildNavIcon(Icons.notifications, 4),
//             label: "Updates",
//           ),
//           BottomNavigationBarItem(
//             icon: _buildNavIcon(Icons.person_outline, 5),
//             label: "Profile",
//           ),
//         ],
//       ),
//     );
//   }

//   /// 🔹 **Helper Function to Build Animated Icons**
//   Widget _buildNavIcon(IconData icon, int index) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 100),
//       curve: Curves.easeInOut,
//       padding: const EdgeInsets.all(6),
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color:
//             _currentIndex == index ? Colors.blue.shade100 : Colors.transparent,
//       ),
//       child: Icon(
//         icon,
//         size: _currentIndex == index ? 28 : 24, // Slightly larger when selected
//         color: _currentIndex == index ? Colors.blue : Colors.grey,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorme/app/di/di.dart';
import 'package:tutorme/features/booking/presentation/view/student_bookings_view.dart';
import 'package:tutorme/features/booking/presentation/viewmodel/booking_bloc.dart';
import 'package:tutorme/features/home/presentation/view/home_view.dart';
import 'package:tutorme/features/home/presentation/view_model/home_cubit.dart';
import 'package:tutorme/features/home/presentation/view_model/home_state.dart';
import 'package:tutorme/features/notifications/presentation/view/notification_view.dart';
import 'package:tutorme/features/notifications/presentation/view_model/notification_bloc.dart';
import 'package:tutorme/features/session/presentation/bloc/session_bloc.dart';
import 'package:tutorme/features/session/presentation/view/sessions_view.dart';
import 'package:tutorme/features/student/presentation/view/student_profile_view.dart';
import 'package:tutorme/features/student/presentation/view_model/bloc/student_profile_bloc.dart';
import 'package:tutorme/features/wallet/presentation/view/wallet_view.dart';
import 'package:tutorme/features/wallet/presentation/view_model/bloc/wallet_bloc.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;

  // Define icons for both states
  final List<IconData> _icons = [
    Icons.home_rounded,
    Icons.document_scanner_rounded,
    Icons.video_call_rounded,
    Icons.account_balance_wallet_rounded,
    Icons.notifications_rounded,
    Icons.person_rounded,
  ];

  final List<String> _labels = [
    "Home",
    "Bookings",
    "Sessions",
    "Wallet",
    "Notifications",
    "Profile",
  ];

  final List<Widget> _screens = [
    const HomeScreen(),
    BlocProvider(
      create: (_) => getIt<BookingBloc>()..add(FetchStudentBookingsEvent()),
      child: const StudentBookingsView(),
    ),
    BlocProvider(
      create: (_) => getIt<SessionBloc>()..add(FetchStudentSessions()),
      child: const SessionView(),
    ),
    BlocProvider(
      create: (_) => getIt<WalletBloc>()..add(FetchWalletDetails()),
      child: const WalletView(),
    ),
    BlocProvider(
      create: (_) => getIt<NotificationBloc>()..add(FetchNotificationsEvent()),
      child: const NotificationScreen(),
    ),
    BlocProvider(
      create: (_) =>
          getIt<StudentProfileBloc>()..add(const FetchStudentProfile()),
      child: const StudentProfileView(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check if dark mode is enabled
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return BlocProvider(
      create: (_) => getIt<HomeCubit>(),
      child: BlocBuilder<HomeCubit, DashboardState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: _screens[_currentIndex],
            bottomNavigationBar:
                _buildModernNavigationBar(context, isDarkMode, primaryColor),
          );
        },
      ),
    );
  }

  Widget _buildModernNavigationBar(
      BuildContext context, bool isDarkMode, Color primaryColor) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF202020) : Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_icons.length, (index) {
          // Create a focused animation for each item
          final isSelected = _currentIndex == index;

          return GestureDetector(
            onTap: () => _onItemTapped(index, context),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDarkMode
                        ? primaryColor.withOpacity(0.15)
                        : primaryColor.withOpacity(0.1))
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _icons[index],
                    color: isSelected
                        ? primaryColor
                        : (isDarkMode
                            ? Colors.grey.shade400
                            : Colors.grey.shade600),
                    size: isSelected ? 26 : 22,
                  ),
                  if (isSelected) const SizedBox(height: 4),
                  if (isSelected)
                    Text(
                      _labels[index],
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });

      // Trigger appropriate data loading based on the selected tab
      if (index == 1) {
        context.read<BookingBloc>().add(FetchStudentBookingsEvent());
      } else if (index == 2) {
        context.read<SessionBloc>().add(FetchStudentSessions());
      } else if (index == 3) {
        context.read<WalletBloc>().add(FetchWalletDetails());
      } else if (index == 4) {
        context.read<NotificationBloc>().add(FetchNotificationsEvent());
      } else if (index == 5) {
        context.read<StudentProfileBloc>().add(const FetchStudentProfile());
      }

      // Update the selected tab in the HomeCubit
      context.read<HomeCubit>().selectTab(index);

      // Reset animation for a nice effect
      _animationController.reset();
      _animationController.forward();
    }
  }
}

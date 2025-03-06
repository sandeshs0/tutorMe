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

      context.read<HomeCubit>().selectTab(index);

      _animationController.reset();
      _animationController.forward();
    }
  }
}

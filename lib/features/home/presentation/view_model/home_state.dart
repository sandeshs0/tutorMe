import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tutorme/view/home_view.dart';
import 'package:tutorme/view/browse_view.dart';
import 'package:tutorme/view/inbox_view.dart';
import 'package:tutorme/view/profile_view.dart';
import 'package:tutorme/view/wallet_view.dart';

// State class
class DashboardState extends Equatable {
  final int currentIndex;
  final List<Widget> screens;

  const DashboardState({
    required this.currentIndex,
    required this.screens,
  });

  // Initial state
  static DashboardState initial() {
    return const DashboardState(
      currentIndex: 0,
      screens: [
        HomeScreen(),
        BrowseScreen(),
        InboxScreen(),
        WalletScreen(),
        ProfileScreen(),
      ],
    );
  }

  // Copy state with changes
  DashboardState copyWith({
    int? currentIndex,
    List<Widget>? screens,
  }) {
    return DashboardState(
      currentIndex: currentIndex ?? this.currentIndex,
      screens: screens ?? this.screens,
    );
  }

  @override
  List<Object?> get props => [currentIndex, screens];
}

// Cubit class
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState.initial());

  void changeTab(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}

// Then, in your DashboardView widget, use BlocProvider to provide the DashboardCubit:
class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit(),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xfff5f8ff),
            // Your existing AppBar, Body and other widgets...
            body: state.screens[state.currentIndex],
            bottomNavigationBar: buildBottomNavigationBar(state),
          );
        },
      ),
    );
  }

  Widget buildBottomNavigationBar(DashboardState state) {
    return BottomNavigationBar(
      currentIndex: state.currentIndex,
      onTap: (index) => context.read<DashboardCubit>().changeTab(index),
      // BottomNavigationBar items
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'BROWSE'),
        BottomNavigationBarItem(icon: Icon(Icons.mail_outline), label: 'INBOX'),
        BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'WALLET'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'PROFILE'),
      ],
    );
  }
}

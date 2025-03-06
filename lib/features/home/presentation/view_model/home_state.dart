import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tutorme/features/booking/presentation/view/student_bookings_view.dart';
import 'package:tutorme/features/home/presentation/view/home_view.dart';
import 'package:tutorme/features/session/presentation/view/sessions_view.dart';
import 'package:tutorme/features/student/presentation/view/student_profile_view.dart';
import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';
import 'package:tutorme/features/wallet/presentation/view/wallet_view.dart';

class DashboardState extends Equatable {
  final int currentIndex;
  final List<Widget> screens;
  final bool isLoading;
  final List<TutorEntity> tutors;
  final String? errorMessage;

  const DashboardState({
    required this.currentIndex,
    required this.screens,
    this.isLoading = false,
    this.tutors = const [],
    this.errorMessage,
  });

  static DashboardState initial() {
    return const DashboardState(
      currentIndex: 0,
      screens: [
        HomeScreen(),
        WalletView(),
        SessionView(),
        StudentBookingsView(),
        StudentProfileView(),
      ],
    );
  }

  DashboardState copyWith({
    int? currentIndex,
    List<Widget>? screens,
    bool? isLoading,
    List<TutorEntity>? tutors,
    String? errorMessage,
  }) {
    return DashboardState(
      currentIndex: currentIndex ?? this.currentIndex,
      screens: screens ?? this.screens,
      isLoading: isLoading ?? this.isLoading,
      tutors: tutors ?? this.tutors,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [currentIndex, screens, isLoading, tutors, errorMessage];
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorme/app/di/di.dart';
import 'package:tutorme/bloc/theme_cubit.dart';
import 'package:tutorme/bloc/tutor_bloc.dart';
import 'package:tutorme/core/app_theme/app_theme.dart';
import 'package:tutorme/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:tutorme/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:tutorme/features/booking/presentation/viewmodel/booking_bloc.dart';
import 'package:tutorme/features/home/presentation/view_model/home_cubit.dart';
import 'package:tutorme/features/notifications/presentation/view_model/notification_bloc.dart';
import 'package:tutorme/features/student/presentation/view_model/bloc/student_profile_bloc.dart';
import 'package:tutorme/features/wallet/presentation/view_model/bloc/wallet_bloc.dart';
import 'package:tutorme/view/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: const SplashScreen(),
    //   theme: getApplicationTheme(),
    // );

    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (_) => getIt<LoginBloc>(),
          ),
          BlocProvider<RegisterBloc>(
            create: (_) => getIt<RegisterBloc>(),
          ),
          BlocProvider<TutorBloc>(
            create: (_) => getIt<TutorBloc>(),
          ),
          BlocProvider<StudentProfileBloc>(
            create: (_) => getIt<StudentProfileBloc>(),
          ),
          BlocProvider<WalletBloc>(
            create: (_) => getIt<WalletBloc>(),
          ),
          BlocProvider<NotificationBloc>(
            create: (_) => getIt<NotificationBloc>(),
          ),
          BlocProvider<BookingBloc>(
            create: (_) => getIt<BookingBloc>(),
          ),
          BlocProvider<HomeCubit>(
            create: (_) => getIt<HomeCubit>(),
          ),
          BlocProvider<ThemeCubit>(
              create: (_) => getIt<ThemeCubit>()), // ✅ Register ThemeCubit
        ],
        child: Builder(builder: (context) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              debugPrint("🎨 ThemeMode Updated: $themeMode");
              return MaterialApp(
                title: 'TutorMe',
                // theme: ThemeData(primaryColor: const Color(0xFF0961F5)),
                theme: getApplicationTheme(),
                darkTheme: getDarkTheme(),
                home: const SplashScreen(),
                themeMode: themeMode,
                debugShowCheckedModeBanner: false,
              );
            },
          );
        }));
  }
}

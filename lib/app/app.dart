import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorme/app/di/di.dart';
import 'package:tutorme/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:tutorme/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:tutorme/features/home/presentation/view_model/home_cubit.dart';
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
          BlocProvider<HomeCubit>(
            create: (_) => getIt<HomeCubit>(),
          ),
        ],
        child: MaterialApp(
          title: 'TutorMe',
          theme: ThemeData(
            primaryColor: Colors.blue,
          ),
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        ));
  }
}

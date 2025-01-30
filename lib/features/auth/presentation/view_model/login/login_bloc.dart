import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorme/app/di/di.dart';
import 'package:tutorme/features/auth/domain/use_case/login_usecase.dart';
import 'package:tutorme/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:tutorme/features/home/presentation/view_model/home_cubit.dart';
import 'package:tutorme/features/home/presentation/view_model/home_state.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase _loginUseCase;

  LoginBloc({required LoginUsecase loginUseCase, required HomeCubit homeCubit})
      : _loginUseCase = loginUseCase,
        super(LoginState.initial()) {
    // Handle Login Event
    on<LoginUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final result = await _loginUseCase(
        LoginParams(
          email: event.email,
          password: event.password,
        ),
      );

      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, isSuccess: false));
          ScaffoldMessenger.of(event.context).showSnackBar(
            const SnackBar(
              content: Text('Invalid Credentials'),
              backgroundColor: Colors.red,
            ),
          );
        },
        (token) {
          emit(state.copyWith(isLoading: false, isSuccess: true));
          Navigator.pushReplacement(
            event.context,
            MaterialPageRoute(
              builder: (context) => const DashboardView(),
            ),
          );
          ScaffoldMessenger.of(event.context).showSnackBar(
            const SnackBar(
              content: Text('Login Successful'),
              backgroundColor: Color.fromARGB(255, 63, 149, 10),
            ),
          );
        },
      );
    });

    // Handle Navigation to Register Screen
    on<NavigateRegisterScreenEvent>((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<RegisterBloc>(),
            child: event.destination,
          ),
        ),
      );
    });
  }
}

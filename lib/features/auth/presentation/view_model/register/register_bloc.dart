import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tutorme/core/common/snackbar/app_snackbar.dart';
import 'package:tutorme/features/auth/domain/use_case/register_usecase.dart';
import 'package:tutorme/features/auth/presentation/view/login_view.dart';
import 'package:tutorme/features/auth/presentation/view_model/register/register_state.dart';

part 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUsecase _registerUsecase;

  RegisterBloc({required RegisterUsecase registerUseCase})
      : _registerUsecase = registerUseCase,
        super(RegisterState.initial()) {
    on<RegisterUserEvent>(_onRegisterUser);
  }

  Future<void> _onRegisterUser(
    RegisterUserEvent event,
    Emitter<RegisterState> emit,
  ) async {
    if (event.password != event.confirmPassword) {
      emit(state.copyWith(errorMessage: "Passwords do not match"));
      showMySnackBar(
        context: event.context,
        message: "Passwords do not match",
        color: Colors.red,
      );
      return;
    }
    emit(state.copyWith(isLoading: true));
    final result = await _registerUsecase.call(
      RegisterUserParams(
        fullName: event.fullName,
        email: event.email,
        phone: event.fullName,
        password: event.password,
        profileImage: event.file.path,
        role: event.role,
      ),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: failure.message,
        ));
        showMySnackBar(
            context: event.context,
            message: failure.message ?? "Registration Failed",
            color: Colors.red);
      },
      (success) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: "Registration successful!",
          color: Colors.green,
        );
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      },
    );
  }
}

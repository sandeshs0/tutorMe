import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tutorme/core/common/snackbar/app_snackbar.dart';
import 'package:tutorme/features/auth/domain/use_case/register_usecase.dart';
import 'package:tutorme/features/auth/domain/use_case/verify_usecase.dart';
import 'package:tutorme/features/auth/presentation/view/login_view.dart';
import 'package:tutorme/features/auth/presentation/view/verify_view.dart';
import 'package:tutorme/features/auth/presentation/view_model/register/register_state.dart';

part 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUsecase _registerUsecase;
  final VerifyEmailUsecase _verifyEmailUsecase;

  RegisterBloc({
    required RegisterUsecase registerUseCase,
    required VerifyEmailUsecase verifyEmailUsecase,
  })  : _registerUsecase = registerUseCase,
        _verifyEmailUsecase = verifyEmailUsecase,
        super(RegisterState.initial()) {
    on<RegisterUserEvent>(_onRegisterUser);
    on<VerifyOtpEvent>(_onVerifyOtp);
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
        username: event.username,
        email: event.email,
        phone: event.phone,
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
          message: "Please Verify your Email!",
          color: const Color.fromARGB(255, 18, 73, 168),
        );
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => OtpVerificationView(
              email: event.email,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _verifyEmailUsecase.call(
      VerifyEmailParams(email: event.email, otp: event.otp),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          isOtpVerified: false,
          errorMessage: failure.message,
        ));
        ScaffoldMessenger.of(event.context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        );
      },
      (success) {
        emit(state.copyWith(
          isLoading: false,
          isOtpVerified: true,
        ));
        ScaffoldMessenger.of(event.context).showSnackBar(
          const SnackBar(content: Text("OTP Verified! Registration Complete!")),
        );
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
    );
  }
}

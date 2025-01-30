import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  final bool isOtpSent;
  final bool isOtpVerified;

  const RegisterState({
    required this.isLoading,
    required this.isSuccess,
    required this.errorMessage,
    required this.isOtpSent,
    required this.isOtpVerified,
  });

  factory RegisterState.initial() {
    return const RegisterState(
      isLoading: false,
      isSuccess: false,
      errorMessage: '',
      isOtpSent: false,
      isOtpVerified: false,
    );
  }

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
        bool? isOtpSent,
    bool? isOtpVerified,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
         isOtpSent: isOtpSent ?? this.isOtpSent,
      isOtpVerified: isOtpVerified ?? this.isOtpVerified,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage, isOtpSent, isOtpVerified];
}

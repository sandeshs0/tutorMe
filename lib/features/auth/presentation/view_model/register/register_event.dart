part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserEvent extends RegisterEvent {
  final BuildContext context;
  final String fullName;
  final String email;
  final String phone;
  final String role;
  final String username;
  final String password;
  final String confirmPassword;
  final File file;

  const RegisterUserEvent({
    required this.context,
    required this.fullName,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
    required this.role,
    required this.file,
  });

  @override
  List<Object> get props => [
        fullName,
        email,
        username,
        phone,
        password,
        confirmPassword,
        role,
        file,
      ];
}

class VerifyOtpEvent extends RegisterEvent {
  final BuildContext context;
  final String email;
  final String otp;

  const VerifyOtpEvent(
      {required this.context, required this.email, required this.otp});

  @override
  List<Object> get props => [email, otp];
}

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
  final String password;
  final String confirmPassword;

  const RegisterUserEvent({
    required this.context,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [fullName, email, phone, password, confirmPassword];
}

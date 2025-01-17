import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable{
  final String? id;
  final String fullName;
  final String email;
  final String phone;
  final String password;

  const AuthEntity({
    this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
  });
  
  @override
  List<Object?> get props => [id,fullName,email, phone, password];
}
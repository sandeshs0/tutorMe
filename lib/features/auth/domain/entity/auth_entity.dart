import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String fullName;
  final String username;
  final String email;
  final String phone;
  final String password;
  final String role;
  final String? profileImage;

  const AuthEntity(
      {this.id,
      required this.fullName,
      required this.username,
      required this.email,
      required this.phone,
      required this.password,
      required this.profileImage,
      required this.role});

  const AuthEntity.empty()
      : id = '',
        fullName = '',
        username = '',
        email = '',
        phone = '',
        password = '',
        profileImage = '',
        role = '';

  @override
  List<Object?> get props =>
      [id, fullName, username, email, phone, password, role, profileImage];
}

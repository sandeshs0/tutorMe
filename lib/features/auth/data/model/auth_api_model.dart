import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tutorme/features/auth/domain/entity/auth_entity.dart';
part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String? password;
  final String? profileImage;
  final String role;

  const AuthApiModel({
    this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.password,
    required this.role,
  });
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

//   To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      fullName: name,
      username: username,
      email: email,
      phone: phone,
      role: role,
      profileImage: profileImage,
      password: password ?? '',
    );
  }

  // From ENtity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
        name: entity.fullName,
        username: entity.username,
        email: entity.email,
        phone: entity.phone,
        profileImage: entity.profileImage,
        password: entity.password,
        role: entity.role);
  }

  @override
  List<Object?> get props =>
      [id, name, email, phone, profileImage, role, password];
}

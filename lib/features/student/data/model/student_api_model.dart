import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tutorme/features/student/domain/entity/student_entity.dart';

part 'student_api_model.g.dart';

@JsonSerializable()
class StudentApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? studentId;
  final String name;
  final String email;
  final String phone;
  final String? profileImage;
  final String role;
  final double walletBalance;

  const StudentApiModel({
    this.studentId,
    required this.name,
    required this.email,
    required this.phone,
     this.profileImage,
    required this.role,
    required this.walletBalance,
  });

  factory StudentApiModel.fromJson(Map<String, dynamic> json) =>
      _$StudentApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentApiModelToJson(this);

  StudentEntity toEntity() {
    return StudentEntity(
      studentId: studentId,
      name: name,
      email: email,
      phone: phone,
      profileImage: profileImage ?? "",
      role: role,
      walletBalance: walletBalance,
    );
  }

  factory StudentApiModel.fromEntity(StudentEntity entity) {
    return StudentApiModel(
      studentId: entity.studentId,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      profileImage: entity.profileImage,
      role: entity.role,
      walletBalance: entity.walletBalance,
    );
  }

  @override
  List<Object?> get props => [
        studentId,
        name,
        email,
        phone,
        profileImage,
        role,
        walletBalance,
      ];
}

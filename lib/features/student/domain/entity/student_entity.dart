class StudentEntity {
  final String? studentId;
  final String name;
  final String email;
  final String phone;
  final String profileImage;
  final String role;
  final double walletBalance;

  const StudentEntity({
     this.studentId,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.role,
    required this.walletBalance,
  });
}

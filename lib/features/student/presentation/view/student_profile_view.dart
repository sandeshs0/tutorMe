import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorme/features/student/domain/entity/student_entity.dart';
import 'package:tutorme/features/student/presentation/view/edit_profile_view.dart';
import 'package:tutorme/features/student/presentation/view/terms_view.dart';
import 'package:tutorme/features/student/presentation/view_model/bloc/student_profile_bloc.dart';

class StudentProfileView extends StatelessWidget {
  const StudentProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',
            style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: BlocConsumer<StudentProfileBloc, StudentProfileState>(
        listener: (context, state) {
          if (state is StudentProfileUpdated) {
            // ✅ Show toast for success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Profile updated successfully!"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 5), // Ensure it stays long enough
              ),
            );

            // ✅ Delay fetching profile to prevent overriding the success toast immediately
            Future.delayed(const Duration(seconds: 2), () {
              context
                  .read<StudentProfileBloc>()
                  .add(const FetchStudentProfile());
            });
          }
        },
        builder: (context, state) {
          if (state is StudentProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StudentProfileLoaded ||
              state is StudentProfileUpdated) {
            final student = state is StudentProfileLoaded
                ? state.student
                : (state as StudentProfileUpdated).student;

            return _buildProfileContent(student, context);
          } else if (state is StudentProfileError) {
            return Center(
              child: Text(state.message,
                  style: const TextStyle(color: Colors.red, fontSize: 16)),
            );
          }
          return const Center(
              child: Text("No profile data available.",
                  style: TextStyle(fontSize: 16)));
        },
      ),
    );
  }

  Widget _buildProfileContent(StudentEntity student, BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🟢 Profile Image with Edit Button and Border
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.blueGrey, width: 3), // 🟢 Added outline
                  ),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: theme.dividerColor,
                    backgroundImage: _getImageProvider(student.profileImage),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 🟢 Name
            Text(
              student.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),

            // 🟢 Email
            Text(
              student.email,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // 🟢 Wallet Balance Card
            _buildWalletBalanceCard(student.walletBalance, theme),
            const SizedBox(height: 24),

            // 🟢 Profile Options
            _buildProfileOption(Icons.edit, "Edit Profile", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditStudentProfileView(student: student),
                ),
              ).then((_) {
                // ✅ Refresh the profile when returning from Edit Profile
                context
                    .read<StudentProfileBloc>()
                    .add(const FetchStudentProfile());
              });
            }),
            _buildProfileOption(Icons.notifications, "Notifications", () {
              // TODO: Implement Notifications
            }),
            _buildProfileOption(Icons.dark_mode, "Dark Mode", () {
              // TODO: Implement Dark Mode Toggle
            }),
            _buildProfileOption(Icons.security, "Terms & Conditions", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TermsConditionsView()),
              );
            }),

            const SizedBox(height: 10),

            // 🟢 Logout Button (Subtle)
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  ImageProvider _getImageProvider(String imagePath) {
    if (imagePath.startsWith('http')) {
      return NetworkImage(imagePath);
    } else {
      return AssetImage(imagePath);
    }
  }

  Widget _buildWalletBalanceCard(double balance, ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            "Wallet Balance",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            "Rs. ${balance.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Logout functionality coming soon!")),
        );
      },
      icon: const Icon(Icons.logout, size: 18, color: Colors.redAccent),
      label: const Text(
        "Logout",
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.redAccent),
      ),
    );
  }
}

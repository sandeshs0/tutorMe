import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorme/features/student/domain/entity/student_entity.dart';
import 'package:tutorme/features/student/presentation/view_model/bloc/student_profile_bloc.dart';

class StudentProfileView extends StatelessWidget {
  const StudentProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: BlocBuilder<StudentProfileBloc, StudentProfileState>(
        builder: (context, state) {
          if (state is StudentProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StudentProfileLoaded) {
            return _buildProfileContent(state.student, context);
          } else if (state is StudentProfileError) {
            return Center(
                child: Text(state.message,
                    style: const TextStyle(color: Colors.red)));
          }
          return const Center(child: Text("No profaile data available."));
        },
      ),
    );
  }

  Widget _buildProfileContent(StudentEntity student, BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🟢 Profile Image
          CircleAvatar(
            radius: 60,
            backgroundColor: theme.dividerColor,
            backgroundImage: NetworkImage(student.profileImage),
          ),
          const SizedBox(height: 16),

          // 🟢 Name
          Text(
            student.name,
            // style: theme.textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // 🟢 Email & Phone
          Text(
            student.email,
            // style: theme.textTheme.bodyText2?.copyWith(color: Colors.grey[700]),
          ),
          const SizedBox(height: 4),
          Text(
            student.phone,
            // style: theme.textTheme.bodyText2?.copyWith(color: Colors.grey[700]),
          ),
          const SizedBox(height: 16),

          // 🟢 Wallet Balance
          _buildWalletBalanceCard(student.walletBalance, theme),

          const SizedBox(height: 24),

          // 🟢 Logout Button
          _buildLogoutButton(context),
        ],
      ),
    );
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
          const Text("Wallet Balance",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(
            "₹$balance",
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

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // TODO: Implement logout logic
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Logout functionality coming soon!")),
        );
      },
      icon: const Icon(Icons.logout),
      label: const Text("Logout"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

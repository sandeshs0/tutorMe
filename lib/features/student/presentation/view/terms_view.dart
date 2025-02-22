import 'package:flutter/material.dart';

class TermsConditionsView extends StatelessWidget {
  const TermsConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Conditions",
            style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("1. Introduction"),
            _buildSectionContent(
              "Welcome to TutorMe! By accessing and using our platform, you agree to abide by the following terms and conditions. Please read them carefully.",
            ),
            _buildSectionTitle("2. User Accounts"),
            _buildSectionContent(
              "To access our services, you must create an account. You are responsible for maintaining the confidentiality of your account credentials. Any activity under your account is your responsibility.",
            ),
            _buildSectionTitle("3. Tutor and Student Responsibilities"),
            _buildSectionContent(
              "Tutors must provide accurate information and conduct sessions professionally. Students must adhere to scheduled sessions and behave respectfully. Any violation may result in account suspension.",
            ),
            _buildSectionTitle("4. Payment & Refund Policy"),
            _buildSectionContent(
              "Payments for tutoring sessions must be completed before the session starts. Refunds are only applicable if a tutor fails to conduct a session without prior notice.",
            ),
            _buildSectionTitle("5. Privacy & Data Security"),
            _buildSectionContent(
              "We prioritize your privacy and protect your data. By using TutorMe, you consent to our data collection practices as outlined in our Privacy Policy.",
            ),
            _buildSectionTitle("6. Prohibited Activities"),
            _buildSectionContent(
              "Users must not engage in fraudulent activities, abusive behavior, or any form of harassment. Violations may result in a permanent ban from our platform.",
            ),
            _buildSectionTitle("7. Changes to Terms"),
            _buildSectionContent(
              "We reserve the right to update these terms at any time. Continued use of our platform after changes indicates acceptance of the new terms.",
            ),
            _buildSectionTitle("8. Contact Us"),
            _buildSectionContent(
              "For any questions or concerns, please contact our support team at support@tutorme.com.",
            ),
            const SizedBox(height: 20),
            _buildCloseButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          "Close",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ),
    );
  }
}

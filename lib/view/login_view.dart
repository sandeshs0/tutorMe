import 'package:flutter/material.dart';
import 'package:tutorme/view/dashboard_view.dart';
import 'package:tutorme/view/signup_view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 249, 255, 1),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: isTablet
                      ? 80.0
                      : 50.0, // Adjusted logo size for responsiveness
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Login with your account!',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Kick start your learning journey with an account',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color.fromARGB(255, 61, 26, 26),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50.0),

              // Username Field
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              const SizedBox(height: 19.0),

              // Password Field
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: const Icon(Icons.visibility),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              const SizedBox(height: 28.0),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  // Handle login
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashboardView()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: isTablet ? 20.0 : 16.0),
                  minimumSize: Size(double.infinity, isTablet ? 60 : 50),
                  backgroundColor: const Color.fromARGB(255, 0, 94, 255),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Sign Up Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      // Navigate to sign up screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupView()),
                      );
                    },
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

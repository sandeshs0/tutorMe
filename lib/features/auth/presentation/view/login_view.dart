import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorme/features/auth/presentation/view/signup_view.dart';
import 'package:tutorme/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:tutorme/features/home/presentation/view/dashboard_view.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey =
      GlobalKey<FormState>(); 
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible =
      false; 
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 249, 255, 1),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isLoading) {
            // Ideally show a loading indicator
          } else if (state.isSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardView(),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Invalid Credentials'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: isTablet ? 80.0 : 50.0,
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

                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^\S+@\S+\.\S+$').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 19.0),

                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            _isPasswordVisible = !_isPasswordVisible;
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 28.0),

                    // Login Button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print("Inside button");
                          context.read<LoginBloc>().add(
                                LoginUserEvent(
                                  context: context,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: isTablet ? 20.0 : 16.0),
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
        },
      ),
    );
  }
}

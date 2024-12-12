import 'package:flutter/material.dart';
import 'package:tutorme/view/login_view.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FF),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50.0),
                const Text(
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 30.0,
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
        
                // Email Field
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(height: 19.0),
        
                // Phone Number Field
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(height: 19.0),
        
                // Gender Field
                // Gender Dropdown

DropdownButtonFormField<String>(
  // value: selectedGender,
  decoration: InputDecoration(
    labelText: 'Gender',
    prefixIcon: const Icon(Icons.person_outline),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
  ),
  items: ['Male', 'Female',"Others"]

      .map((gender) => DropdownMenuItem<String>(
            value: gender,
            child: Text(gender),
          ))
      .toList(),
  onChanged: (value) {
    // selectedGender = value;
  },
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
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(height: 19.0),
        
                // Confirm Password Field
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: const Icon(Icons.visibility),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(height: 28.0),
        
                // Signup Button
                ElevatedButton(
                  onPressed: () {
                    // Handle signup
                      // Handle login
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: const Color.fromARGB(255, 0, 94, 255),
                  ),
                  child: const Text(
                    'Signup',
                    style: TextStyle(fontSize: 20.0, color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
                const SizedBox(height: 16.0),
        
                // Login Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        // Navigate to login screen
                      },
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
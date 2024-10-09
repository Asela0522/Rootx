import 'package:flutter/material.dart';
import 'package:test1/Passenger/screens/login.dart';
import 'package:test1/Passenger/API/api/signup_api.dart'; // Import the backend API file

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Controllers to manage text input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key for validation

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        SizedBox(height: 40), // Space before avatar
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/images/passenger.png'), // Replace with your image
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30), // Space between avatar and form

              // Sign up form
              Form(
                key: _formKey, // Wrap the form in a Form widget
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Email field with validation
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress, // Restrict to email input
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          // Optional: Additional email format validation can be added here
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      // Username field with validation
                      TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: 'UserName',
                          prefixIcon: const Icon(Icons.person), // Updated icon
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      // Phone number field with validation
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone No',
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.phone, // Restrict to phone input
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Please enter valid numbers';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      // Password field with validation
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      // Confirm Password field with validation
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Create Account Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) { // Validate the form
                              String email = emailController.text;
                              String username = usernameController.text;
                              String phone = phoneController.text;
                              String password = passwordController.text;
                              String confirmPassword = confirmPasswordController.text;

                              // Call the API to register the user
                              String response = await SignUpAPI.registerPassenger(
                                email, username, phone, password, confirmPassword,
                              );

                              // Show the result to the user
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(response)),
                              );
                            } else {
                              // Show a generic error message if validation fails
                              _showErrorDialog('Please fill all fields correctly.');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Create an Account",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Already have an account? Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an Account? ",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage1()), // Navigate to loginPage1
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold),
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

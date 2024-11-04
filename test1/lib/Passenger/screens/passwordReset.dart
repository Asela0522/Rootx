import 'package:flutter/material.dart';
import 'package:test1/Passenger/API/api/password_reset_api.dart'; // Import the backend API file
import 'package:email_validator/email_validator.dart'; // Import email validator package

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final PasswordResetAPI _passwordResetAPI = PasswordResetAPI();

  // Method to show error in an AlertDialog
  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _resetPassword() async {
    final email = _emailController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Validate that all fields are filled
    if (email.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      _showErrorDialog("Please fill all fields");
      return;
    }

    // Validate the email format
    if (!EmailValidator.validate(email)) {
      _showErrorDialog("Please enter a valid email address");
      return;
    }

    // Validate that passwords match
    if (newPassword != confirmPassword) {
      _showErrorDialog("Passwords do not match");
      return;
    }

    // Call the password reset API
    bool success = await _passwordResetAPI.resetPassword(email, newPassword);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password reset successfully")),
      );
      Navigator.pushNamed(context, '/login');
    } else {
      _showErrorDialog("Failed to reset password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top section with avatar and background
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(50)),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/images/passenger.png'), // Replace with your asset
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Reset Password Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reset Your Password',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Email TextField
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'demo@gmail.com',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),

                  // New Password TextField
                  TextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password TextField
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password Reset Button
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _resetPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text('Password Reset',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

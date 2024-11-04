import 'package:flutter/material.dart';
import 'package:test1/Passenger/API/api/login_api.dart'; // Import the backend API file
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class LoginPage1 extends StatefulWidget {
  const LoginPage1({super.key});

  @override
  _LoginPage1State createState() {
    return _LoginPage1State();
  }
}

class _LoginPage1State extends State<LoginPage1> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginAPI _loginAPI =
      LoginAPI('http://10.11.3.159:5000'); // Your Flask API URL

  bool _rememberMe = false; // Initialize "Remember Me" state

  @override
  void initState() {
    super.initState();
    _loadRememberedCredentials(); // Load saved credentials
  }

  Future<void> _loadRememberedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('rememberMe') ?? false;
      if (_rememberMe) {
        _emailController.text = prefs.getString('email') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  Future<void> _saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('email', _emailController.text);
      await prefs.setString('password', _passwordController.text);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
    }
    await prefs.setBool('rememberMe', _rememberMe);
  }

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showDialog('Error', 'Please fill in both fields.');
      return;
    }

    try {
      String message = await _loginAPI.login(email, password);
      await _saveCredentials(); // Save credentials if "Remember Me" is checked
      _showDialog('Success', message, isSuccess: true);
    } catch (error) {
      _showDialog('Error', error.toString());
    }
  }

  void _showDialog(String title, String content, {bool isSuccess = false}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (isSuccess) {
                Navigator.pushNamed(context, '/Login_Home_Screen');
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _forgotPassword() {
    Navigator.pushNamed(context, '/password reset');
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
                    backgroundImage: AssetImage('assets/images/passenger.png'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Login Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Email TextField
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'demo@gmail.com',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password TextField
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Remember Me Checkbox and Forgot Password Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (bool? value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                          ),
                          const Text("Remember Me"),
                        ],
                      ),
                      TextButton(
                        onPressed: _forgotPassword,
                        child: const Text("Forgot Password?"),
                      ),
                    ],
                  ),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child:
                          const Text('Login', style: TextStyle(fontSize: 18)),
                    ),
                  ),

                  // Sign Up Section
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don’t have an Account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/sign up');
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

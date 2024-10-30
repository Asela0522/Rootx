import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpAPI {
  // Base URL of your Flask backend
  static const String baseUrl = 'http://10.11.3.159:5000';

  // Function to handle passenger registration
  static Future<String> registerPassenger(String email, String username, String phone, String password, String confirmPassword) async {
    final url = Uri.parse('$baseUrl/passenger_signup');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'username': username,
          'phone': phone,
          'password': password,
          'confirm_password': confirmPassword,
        }),
      );

      if (response.statusCode == 201) {
        // Registration successful
        return 'Passenger registered successfully';
      } else {
        // Registration failed
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        return 'Error: ${errorResponse['error']}';
      }
    } catch (e) {
      // Handle error
      return 'Error: Failed to connect to the server';
    }
  }
}

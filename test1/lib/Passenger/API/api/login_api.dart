import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginAPI {
  final String baseUrl;

  LoginAPI(this.baseUrl);

  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/passenger_signin'), // Ensure you are hitting the correct endpoint
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    // Check the response status code
    if (response.statusCode == 200) {
      // Parse the response and return the message
      final data = jsonDecode(response.body);
      return data['message']; // Adjust based on your API response structure
    } else {
      // Handle errors based on status codes
      if (response.statusCode == 400) {
        throw Exception('Invalid input: ${response.body}');
      } else if (response.statusCode == 404) {
        throw Exception('User not found: ${response.body}');
      } else if (response.statusCode == 401) {
        throw Exception('Invalid password: ${response.body}');
      } else {
        throw Exception('Failed to login: ${response.statusCode} ${response.body}');
      }
    }
  }
}

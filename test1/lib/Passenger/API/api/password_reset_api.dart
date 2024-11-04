import 'dart:convert';
import 'package:http/http.dart' as http;

class PasswordResetAPI {
  // Method to call the reset password API
  Future<bool> resetPassword(String email, String newPassword) async {
    const url =
        'http://10.11.3.159:5000/passenger_reset_password'; // Replace with your backend URL

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'email': email,
          'new_password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}

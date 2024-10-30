import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.11.3.159:5000'; // Replace with your Flask API URL

  // Fetch the "from" locations from the backend API
  static Future<List<String>?> fetchFromLocations() async {
    try {
      final url = Uri.parse('$baseUrl/fromLocations');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return List<String>.from(jsonDecode(response.body));
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  // Fetch the "to" locations from the backend API
  static Future<List<String>?> fetchToLocations() async {
    try {
      final url = Uri.parse('$baseUrl/toLocations');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return List<String>.from(jsonDecode(response.body));
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  // Search for buses based on the selected locations and date
  static Future<List<Map<String, dynamic>>?> searchBus({
    required String from,
    required String to,
    required DateTime date,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/buses_information?from=$from&to=$to&date=${date.toIso8601String()}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }
}

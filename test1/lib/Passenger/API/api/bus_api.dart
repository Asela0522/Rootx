import 'dart:convert';
import 'package:http/http.dart' as http;

class BusApi {
  static const String apiUrl = 'http://10.11.3.159:5000/buses';  // Replace with your Flask API endpoint

  // Fetch bus data from the API
  static Future<List<dynamic>> getBusInformation() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load bus data');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}

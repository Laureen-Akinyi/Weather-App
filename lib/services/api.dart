import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherAPI {
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';
  final String apiKey = 'cf23bb659daa49c5ec6fb56eacefd0ff'; 

  Future<Map<String, dynamic>> getCurrentWeather(double latitude, double longitude) async {
    final url = '$baseUrl/weather?lat=$latitude&lon=$longitude&appid=$apiKey';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch weather data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server. Please check your internet connection.');
    }
  }

  Future<Map<String, dynamic>> getForecastWeather(double latitude, double longitude, {int days = 5}) async {
    final url = '$baseUrl/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&cnt=$days';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch weather forecast data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server. Please check your internet connection.');
    }
  }
}
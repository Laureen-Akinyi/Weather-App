import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'package:weather_app/services/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherAPI _weatherAPI = WeatherAPI();
  String? weatherDescription;
  double? temperature;
  double? currentMinTemperature;
  double? currentMaxTemperature;
  List<Map<String, dynamic>>? forecastWeatherData;

  Future<void> _fetchWeatherData() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      Map<String, dynamic> currentWeather = await _weatherAPI.getCurrentWeather(
          position.latitude, position.longitude);

      Map<String, dynamic> getForecastWeather = await _weatherAPI
          .getForecastWeather(position.latitude, position.longitude);

      setState(() {
        weatherDescription = currentWeather['weather'][0]['main'];
        temperature = (currentWeather['main']['temp'] - 273.15);
        currentMinTemperature = (currentWeather['main']['temp_min'] - 273.15);
        currentMaxTemperature = (currentWeather['main']['temp_max'] - 273.15);
        forecastWeatherData = _parseForecastData(getForecastWeather);
      });
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  List<Map<String, dynamic>> _parseForecastData(Map<String, dynamic> data) {
    List<Map<String, dynamic>> forecastData = [];
    for (var item in data['list']) {
      forecastData.add({
        'day': DateTime.parse(item['dt_txt']).toString(),
        'weather': item['weather'][0]['main'],
        'temperature':
            '${(item['main']['temp'] - 273.15).toStringAsFixed(0)}°C',
      });
    }
    return forecastData;
  }

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WeatherScreen(
        currentMaxTemperature: '${temperature?.toStringAsFixed(2)}°C',
        currentMinTemperature: '${temperature?.toStringAsFixed(2)}°C',
        currentTemperature: '${temperature?.toStringAsFixed(0)}°C',
        weatherCondition: '$weatherDescription',
        forecastWeatherData: forecastWeatherData,
      ),
    );
  }
}

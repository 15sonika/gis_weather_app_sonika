// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';
import '../secrets.dart';

class WeatherService {
  final String apiKey =
      Secrets.weatherApiKey; // Replace with your OpenWeatherMap API key

  Future<Weather> fetchWeather(String cityName) async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=${Uri.encodeComponent(cityName)}&appid=$apiKey'),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'weather_model.dart';
import 'weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;
  String _errorMessage = '';
  final WeatherService _weatherService = WeatherService();

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  WeatherProvider() {
    _loadLastSearchedCity();
  }

  Future<void> _loadLastSearchedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastCity = prefs.getString('lastCity');
    if (lastCity != null) {
      fetchWeather(lastCity);
    }
  }

  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    notifyListeners();

    try {
      _weather = await _weatherService.fetchWeather(cityName);
      _errorMessage = '';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('lastCity', cityName);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

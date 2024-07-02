import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/weather_model.dart';
import '../config/weather_provider.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final Weather weather;

  const WeatherDetailsScreen({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(weather.cityName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text('${weather.temperature.toStringAsFixed(1)} °C',
            style: const TextStyle(fontSize: 24)),
        Text(weather.description),
        Image.network(
            'http://openweathermap.org/img/wn/${weather.icon}@2x.png'),
        Text('Humidity: ${weather.humidity}%'),
        Text('Wind Speed: ${weather.windSpeed} m/s'),
        ElevatedButton(
          onPressed: () {
            Provider.of<WeatherProvider>(context, listen: false)
                .fetchWeather(weather.cityName);
          },
          child: const Text('Refresh'),
        ),
      ],
    );
  }
}

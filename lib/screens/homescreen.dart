// lib/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/weather_provider.dart';
import 'weather_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App By Sonika'),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'images/bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Foreground content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter city name',
                    filled: true,
                    fillColor: Colors.white
                        .withOpacity(0.8), // Adjust opacity as needed
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<WeatherProvider>(context, listen: false)
                        .fetchWeather(_controller.text);
                  },
                  child: Text('Search'),
                ),
                Consumer<WeatherProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return CircularProgressIndicator();
                    } else if (provider.errorMessage.isNotEmpty) {
                      return Text(
                        provider.errorMessage,
                        style: TextStyle(color: Colors.red),
                      );
                    } else if (provider.weather != null) {
                      return WeatherDetailsScreen(weather: provider.weather!);
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

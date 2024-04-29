import 'package:flutter/material.dart';
import 'package:weather_app/screens/navbar.dart';

class WeatherScreen extends StatefulWidget {
  final currentTemperature;
  final currentMinTemperature;
  final currentMaxTemperature;
  final weatherCondition;
  final List? forecastWeatherData;
  const WeatherScreen(
      {super.key,
      this.currentTemperature,
      this.currentMinTemperature,
      this.currentMaxTemperature,
      this.weatherCondition,
      this.forecastWeatherData});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.forecastWeatherData);
    return Scaffold(
      drawer: const NavBar(),
      backgroundColor: widget.weatherCondition == "Cloudy"
          ? const Color(0xFF54717A)
          : widget.weatherCondition == "Sunny"
              ? const Color(0xFF47AB2F)
              : widget.weatherCondition == "Rain"
                  ? const Color(0xFF57575D)
                  : Colors.white,
      appBar: AppBar(
        title: const Text(' '),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fill,
              image: widget.weatherCondition == "Cloudy"
                  ? const AssetImage('assets/images/sea_cloudy.png')
                  : widget.weatherCondition == "Sunny"
                      ? const AssetImage('assets/images/sea_sunny.png')
                      : widget.weatherCondition == "Rain"
                          ? const AssetImage('assets/images/sea_rainy.png')
                          : const AssetImage('assets/images/default_image.png'),
            )),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    widget.currentTemperature,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.weatherCondition,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.currentMinTemperature} min',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                '${widget.currentTemperature} Current',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                '${widget.currentMaxTemperature} max',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          const Divider(
            color: Colors.white,
          ),
          //forecast
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                for (int i = 0; i < widget.forecastWeatherData!.length; i++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.forecastWeatherData![i]["day"].toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 50),
                      Image.asset(
                        widget.weatherCondition == "Cloudy"
                            ? 'assets/images/partlysunny@3x.png'
                            : widget.weatherCondition == "Sunny"
                                ? 'assets/images/clear@3x.png'
                                : widget.weatherCondition == "Rain"
                                    ? 'assets/images/rain@3x.png'
                                    : 'assets/images/default_image.png',
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        widget.forecastWeatherData![i]["temperature"]
                            .toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

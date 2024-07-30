import 'package:clima_app/screens/city_screen.dart';
import 'package:clima_app/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima_app/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  const LocationScreen({super.key, required this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  late String weatherIcon;
  late String cityName;
  late String weatherMessage;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }

      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temp.toInt());

      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      var weaterData = await weather.getLocationWeather();
                      updateUI(weaterData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typeName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CityScreen()));
                      if (typeName != null) {
                        var weatherData =
                            await weather.getCityWeather(typeName);
                        updateUI(weatherData);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  children: [
                    Text(
                      weatherMessage,
                      textAlign: TextAlign.right,
                      style: kMessageTextStyle.copyWith(fontSize: 40),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        'in',
                        textAlign: TextAlign.right,
                        style: kMessageTextStyle.copyWith(fontSize: 40),
                      ),
                    ),
                    Text(
                      '"$cityName"',
                      textAlign: TextAlign.right,
                      style:
                          kMessageTextStyle.copyWith(color: Colors.blue[100]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// double temperature = decodeData['main']['temp'];
// int condition = decodeData['weather'][0]['id'];
// String cityName = decodeData['name'];

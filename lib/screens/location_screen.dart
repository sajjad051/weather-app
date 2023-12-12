// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:weather_today/screens/city_screen.dart';
import 'package:weather_today/utils/constants.dart';
import 'package:weather_today/utils/custom_paint.dart';

import '../services/weather.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  const LocationScreen({super.key,required this.locationWeather});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {

  late int temperature;
  late int minTemperature;
  late int maxTemperature;
  late double windSpeed;
  late int humidity;

  late String cityName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   updateUi(widget.locationWeather);
  }
 void updateUi(dynamic weatherData){
   setState(() {
     if (weatherData == null) {
       temperature = 0;
       minTemperature = 0;
       maxTemperature = 0;
       windSpeed = 0.0;
       humidity = 0;
       cityName = 'Error!';
       return;
     }
     double temp = weatherData['main']['temp'];
     temperature = temp.toInt();
     double minTemp = weatherData['main']['temp_min'];
     minTemperature = minTemp.toInt();
     double maxTemp = weatherData['main']['temp_max'];
     maxTemperature = maxTemp.toInt();
     humidity = weatherData['main']['humidity'];
     windSpeed = weatherData['wind']['speed'] * 3.6;
     cityName = weatherData['name'];
   });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.09),
              BlendMode.darken,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.only(
                  top: 24,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var weatherData = await  WeatherModel().getLocationWeather();
                        updateUi(weatherData);
                      },
                      child: Image.asset(
                        'images/ic_current_location.png',
                        width: 32.0,
                      ),
                    ),
                    SizedBox(width: 24.0),
                    GestureDetector(
                      onTap: () async {
                      var typeName = await  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CityScreen(),
                          ),
                        );

                      if(typeName != null){
                        var weatherData = await WeatherModel().getCityWeather(typeName);
                        updateUi(weatherData);
                      }


                      },
                      child: Image.asset(
                        'images/ic_search.png',
                        width: 32.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 16.0),
                    Image.asset(
                      'images/ic_location_pin.png',
                      width: 24.0,
                      height: 24.0,
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        '$cityName',
                        textAlign: TextAlign.center,
                        style: kSmallTextStyle.copyWith(
                          fontSize: 16.0,
                          color: Colors.black45,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 190,
                child: CustomPaint(
                  painter: MyCustomPaint(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24.0,
                          bottom: 24.0,
                        ),
                        child: Text(
                          'Weather Today',
                          style: kConditionTextStyle.copyWith(fontSize: 16.0),
                        ),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ConditionRow(
                      icon: 'images/ic_temp.png',
                      title: 'Min Temp',
                      value: '$minTemperature°',
                    ),
                    ConditionRow(
                      icon: 'images/ic_wind_speed.png',
                      title: 'Wind Speed',
                      value: '${windSpeed.toStringAsFixed(1)} Km/h',
                    ),
                    ConditionRow(
                      icon: 'images/ic_temp.png',
                      title: 'Max Temp',
                      value: '$maxTemperature°',
                    ),
                    ConditionRow(
                      icon: 'images/ic_humidity.png',
                      title: 'Humidity',
                      value: '$humidity%',
                    )
                  ],
                ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ConditionRow extends StatelessWidget {
  final String icon;
  final String title;
  final String value;

  const ConditionRow({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          icon,
          width: 24.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Text(
            title,
            style: kConditionTextStyleSmall,
          ),
        ),
        Text(
          value,
          style: kConditionTextStyle,
        ),
      ],
    );
  }
}
// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:convert';
//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_today/screens/location_screen.dart';
import 'package:weather_today/services/location.dart';
import 'package:weather_today/services/network.dart';
import 'package:weather_today/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  LoadingScreenState createState() => LoadingScreenState();
}

const apiKEY = '5a18fc6e52dc7342ee016a20e95a106c';

class LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherLocationData();
  }

  void getWeatherLocationData() async {
   // WeatherModel weatherModel = WeatherModel();
    var weatherData = await WeatherModel().getLocationWeather();

    //print(weatherData.toString());
    Navigator.push(context, MaterialPageRoute(builder: (context)=> LocationScreen(
      locationWeather: weatherData,

    ),),);
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
                Colors.black.withOpacity(0.09), BlendMode.darken),
          ),
        ),
        child: Center(
          child: SpinKitThreeBounce(
            color: Colors.white,
            size: 60,
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:weather_today/screens/location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //Get the current location
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LocationScreen(),
              ),
            );
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}

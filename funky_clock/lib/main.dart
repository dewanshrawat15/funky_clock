import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';

import 'dart:async';

void main() {
  runApp(App());
}

bool theme = false;

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  String _timeString;
  String weekday;
  String greeting = 'Hi';
  var weather, temperature, weatherIcon;

  String _formatDateTime(DateTime datetime) {
    weekday = DateFormat("EEEE").format(datetime);
    return DateFormat("hh:mm:ss a").format(datetime);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    var hour = now.hour;
    if (hour >= 4 && hour < 8) {
      greeting = "Good Morning";
      theme = true;
    } else if (hour >= 8 && hour < 11) {
      greeting = "Good Morning";
      theme = false;
    } else if (hour >= 11 && hour < 16) {
      greeting = "Good Afternoon";
      theme = false;
    } else if (hour >= 16) {
      greeting = "Good Evening";
      theme = true;
    }
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    var temp = ClockModel();
    switch (temp.weatherCondition) {
      case WeatherCondition.windy:
        weatherIcon = Icons.filter_drama;
        break;
      case WeatherCondition.cloudy:
        weatherIcon = Icons.cloud;
        break;
      case WeatherCondition.sunny:
        weatherIcon = Icons.wb_sunny;
        break;
      case WeatherCondition.snowy:
        weatherIcon = Icons.ac_unit;
        break;
      case WeatherCondition.foggy:
        weatherIcon = Icons.filter_drama;
        break;
      case WeatherCondition.rainy:
        weatherIcon = Icons.wb_sunny;
        break;
      case WeatherCondition.thunderstorm:
        weatherIcon = Icons.wb_cloudy;
        break;
    }
    setState(() {
      weather = temp.weatherString;
      temperature = temp.temperatureString;
    });
    super.initState();
  }

  Color themeColor = Color(0xffbb86fc);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme
          ? ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.black,
              accentColor: Colors.black,
              scaffoldBackgroundColor: Colors.black)
          : ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.white,
              accentColor: Colors.white,
              scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Text(
              greeting,
              style: TextStyle(
                  color: themeColor,
                  fontSize: 22,
                  fontFamily: "Montseratt",
                  fontWeight: FontWeight.w300),
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Icon(
                  weatherIcon,
                  color: themeColor,
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              child: Text(temperature,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Montserrat",
                      color: themeColor)),
            )
          ],
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  _timeString,
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 64,
                      color: themeColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  weekday,
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 48,
                      color: themeColor,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ]),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            CircleAvatar(
              child: Icon(
                Icons.event,
                color: themeColor,
              ),
              backgroundColor: theme ? Colors.black : Colors.white,
            ),
            SizedBox(
              height: 12,
            ),
            CircleAvatar(
              child: Icon(
                Icons.lightbulb_outline,
                color: themeColor,
              ),
              backgroundColor: theme ? Colors.black : Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

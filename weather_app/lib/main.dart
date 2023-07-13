import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var currentCity;
  var temperature;
  var description;
  var weatherIcon;
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  void getWeather() async {
    final queryParameters = {
      "q": "Dhaka",
      "appid": '476d7f2559919d457197305729d0b1aa',
    };
    Uri uri = Uri.https("api.openweathermap.org", "/data/2.5/weather", queryParameters);
    final jsonData = await get(uri);
    final json = jsonDecode(jsonData.body);

    setState(() {
      currentCity = json["name"];
      temperature = json["main"]["temp"];
      final minTemp = json["main"]["temp_min"];
      final maxTemp = json["main"]["temp_max"];
      description = json["weather"][0]["main"];
      weatherIcon = json["weather"][0]["icon"];
      isLoading = false;

      temperature = {
        "current": temperature,
        "min": minTemp,
        "max": maxTemp,
      };
    });
  }

  String getWeatherIconUrl(String iconCode) {
    return 'http://openweathermap.org/img/w/$iconCode.png';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Weather App"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Currently in " + (currentCity == null ? "Loading" : currentCity),
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : temperature != null
                  ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (temperature["current"] - 273).toStringAsFixed(2) + "\u00B0",
                        style: TextStyle(fontSize: 50),
                      ),
                      SizedBox(width: 10),
                      weatherIcon != null
                          ? Image.network(
                        getWeatherIconUrl(weatherIcon),
                        width: 50,
                        height: 50,
                      )
                          : SizedBox(),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Min: ${(temperature["min"] - 273).toStringAsFixed(2)}\u00B0",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Max: ${(temperature["max"] - 273).toStringAsFixed(2)}\u00B0",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              )
                  : SizedBox(),
              SizedBox(height: 20),
              Text(
                description == null ? "Loading" : description,
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/Models/loadCity.dart';
import 'package:weather/Models/loadData.dart';
import 'package:http/http.dart' as http;

class Sload extends StatefulWidget {
  const Sload({super.key});
  @override
  State<Sload> createState() => _SloadState();
}

class _SloadState extends State<Sload> {

  late List<dynamic> citynames;
  String m = " ";
  bool e = true;
  late int no;
  late String ct;
  late String Fetch_data;
  late String temprature;
  late String icon;
  late String description;

  // List<Weather> weatherList = [];
  // code for getting city list.
  void getcity(String ct) async {
    loadCity intstance = loadCity(Sname: ct);
    await intstance.getCity();
    e = intstance.error;
    citynames = intstance.citylist;
    no = intstance.size;
  Future.delayed(const Duration(seconds: 2), () {
      data(citynames);
    });
  }
  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> search = {};
    Object? myObject = ModalRoute.of(context)?.settings.arguments;
    if (myObject != null && myObject is Map<dynamic, dynamic>) {
      search = myObject;
    } else {
      print("error");
    }
    if (search?.isNotEmpty ?? false) {
      ct = search['searchText'];
    }
    getcity(ct);

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                Image.asset(
                  "assets/images/wlogo.png",
                  height: 160,
                  width: 180,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Fetching_Data",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "$m",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 90,
                ),
                SpinKitRotatingCircle(
                  color: Colors.white,
                  size: 50.0,
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(209, 33, 85, 241),
                Color.fromARGB(255, 95, 184, 219)
              ],
            ),
          ),
          height: double.maxFinite,
        ),
      ),
    );
  }

  Future<List<Weather>> fetchAndSortTemperatures(List<dynamic> cities) async {
    List<Weather> weatherList = [];
    for (dynamic city in cities) {
      final response = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=31e8a9e8ab0e3763ff5a40db0477d9e2'),
      );
      if (response.statusCode == 200) {
        final weather = Weather.fromJson(json.decode(response.body));
        weatherList.add(weather);
      } else {
        // Handle error
        print('Error fetching temperature for $city');
      }
    }
    // Sort the weatherList by temperature in ascending order
    weatherList.sort((a, b) => a.temperature.compareTo(b.temperature));
    return weatherList;
  }

  void data(List<dynamic> city) async {
    List<Weather> fetchedWeather = await fetchAndSortTemperatures(city);
    Navigator.pushReplacementNamed(
      context,
      "/home2",
      arguments: fetchedWeather,
    );
  //   for (int i = 0; i < weatherList.length; i++)
  //     print(
  //         '${weatherList[i].cityName}: ${weatherList[i].temperature - 273.15}°C, Icon: ${weatherList[i].icon}');
  }
}


class Weather {
  final String cityName;
  final dynamic temperature;
  final String icon;
  final String description;

  Weather(
      {required this.cityName, required this.temperature, required this.icon, required this.description});
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble() - 273.15,
      icon: json['weather'] != null && json['weather'].isNotEmpty
          ? json['weather'][0]['icon'] ?? 'default_icon'
          : 'default_icon',
          description: json['weather'] != null && json['weather'].isNotEmpty
          ? json['weather'][0]['description'] ?? 'Loading'
          : 'Loading',
    );
  }
}

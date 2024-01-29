// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/loadCity.dart';
import 'package:weather/loadData.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String city = "Bilaspur";
  late String temp;
  late String humidity;
  late String airspeed;
  late String description;
  late String maini;
  late String icon;
// ---------------------------------------------------------------------------------------------------------
  void startApp(String city) async {
    loadData instance = loadData(location: city);
    await instance.getData();
    temp = instance.temp;
    humidity = instance.humidity;
    airspeed = instance.air_speed;
    description = instance.description;
    maini = instance.main;
    icon = instance.icon;

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "temp_value": temp,
        "hum_value": humidity,
        "air_speed_value": airspeed,
        "des_value": description,
        "main_value": maini,
        "icon_value": icon,
        "city_value": city,
      });
    });
  }
  // --------------------------------------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
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
      city = search['searchText'];
    }
    startApp(city);
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 90,
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
                  "Weather_Report",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "loading...",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
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
}
// ---------------------------------------------------------------------

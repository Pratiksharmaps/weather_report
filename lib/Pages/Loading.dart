// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/Models/loadData.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String city = "Bilaspur";
// ---------------------------------------------------------------------------------------------------------
  void startApp(String city) async {
    // calling model to load weather data
    loadData instance = loadData(location: city);
    await instance.getData();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "temp_value":instance.temp,
        "hum_value": instance.humidity,
        "air_speed_value":instance.air_speed,
        "des_value": instance.description,
        "main_value":instance.main,
        "icon_value": instance.icon,
        "city_value": city,
      }
      );
    }
    );
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 80,
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
                      fontSize: 21,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 50,
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
              colors: const [
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

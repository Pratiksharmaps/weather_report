// ignore_for_file: unused_local_variable

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:weather/Loading.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final srch = TextEditingController();
  final search_state = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    print("Set state called");
  }

  @override
  Widget build(BuildContext context) {
    final Loading loading;
    var city_name = [
      "Bilaspur",
      "Raipur",
      "Mumbai",
      "Delhi",
      "Chennai",
      "Jaipur",
      "Indore",
      "London"
    ];
    final _random = new Random();


    var city = city_name[_random.nextInt(city_name.length)
    ];
    
    Map<dynamic, dynamic> info = {};
    Object? myObject = ModalRoute.of(context)?.settings.arguments;
    info = myObject as Map<dynamic, dynamic>;
    String temp = ((info['temp_value']).toString());
    String air = ((info['air_speed_value']).toString());
    if (temp == "NA") {
      print("NA");
    } else {
      temp = ((info['temp_value']).toString()).substring(0, 4);
      air = ((info['air_speed_value']).toString()).substring(0, 2);
    }
    String icon = info['icon_value'];
    String cityname = info['city_value'];
    String hum = info['hum_value'];
    String des = info['des_value'];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(31, 12, 62, 212),
                  Color.fromARGB(255, 63, 142, 196)
                ],
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(3, 2, 6, 0),
                        child: Icon(
                          Icons.search,
                          size: 20,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: srch,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search $city"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if ((srch.text).replaceAll(" ", "") == "") {
                            print("Blank search");
                          } else {
                            Navigator.pushReplacementNamed(context, "/loading",
                                arguments: {
                                  "searchText": srch.text,
                                });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: Text(
                            "Search",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 5, 128, 189),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5)),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          padding: EdgeInsets.all(26),
                          child: Row(children: [
                            Image.network(
                              "http://openweathermap.org/img/wn/$icon@2x.png",
                              height: 70,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  "$des",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "$cityname",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ])),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        padding: EdgeInsets.all(26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(WeatherIcons.thermometer),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$temp",
                                  style: TextStyle(fontSize: 80),
                                ),
                                Text(
                                  "°C",
                                  style: TextStyle(fontSize: 30),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        padding: EdgeInsets.all(26),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.wind_beaufort_0, size: 20)
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "$air",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Text("km/hr")
                          ],
                        ),
                        height: 170,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                        padding: EdgeInsets.all(23),
                        height: 170,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  WeatherIcons.humidity,
                                  size: 20,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "$hum",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Text("Percent")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 2, 6, 0),
                        child: Icon(
                          Icons.search,
                          size: 25,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: search_state,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search By State"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if ((search_state.text).replaceAll(" ", "") == "") {
                            print("Blank search");
                          } else {
                            Navigator.pushReplacementNamed(context, "/Sload",
                                arguments: {
                                  "searchText": search_state.text,
                                });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: Text(
                            "Search",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 5, 128, 189),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text("Data Provided By Openweathermap.org")],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

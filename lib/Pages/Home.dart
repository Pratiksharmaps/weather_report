import 'dart:math';
import 'package:flutter/material.dart';
import 'package:weather/Pages/Loading.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final srch = TextEditingController();
  final search_state = TextEditingController();
  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    var cityName = [
      "Bilaspur",
      "Raipur",
      "Mumbai",
      "Delhi",
      "Chennai",
      "Jaipur",
      "Indore",
      "London"
    ];

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    final random =  Random();
    var city = cityName[random.nextInt(cityName.length)];


    Map<dynamic, dynamic> info = {};
    // obect ara route se

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: mediaQueryData.size.height,
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
                  padding:const  EdgeInsets.symmetric(horizontal: 10),
                  margin:const  EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    children: [
                      Container(
                        padding:const  EdgeInsets.fromLTRB(3, 2, 6, 0),
                        child:  const Icon(
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
                          padding:const  EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: const  Text(
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
                          margin:const  EdgeInsets.symmetric(horizontal: 25),
                          padding:const  EdgeInsets.all(26),
                          child: Row(children: [
                            Image.network(
                              "http://openweathermap.org/img/wn/$icon@2x.png",
                              height: 70,
                            ),
                          const   SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  des,
                                  style: const  TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              const   SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  cityname,
                                  style:const  TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ])),
                    ),
                  ],
                ),
           const   SizedBox(
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
                           const  EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        padding: const  EdgeInsets.all(26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        const     Icon(WeatherIcons.thermometer),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$temp",
                                  style: const  TextStyle(fontSize: 80),
                                ),
                            const     Text(
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
             const    SizedBox(
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
                        margin:const  EdgeInsets.fromLTRB(20, 0, 10, 0),
                        padding:const  EdgeInsets.all(26),
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
                         const    Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  WeatherIcons.humidity,
                                  size: 20,
                                )
                              ],
                            ),
                        const     SizedBox(
                              height: 25,
                            ),
                            Text(
                              "$hum",
                              style:const  TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Text("Percent")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
               const SizedBox(
                  height: 2,
                ),
                Container(
                  padding:const  EdgeInsets.symmetric(horizontal: 10),
                  margin:const  EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    children: [
                      Container(
                        padding:const  EdgeInsets.fromLTRB(5, 2, 6, 0),
                        child:const  Icon(
                          Icons.search,
                          size: 25,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: search_state,
                          decoration:const  InputDecoration(
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
                          padding:const  EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child:const Text(
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
                  padding:const  EdgeInsets.all(10),
                  child:const  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text("Data Provided By Openweathermap.org")
                    ],
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

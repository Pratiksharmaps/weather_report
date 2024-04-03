import 'package:flutter/material.dart';
import 'package:weather/Models/Sload.dart';
import 'package:weather_icons/weather_icons.dart';

class Wload extends StatefulWidget {
  @override
  State<Wload> createState() => _WloadState();
}

class _WloadState extends State<Wload> {
  @override
  Widget build(BuildContext context) {
    Object? myObject = ModalRoute.of(context)?.settings.arguments;
    List weatherList = myObject as List<Weather>;
    late var temp;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const  Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
          ),
          title:const  Text(
            "Weather",
            style: TextStyle(color: Colors.white70),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
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
          child: ListView.builder(
              itemCount: weatherList.length,
              itemBuilder: (context, index) {
                Weather weather = weatherList[index];
                temp = weather.temperature.toStringAsFixed(2);
                return Row(
                  children: [
              const       SizedBox(
                      height: 18,
                    ),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              color: Colors.white.withOpacity(0.5)),
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(children: [
                                Image.network(
                                  "http://openweathermap.org/img/wn/${weather.icon}@2x.png",
                                  height: 70,
                                ),
                                SizedBox(
                                  width: 28,
                                ),
                                Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              WeatherIcons.thermometer,
                                              color: Colors.amber,
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              "$temp",
                                              style: TextStyle(fontSize: 50),
                                            ),
                                            Text(
                                              "°C",
                                              style: TextStyle(fontSize: 20),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${weather.description}",
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "${weather.cityName}",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ]),
                            ],
                          )),
                    ),
                  ],
                );
              }),
        ));
  }
}

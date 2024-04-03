// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class loadData {
  late String location;
  loadData({required this.location}) {
    location = this.location;
  }
  String temp = "null";
  late String humidity;
  late String air_speed;
  late String description;
  late String main;
  late String icon;
  late String name;

  Future<void> getData() async {
    try {
      var follow = Uri.parse(
          "http://api.openweathermap.org/data/2.5/weather?q=$location&appid=6c6fb4272d1f06c1ed5022fa60fcc97b");
      Response response = await get(follow);
      Map data = jsonDecode(response.body);

      Map temp_data = data['main'];
      print(temp_data);
      String getHumidity = temp_data['humidity'].toString();
      double getTemp = temp_data['temp'] - 273.15;
      Map wind = data['wind'];
      double getAir_speed = wind["speed"] / 0.27777777777778;
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getMain_des = weather_main_data['main'];
      String getDesc = weather_main_data["description"];
      temp = getTemp.toString();
      humidity = getHumidity;
      air_speed = getAir_speed.toString();
      description = getDesc;
      main = getMain_des;
      icon = weather_main_data["icon"].toString();
    } catch (e) {
      print(e);
      temp = "NA";
      humidity = "NA";
      air_speed = "NA";
      description = "Can't Find Data";
      main = "NA";
      icon = "09d";
    }
  }
}

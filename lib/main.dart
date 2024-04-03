import 'package:flutter/material.dart';
import 'package:weather/Pages/Home.dart';
import 'package:weather/Pages/Loading.dart';
import 'package:weather/Models/Sload.dart';
import 'package:weather/Pages/Home2.dart';
void main() {
  runApp(
    MaterialApp(
    routes: {
      "/": (context) =>Loading(),
     "/home": (context) => Home(),
     "/loading":(context) => Loading(),
     "/Sload":(context) => Sload(),
     "/home2":(context) => Wload()
    },
    debugShowCheckedModeBanner: false,
  ));
}

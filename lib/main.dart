import 'package:flutter/material.dart';
import 'package:weather/Home.dart';
import 'package:weather/Loading.dart';
import 'package:weather/Sload.dart';
import 'package:weather/Home2.dart';
void main() {
  runApp(MaterialApp(
    routes: {
      "/": (context) =>Loading(),
      //  "/": (context) =>Sload(),
     "/home": (context) => Home(),
     "/loading":(context) => Loading(),
     "/Sload":(context) => Sload(),
     "/home2":(context) => Wload()
    },
    debugShowCheckedModeBanner: false,
  ));
}

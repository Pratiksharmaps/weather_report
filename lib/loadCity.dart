import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class loadCity{
  late String Sname;
  late int size;
  late String message;
  late bool error;
  loadCity({
    required this.Sname,
  }) {
    this.Sname;
  }
  late List<dynamic> citylist;
  Future<void> getCity() async {
    try {
      var follow = Uri.parse(
          "https://countriesnow.space/api/v0.1/countries/state/cities/q?country=India&state=$Sname");
      Response response = await get(follow);
      Map data = jsonDecode(response.body);
      citylist = data['data'];
      error = data['error'] ;
       message = data['msg'];
      size = citylist.length;
      print(citylist);
    } catch (e) {
      print(e);
      error = true;
      message = "error";
      size = 0;
      citylist = ["null", "error"];
    }
  }
}

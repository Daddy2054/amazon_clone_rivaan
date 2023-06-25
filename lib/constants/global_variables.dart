import 'package:flutter/material.dart';

//String uri = 'http://127.0.0.1:3000'; //don't work on android!!
//String uri = 'http://192.168.0.149:3000';  //local network 
String uri = 'http://172.20.10.8:3000'; // via extender -> hotspot iphone

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
}

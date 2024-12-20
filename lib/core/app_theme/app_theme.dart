import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xfff5f8ff),
    fontFamily: 'Montserrat Regular',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: const Color.fromARGB(255, 0, 94, 255),
          textStyle: const TextStyle(
              fontSize: 25.0,
              fontFamily: 'Montserrat Bold',
              color: Color.fromARGB(255, 255, 255, 255)),
          foregroundColor: Colors.white),
      // backgroundColor: const Color(0xff3f51b5),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(10),
      // ),
      // textStyle: const TextStyle(
      //     fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
    ),
  );
}

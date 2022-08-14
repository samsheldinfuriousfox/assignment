import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get textTheme => ThemeData(
      fontFamily: 'Cera Pro',
      //  primarySwatch: Colors.black,
      textTheme: const TextTheme(
        headline3: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          fontFamily: "Lora",
          color: Colors.black,
        ),
        headline4: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            height: 1.3),
        headline5: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            height: 1.3),
        button: TextStyle(
            fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
        subtitle1: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            height: 1.3),
        subtitle2: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            height: 1.3),
        bodyText1: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            height: 1.3),
      ));
}

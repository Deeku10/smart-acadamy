import 'package:flutter/material.dart';
import 'heightWidth.dart';

BuildContext? context;

class SmartTheme {
  ThemeData saTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Nunito',
      textTheme: TextTheme(
          // ignore: prefer_const_constructors
          headline1: TextStyle(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.w900),
          headline2:
              TextStyle(color: Colors.white, fontSize: (context?.height)),
          headline3:
              TextStyle(color: Colors.white, fontSize: (context?.height))));
}

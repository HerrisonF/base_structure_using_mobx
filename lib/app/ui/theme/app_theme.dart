import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  primarySwatch: Colors.blueGrey,
  brightness: Brightness.light,
  accentColor: Colors.lightGreen,
  appBarTheme: AppBarTheme(
    color: Colors.lightGreen,
  ),
  backgroundColor: Colors.lightBlueAccent,
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        backgroundColor: Colors.lightGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        side: BorderSide(
          color: Colors.lightGreen,
        ),
        textStyle: TextStyle(
          fontWeight: FontWeight.w500,
        )
    ),
  ),
);
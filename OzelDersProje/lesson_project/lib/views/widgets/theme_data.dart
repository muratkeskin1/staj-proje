import 'package:flutter/material.dart';

class ApplicationTheme {
  late ThemeData applicationThemeData;

  ApplicationTheme() {
    applicationThemeData = ThemeData(
      primaryColor: Colors.amber.shade400,
      fontFamily: 'Roboto',
      appBarTheme: AppBarTheme(
        color: Colors.amber.shade400,
        toolbarTextStyle: const TextTheme(
          headline6: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ).bodyText2,
        titleTextStyle: const TextTheme(
          headline6: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ).headline6,
      ),
      scaffoldBackgroundColor: Colors.amber.shade200,
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.amber.shade400,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}

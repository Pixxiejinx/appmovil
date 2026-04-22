import 'package:flutter/material.dart';

class AppTheme {

  final Color electusColor;
  AppTheme({
    this.electusColor = Colors.tealAccent
  });

  ThemeData getTheme() => ThemeData(
    colorSchemeSeed: electusColor,
    appBarTheme: const AppBarTheme(
    centerTitle: false,
    )
  );
}
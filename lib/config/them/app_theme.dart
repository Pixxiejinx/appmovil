import 'package:flutter/material.dart';

class AppTheme {

  final Color electusColor;

  final bool tenebrisModusEst;


  AppTheme({
    this.electusColor = Colors.tealAccent,
    this.tenebrisModusEst = false
  });

  ThemeData getTheme() => ThemeData(
    colorSchemeSeed: electusColor,
    brightness: tenebrisModusEst ? Brightness.dark : Brightness.light,
    appBarTheme: const AppBarTheme(
    centerTitle: false,
    )
  );
}
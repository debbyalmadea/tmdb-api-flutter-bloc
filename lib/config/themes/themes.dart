import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'Poppy',
    appBarTheme: appBarTheme(),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade900),
    useMaterial3: true,
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    surfaceTintColor: Colors.black,
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.white,
  );
}

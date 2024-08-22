import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData createTheme() {
  return ThemeData(
    primaryColor: const Color(0xffE8E8E8),
    brightness: Brightness.light,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.white,
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: const Color(0xffE8E8E8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    // NOTE change text field's cursor color to grey
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.grey,
      selectionColor: Colors.grey,
      selectionHandleColor: Colors.black,
    ),
    // NOTE for iphone users, the selectionHandleColor will change to grey
    cupertinoOverrideTheme: const CupertinoThemeData(
      primaryColor: Colors.grey,
    ),
    fontFamily: 'SourceCodePro',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

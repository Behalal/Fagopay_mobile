import 'package:flutter/material.dart';

class AppTheme{
  static const MaterialColor materialColor = MaterialColor(
      0xffF20021,
      <int, Color>{
        50: Color(0xffC61F2A),
        100: Color(0xffC61F2A),
        200: Color(0xffC61F2A),
        300: Color(0xffC61F2A),
        400: Color(0xffC61F2A),
        500: Color(0xffC61F2A),
        600: Color(0xffC61F2A),
        700: Color(0xffC61F2A),
        800: Color(0xff6B142B),
      }
  );
  static ThemeData applicationTheme(){
    return ThemeData(
      primarySwatch: materialColor,
      fontFamily: "Work Sans",
      errorColor: Colors.red,
      // textSelectionTheme: const TextSelectionThemeData(
      //     cursorColor: black,
      //     selectionColor: black,
      //     selectionHandleColor: black
      // ),
    );
  }

}
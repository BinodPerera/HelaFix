import 'package:flutter/material.dart';

class AppColours {

  static Color light = Color.fromARGB(255, 0, 0, 0);
  static Color dark = Color.fromARGB(255, 255, 255, 255);

  static Color primaryLight = Color.fromARGB(255, 239, 236, 255);
  static Color primaryDark = Color.fromARGB(255, 41, 40, 40);

  static Color primaryTextLight = Color(0xFF000000);
  static Color primaryTextDark = Color.fromARGB(255, 255, 255, 255);
  static Color secondaryTextLight = const Color.fromARGB(255, 129, 122, 122);
  static Color secondaryTextDark = Colors.grey;

  static Color containerBackgroundLight = Color.fromARGB(255, 239, 236, 255);
  static Color containerBackgroundDark = Color(0xFF121212);

  static Color primaryBtnLight = Colors.yellow;
  static Color primaryBtnDark = const Color.fromARGB(255, 211, 195, 49);
  static Color primaryBtnTextDark = const Color.fromARGB(255, 255, 255, 255);
  static Color primaryBtnTextLight = const Color.fromARGB(255, 0, 0, 0);

  // icon colours
  static Color iconColorLight = const Color.fromARGB(255, 255, 240, 240);
  static Color iconColorDark = const Color.fromARGB(255, 52, 52, 52);

  // navigation bar
  static Color navBarLightColor1 = const Color.fromARGB(255, 0, 183, 255);
  static Color navBarLightColor2 = Color.fromARGB(255, 77, 46, 121);

  static Color navBarDarkColor1 = const Color.fromARGB(255, 0, 183, 255);
  static Color navBarDarkColor2 = const Color.fromARGB(255, 21, 0, 50);

  static Gradient backgroundGradientLight = const LinearGradient(
    colors: [
      Color.fromARGB(255, 0, 183, 255),
      Color.fromARGB(255, 77, 46, 121),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static Gradient backgroundGradientDark = const LinearGradient(
    colors: [
      Color.fromARGB(255, 0, 183, 255),
      Color.fromARGB(255, 21, 0, 50),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
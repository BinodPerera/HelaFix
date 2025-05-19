import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/theme/colors.dart';

Widget loadingScreen({
  required bool isDarkMode,
}) {
  return Center(
    child: Container(
      decoration: BoxDecoration(
        gradient: isDarkMode ? AppColours.backgroundGradientDark : AppColours.backgroundGradientLight,
      ),
      child: Center(child: CircularProgressIndicator(
        color: isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight,
      )),
    )
    
  );
}
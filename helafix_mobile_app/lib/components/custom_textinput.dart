import 'package:flutter/material.dart';

Widget customTextInput({
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  required bool isDarkMode,
  bool isPassword = false,
  bool isEmail = false,
  bool isPhone = false,
  bool isNumber = false,
  bool isReadOnly = false,
  bool isEnabled = true,
}) {
  return TextFormField(
    controller: controller,
    readOnly: isReadOnly,
    enabled: isEnabled,
    obscureText: isPassword,
    keyboardType: isEmail
        ? TextInputType.emailAddress
        : isPhone
            ? TextInputType.phone
            : isNumber
                ? TextInputType.number
                : TextInputType.text,
    style: TextStyle(
      color: isDarkMode ? Colors.white : Colors.black,
    ),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: isDarkMode ? Colors.white54 : Colors.black54,
      ),
      prefixIcon: Icon(icon, color: isDarkMode ? Colors.white : Colors.black),
      filled: true,
      fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
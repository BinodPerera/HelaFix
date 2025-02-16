import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override 
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      title: Row(
        children: [
          Image.asset(
            'assets/images/logo_bg_light.png', // Path to your image
            height: 60, // Adjust height
          )
        ],
      ),
    );
  }
}
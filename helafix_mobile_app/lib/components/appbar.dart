import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  //const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override 
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AppBar(

      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            themeProvider.isDarkMode ? 'assets/images/logo_bg_dark.png' : 'assets/images/logo_bg_light.png',
            height: 60, // Adjust height
          )
        ],
      ),

      actions: [
        IconButton(
          icon: Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
          onPressed: () {
            themeProvider.toggleTheme(); // Toggle theme when pressed
          },
        ),
      ],
      
    );
  }
}
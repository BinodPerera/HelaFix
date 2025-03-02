import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../theme/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  //const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override 
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AppBar(
      backgroundColor: themeProvider.isDarkMode ? AppColours.primaryDark : AppColours.primaryLight,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            themeProvider.isDarkMode ? 'assets/images/logo_dark.png' : 'assets/images/logo_light.png',
            height: 60, // Adjust height
          )
        ],
      ),

      actions: [
        IconButton(
          icon: Icon(
            themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            color: themeProvider.isDarkMode ? AppColours.dark : AppColours.light,
          ),
          onPressed: () {
            themeProvider.toggleTheme(); // Toggle theme when pressed
          },
        ),
      ],
      
    );
  }
}
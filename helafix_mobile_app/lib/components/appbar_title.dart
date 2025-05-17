import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:provider/provider.dart';

class AppbarWithTitle extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final bool showBackButton;
  final bool showModeButton;

  const AppbarWithTitle({
    Key? key,
    required this.title,
    this.showModeButton = false,
    this.showBackButton = true,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AppBar(
      backgroundColor: themeProvider.isDarkMode ? AppColours.navBarLightColor1 : AppColours.navBarLightColor1,
      title: Text(
        title,
        style: TextStyle(
          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,

      iconTheme: IconThemeData(
        color: themeProvider.isDarkMode ? AppColours.dark : AppColours.light,
      ),

      actions: [
        if (showModeButton)
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
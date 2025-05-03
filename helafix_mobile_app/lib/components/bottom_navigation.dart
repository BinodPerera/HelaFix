import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomBottomNavBar extends StatelessWidget {
  final Function(int) onItemTapped;

  const CustomBottomNavBar({super.key, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    return BottomNavigationBar(
        backgroundColor: themeProvider.isDarkMode ? AppColours.navBarDarkColor2 : AppColours.navBarLightColor2,
        items: [
          BottomNavigationBarItem(
            icon: Icon( 
              Icons.home,
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark,
            ),
            label: 'Bookmarks',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.person
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: themeProvider.isDarkMode ? AppColours.secondaryTextDark : AppColours.secondaryTextLight,
        unselectedItemColor: themeProvider.isDarkMode ? AppColours.secondaryTextLight : AppColours.secondaryTextDark,
        currentIndex: 0, // Set the current index to 'Profile'
        onTap: (index) {
          // Handle navigation based on the selected index
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } 
          else if (index == 1) {
            Navigator.pushNamed(context, '/bookmarks');
          }
          else if (index == 2) {
            Navigator.pushNamed(context, '/profile');
          }
        },
      );
  }
}

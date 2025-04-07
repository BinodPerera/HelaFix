import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/bottomNavigation.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../theme/colors.dart';
import 'package:helafix_mobile_app/components/appbar.dart';

class Myactivities extends StatefulWidget {
  const Myactivities({super.key});

  @override
  State<Myactivities> createState() => _MyactivitiesState();
}

class _MyactivitiesState extends State<Myactivities> {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode ? AppColours.backgroundGradientDark : AppColours.backgroundGradientLight,
        ),
      ),

      bottomNavigationBar: CustomBottomNavBar(onItemTapped: (index) {
        if (index == 0) {
          Navigator.pushNamed(context, '/home');
        } else if (index == 1) {
          Navigator.pushNamed(context, '/bookmarks');
        }
      }),
      
    );
  }
}
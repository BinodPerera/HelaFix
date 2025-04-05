import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme_provider.dart';
import '../theme/colors.dart';
import '../components/appbar.dart';
import '../components/bottomNavigation.dart';

class RecentActivities extends StatelessWidget {
  const RecentActivities({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? AppColours.primaryDark : AppColours.primaryLight,
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  'Recent Activities', 
                  style: TextStyle(
                    color: themeProvider.isDarkMode ? AppColours.dark : AppColours.light, 
                    fontSize: 25, fontWeight: FontWeight.bold)
                ),
              ),

              ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'Service Requested',
                      style: TextStyle(
                        color: themeProvider.isDarkMode ? AppColours.dark : AppColours.light,
                      ),
                    ),
                    subtitle: Text(
                      'Service Name',
                      style: TextStyle(
                        color: themeProvider.isDarkMode ? AppColours.dark : AppColours.light,
                      ),
                    ),
                    trailing: Text(
                      '2021-09-01',
                      style: TextStyle(
                        color: themeProvider.isDarkMode ? AppColours.dark : AppColours.light,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
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
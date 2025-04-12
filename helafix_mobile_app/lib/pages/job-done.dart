import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/bottomNavigation.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../theme/colors.dart';
import 'package:helafix_mobile_app/components/appbar.dart';

class JobDone extends StatelessWidget {
  const JobDone({Key? key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    int currentStep = 1; // This is a static value for now, modify it as needed.

    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: themeProvider.isDarkMode ? AppColours.primaryDark : AppColours.primaryLight,
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode ? AppColours.backgroundGradientDark : AppColours.backgroundGradientLight,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              Container(
                padding: EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 1; i <= 3; i++) ...[
                      CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            i < currentStep ? Colors.green : Colors.white,
                        child: Text(
                          '$i',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (i != 3)
                        Container(
                          width: 40,
                          height: 2,
                          color: Colors.black,
                        ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/bookmarks');
          }
        },
      ),
    );
  }
}

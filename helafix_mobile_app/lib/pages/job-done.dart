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
    int currentStep = 1;

    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: themeProvider.isDarkMode? AppColours.primaryDark: AppColours.primaryLight,
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode? AppColours.backgroundGradientDark: AppColours.backgroundGradientLight,
        ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(70),
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
              Container(
                padding: EdgeInsets.all(40),
                child: Text(
                  'Service Provider Confirmation',
                  style: TextStyle(
                    color: themeProvider.isDarkMode
                        ? AppColours.dark
                        : AppColours.light,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(40),
                child: Text(
                  'Waiting for service provider response.....',
                  style: TextStyle(
                    color: themeProvider.isDarkMode
                        ? AppColours.dark
                        : AppColours.light,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(),
              ),
              Container(
                padding: EdgeInsets.all(40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 0, 0, 0), backgroundColor: const Color.fromRGBO(217, 217, 217, 1), 
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Button was clicked!')),
                    );
                  },
                  child: Text('Special Inquiries',
                  style: TextStyle(
                    color: themeProvider.isDarkMode ? AppColours.dark : AppColours.light,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
            ],
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

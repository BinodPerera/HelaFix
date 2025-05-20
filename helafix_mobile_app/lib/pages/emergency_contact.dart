import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/bottom_navigation.dart';
import 'package:provider/provider.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/components/appbar_title.dart';

// import components
import '../components/appbar.dart';

class EmergencyContact extends StatelessWidget{
  const EmergencyContact({super.key});


  @override
  Widget build(BuildContext context){
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(

      backgroundColor: themeProvider.isDarkMode ? AppColours.primaryDark : AppColours.primaryLight,

      appBar: AppbarWithTitle(title: 'Emergency Contact'),

      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode ? AppColours.backgroundGradientDark : AppColours.backgroundGradientLight,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),

        // ignore: sort_child_properties_last
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

        
          children: [
            Text(
              'For Your Safety',
              style: TextStyle(
                color: themeProvider.isDarkMode ? Color.fromARGB(255, 255, 255, 255) : Color.fromARGB(255, 0, 0, 0),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              
              ),
              
            ),

            const SizedBox(height: 20),


            Text(
              'Send Alerts to our near gent in case of an Emergency',
              style: TextStyle(
                fontSize: 16,
                color: themeProvider.isDarkMode ? Color.fromARGB(255, 136, 130, 130) : Color.fromARGB(255, 109, 95, 95),
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

           Container(
          width: 300,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Alert Our Agent'),
            style: ElevatedButton.styleFrom(
              side: BorderSide(
                color: themeProvider.isDarkMode ? Color.fromARGB(255, 45, 210, 51) : Color.fromARGB(255, 156, 234, 160),
                width: 3,
              ),
              backgroundColor: themeProvider.isDarkMode ? const Color.fromARGB(255, 4, 111, 8) : const Color.fromARGB(255, 28, 206, 120),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              minimumSize: Size(80, 50), // Default size
            ),
          ),
        ),
          ],

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
import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/appbar_title.dart';
import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:provider/provider.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final textColor = themeProvider.isDarkMode ? Colors.white : Colors.white;

    return Scaffold(
      appBar: AppbarWithTitle(title: 'Terms & Conditions', showModeButton: true),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode
              ? AppColours.backgroundGradientDark
              : AppColours.backgroundGradientLight,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode
                      ? Color.fromARGB(255, 21, 0, 50)
                      : Color.fromARGB(255, 0, 183, 255),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Image.asset(
                    themeProvider.isDarkMode
                        ? 'assets/images/logo_dark.png'
                        : 'assets/images/logo_light.png',
                    height: 80,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Terms Introduction
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode
                      ? Color.fromARGB(255, 21, 0, 50)
                      : Color.fromARGB(255, 0, 183, 255),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Introduction',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Welcome to HelaFix! By using our app, you agree to the following terms and conditions. Please read them carefully.',
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // User Responsibilities
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode
                      ? Color.fromARGB(255, 21, 0, 50)
                      : Color.fromARGB(255, 0, 183, 255),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Responsibilities',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '• You must provide accurate information when registering.\n'
                      '• You agree to use the services only for lawful purposes.\n'
                      '• You are responsible for maintaining the confidentiality of your account.',
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Service Provider Conduct
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode
                      ? Color.fromARGB(255, 21, 0, 50)
                      : Color.fromARGB(255, 0, 183, 255),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Service Provider Conduct',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '• Providers must ensure timely and quality service.\n'
                      '• Misconduct or fraudulent activity will result in account suspension.',
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Liability
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode
                      ? Color.fromARGB(255, 21, 0, 50)
                      : Color.fromARGB(255, 0, 183, 255),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Limitation of Liability',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'HelaFix is not responsible for any direct, indirect, incidental, or consequential damages that may result from the use of our services.',
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Changes to Terms
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode
                      ? Color.fromARGB(255, 21, 0, 50)
                      : Color.fromARGB(255, 0, 183, 255),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Changes to Terms',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'We reserve the right to update these terms at any time. Continued use of the app means you accept the updated terms.',
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Contact
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode
                      ? Color.fromARGB(255, 21, 0, 50)
                      : Color.fromARGB(255, 0, 183, 255),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Us',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'If you have any questions or concerns about these Terms & Conditions, feel free to contact us at support@helafix.lk.',
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

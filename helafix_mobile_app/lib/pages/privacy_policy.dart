import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/appbar_title.dart';
import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final textColor = themeProvider.isDarkMode ? Colors.white : Colors.white;

    return Scaffold(
      appBar: AppbarWithTitle(title: 'Privacy Policy', showModeButton: true),
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
                  children: [
                    Center(
                      child: Image.asset(
                        themeProvider.isDarkMode
                            ? 'assets/images/logo_dark.png'
                            : 'assets/images/logo_light.png',
                        height: 80,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
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
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'At HelaFix, we take your privacy seriously. This Privacy Policy explains how we collect, use, and protect your personal information when you use our services.',
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
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
                      'What We Collect',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '• Personal information (name, phone number, email)\n'
                      '• Location data for service accuracy\n'
                      '• Usage data to improve our app experience',
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
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
                      'How We Use It',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '• To provide, operate, and maintain our services\n'
                      '• To notify you about changes or updates\n'
                      '• To improve customer support and service delivery\n'
                      '• To ensure security and prevent fraud',
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
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
                      'Your Rights',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '• You can request access to or deletion of your data\n'
                      '• You can opt-out of location tracking anytime\n'
                      '• You can update your preferences via account settings',
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
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
                      'If you have any questions or concerns about our Privacy Policy, please contact us at:\n\nsupport@helafix.lk',
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

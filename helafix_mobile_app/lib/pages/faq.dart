import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/appbar_title.dart';
import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:provider/provider.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  final List<Map<String, String>> faqList = const [
    {
      'question': 'What is HelaFix?',
      'answer': 'HelaFix is a mobile platform that connects users with professional service providers for home repairs, installations, and more.'
    },
    {
      'question': 'How do I book a service?',
      'answer': 'Simply browse services, select a provider, pick a date/time, and confirm the booking via the app.'
    },
    {
      'question': 'Is there a cancellation fee?',
      'answer': 'You can cancel bookings up to 24 hours in advance without a fee. Late cancellations may incur charges.'
    },
    {
      'question': 'How can I become a service provider?',
      'answer': 'Register as a provider in the app and submit your credentials. Our team will verify and activate your profile.'
    },
    {
      'question': 'How do I make a payment?',
      'answer': 'Payments can be made securely through the app using your preferred payment method.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final textColor = themeProvider.isDarkMode ? Colors.white : Colors.white;
    final tileColor = themeProvider.isDarkMode
        ? const Color.fromARGB(255, 21, 0, 50)
        : const Color.fromARGB(255, 0, 183, 255);

    return Scaffold(
      appBar: AppbarWithTitle(title: 'FAQs', showModeButton: true),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode
              ? AppColours.backgroundGradientDark
              : AppColours.backgroundGradientLight,
        ),
        child: ListView(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: tileColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Icon(Icons.help_outline, color: textColor, size: 40),
                  const SizedBox(height: 10),
                  Text(
                    'Frequently Asked Questions',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Get quick answers to the most common questions from our users.',
                    style: TextStyle(fontSize: 16, color: textColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // FAQ List
            ...faqList.map((faq) {
              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: tileColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    title: Text(
                      faq['question']!,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textColor),
                    ),
                    iconColor: textColor,
                    collapsedIconColor: textColor,
                    children: [
                      Text(
                        faq['answer']!,
                        style: TextStyle(fontSize: 16, color: textColor.withOpacity(0.9)),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:provider/provider.dart';

class Changelanguage extends StatefulWidget {
  const Changelanguage({super.key});

  @override
  State<Changelanguage> createState() => _ChangelanguageState();
}

class _ChangelanguageState extends State<Changelanguage> {
  String _selectedLanguage = 'English';
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Language', 
          style: TextStyle(
            color: themeProvider.isDarkMode ? AppColours.light : AppColours.dark,
          ),
        ),
        backgroundColor: themeProvider.isDarkMode ? AppColours.navBarLightColor1 : AppColours.navBarDarkColor1,
        actions: [
          IconButton(
            icon: themeProvider.isDarkMode ? Icon(Icons.dark_mode) : Icon(Icons.light_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode ? AppColours.backgroundGradientDark : AppColours.backgroundGradientLight,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            RadioListTile(
              title: Text('English'),
              tileColor: Colors.white,
              value: 'English',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text('Sinhala'),
              value: 'Sinhala',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text('Tamil'),
              value: 'Tamil',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value.toString();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
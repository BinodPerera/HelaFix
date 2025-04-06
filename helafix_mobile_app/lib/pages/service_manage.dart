import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme_provider.dart';

import '../theme/colors.dart';

// importing components
import '../components/appbar.dart';

class ManageService extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(

      backgroundColor: themeProvider.isDarkMode ? AppColours.primaryDark : AppColours.primaryLight,

      appBar: CustomAppBar(),

      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}
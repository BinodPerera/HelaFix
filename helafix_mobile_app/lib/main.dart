import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/pages/change_language.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';



// importing pages from pages folder
import './pages/pages.dart';
import './pages/login.dart';
import './pages/register.dart';
import './pages/home.dart'; 
import './pages/profile.dart';
import './pages/service_manage.dart';
import './pages/service_add.dart';
import './pages/recent_activities.dart';
import 'pages/my_activities.dart';
import './pages/profile_details.dart';
import 'package:helafix_mobile_app/pages/change_password.dart';
import 'package:helafix_mobile_app/pages/category_pages/home_page_cat.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Pages(),
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/profile': (context) => Profile(),
        '/home':(context) => HelaFixPage(),
        '/add_service':(context) => AddService(),
        '/manage_service':(context) => ManageService(),
        '/recent_activities':(context) => RecentActivities(),
        '/my_activities':(context) => Myactivities(),
        '/profile_details':(context) => ProfileDetails(),
        '/change_password': (context) => ChangePassword(),
        '/change_language': (context) => Changelanguage(),
        '/HomePageCat': (context) => HomePageCat(),
      }
    );
  }
}
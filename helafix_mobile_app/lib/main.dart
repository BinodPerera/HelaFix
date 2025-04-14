import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';



// importing pages from pages folder
import './pages/pages.dart';
import './pages/login.dart';
import './pages/register.dart';
import './pages/home.dart'; 

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
        '/home': (context) => HelaFixPage(),
        '/login': (context) => Login(),
        '/register': (context) => Register()
      }
    );
  }
}
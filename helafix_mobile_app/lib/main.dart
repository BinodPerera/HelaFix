import 'package:flutter/material.dart';

// importing pages from pages folder
import './pages/pages.dart';
import './pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Pages(),
        '/login': (context) => Login()
      }
    );
  }
}
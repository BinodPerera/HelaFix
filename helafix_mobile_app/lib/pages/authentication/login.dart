import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/services/auth_service.dart';

import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:provider/provider.dart';

import 'package:helafix_mobile_app/theme/colors.dart';

import 'package:helafix_mobile_app/components/appbar.dart';
import 'package:helafix_mobile_app/components/loading_screen.dart';
import 'package:helafix_mobile_app/components/custom_textinput.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();

  bool _loading = false;

  void _login() async {
    setState(() => _loading = true);
    String? result = await authService.loginUser(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    setState(() => _loading = false);

    if (result == null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
    }
  }

  void _loginWithGoogle() async {
    setState(() => _loading = true);
    String? result = await authService.signInWithGoogle();
    setState(() => _loading = false);

    if (result == null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColours.primaryDark : AppColours.primaryLight,
      appBar: CustomAppBar(),
      body: _loading
          ? loadingScreen(isDarkMode: isDark)
          : Container(
              decoration: BoxDecoration(
                gradient: isDark ? AppColours.backgroundGradientDark : AppColours.backgroundGradientLight,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  SizedBox(height: 70),
                  Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColours.primaryTextDark : AppColours.primaryTextLight,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 35),
                  customTextInput(controller: emailController, hintText: 'Email', icon: Icons.email, isDarkMode: isDark, isEmail: true),
                  SizedBox(height: 25),
                  customTextInput(controller: passwordController, hintText: 'Password', icon: Icons.password, isDarkMode: isDark, isPassword: true),
                  SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: isDark ? AppColours.primaryBtnTextDark : AppColours.primaryBtnTextLight,
                        backgroundColor: isDark ? AppColours.primaryBtnDark : AppColours.primaryBtnLight,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      ),
                      child: Text('Sign In', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(height: 85),
                  Text(
                    'Need to create an Account?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark ? AppColours.primaryTextDark : AppColours.primaryTextLight,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    }, 
                    child: Text('Create Account')
                  ),
                  Divider(
                    color: isDark ? Colors.white : Colors.black,
                    thickness: 1,
                    height: 50,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: _loginWithGoogle,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/google.png', height: 30),
                          SizedBox(width: 10),
                          Text('Login with Google', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

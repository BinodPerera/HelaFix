import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../select_location_page.dart';
import '../../theme/colors.dart';

import '../../components/appbar.dart';
import '../../components/custom_textinput.dart';
import '../../components/loading_screen.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final authService = AuthService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController(); // ✅ Added

  bool _loading = false;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);

      String? result = await authService.registerUser(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        password: passwordController.text.trim(),
      );

      setState(() => _loading = false);

      if (result == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => SelectLocationPage()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Your Account Created! Please select your location')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    return Scaffold(
      appBar: CustomAppBar(),
      body: _loading
          ? loadingScreen(isDarkMode: isDark)
          : Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: themeProvider.isDarkMode ? AppColours.backgroundGradientDark : AppColours.backgroundGradientLight,
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(height: 70),
                    Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),

                    SizedBox(height: 30),
                    customTextInput(controller: nameController, hintText: 'Name', icon: Icons.person, isDarkMode: themeProvider.isDarkMode),
                    SizedBox(height: 20),
                    customTextInput(controller: emailController, hintText: 'Email', icon: Icons.email, isDarkMode: themeProvider.isDarkMode, isEmail: true),
                    SizedBox(height: 20),
                    customTextInput(controller: phoneController, hintText: 'Mobile', icon: Icons.phone, isDarkMode: themeProvider.isDarkMode, isPhone: true),
                    SizedBox(height: 20),
                    customTextInput(controller: passwordController, hintText: 'Password', icon: Icons.password, isDarkMode: themeProvider.isDarkMode, isPassword: true),
                    SizedBox(height: 20),
                    customTextInput( controller: confirmPasswordController, hintText: 'Confirm Password', icon: Icons.password, isDarkMode: themeProvider.isDarkMode, isPassword: true),
                    SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          if (passwordController.text != confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Passwords do not match')),
                            );
                            return;
                          }
                          _register();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: themeProvider.isDarkMode ? AppColours.primaryBtnTextDark : AppColours.primaryBtnTextLight,
                          backgroundColor: themeProvider.isDarkMode ? AppColours.primaryBtnDark : AppColours.primaryBtnLight,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0), // Rounded corners
                          ),
                        ),
                        child: Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'If you have an account?',
                      style: TextStyle(
                        color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      }, 
                      child: Text("Login"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

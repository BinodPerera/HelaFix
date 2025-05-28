import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:helafix_mobile_app/components/custom_textinput.dart';

import 'package:helafix_mobile_app/components/appbar.dart';
import 'package:helafix_mobile_app/pages/provider_home.dart';
import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:provider/provider.dart';

class ProviderLoginUI extends StatefulWidget {
  const ProviderLoginUI({super.key});

  @override
  State<ProviderLoginUI> createState() => _ProviderLoginUIState();
}

class _ProviderLoginUIState extends State<ProviderLoginUI> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  String errorMessage = '';

  Future<void> loginUser() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      // Query Firestore for the provider with the given email
      final query = await FirebaseFirestore.instance
          .collection('service_providers')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        setState(() {
          errorMessage = 'No user found with this email';
          isLoading = false;
        });
        return;
      }

      final providerDoc = query.docs.first;
      final String hashedPassword = providerDoc['password'];

      bool passwordMatches = BCrypt.checkpw(password, hashedPassword);

      if (passwordMatches) {
        // ✅ Send email to ProviderHome along with providerId
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProviderHome(
              email: email,
            ),
          ),
        );
      } else {
        setState(() {
          errorMessage = 'Incorrect password';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Something went wrong. Try again.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: isDark ? AppColours.backgroundGradientDark : AppColours.backgroundGradientLight,
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Text(
                "Provider Login",
                style: TextStyle(
                  color: isDark ? Colors.black : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30,),
              customTextInput(controller: emailController, hintText: 'Email', icon: Icons.mail, isDarkMode: isDark),
              SizedBox(height: 20,),
              customTextInput(controller: passwordController, hintText: 'Password', icon: Icons.password, isDarkMode: isDark),
              const SizedBox(height: 20),
              if (errorMessage.isNotEmpty)
                Text(errorMessage, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 10),
              isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: loginUser,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: isDark ? AppColours.primaryBtnTextDark : AppColours.primaryBtnTextLight,
                          backgroundColor: isDark ? AppColours.primaryBtnDark : AppColours.primaryBtnLight,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        ),
                        child: Text('Sign In', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

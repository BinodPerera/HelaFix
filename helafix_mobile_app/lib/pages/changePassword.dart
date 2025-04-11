import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/bottomNavigation.dart';
import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  void _changePassword() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2)); // simulating network call

    if (_newPasswordController.text.isEmpty || _confirmPasswordController.text.isEmpty) {
      _showSnackBar(
        message: "Please fill in all fields",
        icon: Icons.hourglass_empty,
        color: Colors.red,
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if (_newPasswordController.text == _confirmPasswordController.text) {
      _showSnackBar(
        message: "Password changed successfully!",
        icon: Icons.check_circle,
        color: Colors.green,
      );
    } else {
      _showSnackBar(
        message: "Both passwords are not matching",
        icon: Icons.error,
        color: Colors.red,
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showSnackBar({required String message, required IconData icon, required Color color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Text(message),
          ],
        ),
        backgroundColor: color,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: TextStyle(
            color: themeProvider.isDarkMode ? AppColours.dark : AppColours.light,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: themeProvider.isDarkMode ? AppColours.navBarLightColor1 : AppColours.navBarLightColor1,
        iconTheme: IconThemeData(
          color: themeProvider.isDarkMode ? AppColours.dark : AppColours.light,
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: themeProvider.isDarkMode ? AppColours.dark : AppColours.light,
            ),
            onPressed: () {
              themeProvider.toggleTheme(); // Toggle theme when pressed
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),

        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode ? AppColours.backgroundGradientDark : AppColours.backgroundGradientLight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              'New Password'
            ),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
            ),
            SizedBox(height: 40),

            Text('Confirm Password'),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
            ),
            SizedBox(height: 40),

            _isLoading
                ? CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        _changePassword();
                      },
                      style: ElevatedButton.styleFrom(
            
                        foregroundColor: themeProvider.isDarkMode ? AppColours.primaryBtnTextDark : AppColours.primaryBtnTextLight,
                        backgroundColor: themeProvider.isDarkMode ? AppColours.primaryBtnDark : AppColours.primaryBtnLight,
            
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0), // Rounded corners
                        ),
                      ),
                      child: Text(
                        'Update Password',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(onItemTapped: (index) {}),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../theme/colors.dart';

// import components
import '../components/appbar.dart';

class Login extends StatelessWidget{
  const Login({super.key});


  @override
  Widget build(BuildContext context){
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(

      backgroundColor: themeProvider.isDarkMode ? AppColours.primaryDark : AppColours.primaryLight,

      appBar: CustomAppBar(),



      body: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode ? AppColours.backgroundGradientDark : AppColours.backgroundGradientLight,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            children: [
        
              SizedBox( height: 70),
              
              Center(
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight,
                  ),
                ),
              ),
        
              SizedBox( height: 35),
        
              TextField(
                style: TextStyle(
                  color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight
                ),
                decoration: InputDecoration(
                  hintText: "Email Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0), // Rounded corners
                  ),
                ),
              ),
        
              SizedBox( height: 25),
        
              TextField(
                style: TextStyle(
                  color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight
                ),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(0, 255, 255, 255)),
                    borderRadius: BorderRadius.circular(15.0), // Rounded corners
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.visibility_off,
                    ),
                    onPressed: () {
                      null;
                    },
                  ),
                ),
              ),
        
              SizedBox( height: 25),
        
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // Respond to button press
                  },
                  style: ElevatedButton.styleFrom(
        
                    foregroundColor: themeProvider.isDarkMode ? AppColours.primaryBtnTextDark : AppColours.primaryBtnTextLight,
                    backgroundColor: themeProvider.isDarkMode ? AppColours.primaryBtnDark : AppColours.primaryBtnLight,
        
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Rounded corners
                    ),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
        
              SizedBox( height: 85),
        
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    // Respond to button press
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
        
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    'Create an Account',
                    style: TextStyle(
                      color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
        
              Divider(
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                thickness: 1, height: 50,
              ),
        
        
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // Respond to button press
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color.fromARGB(255, 240, 240, 240),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0), // Rounded corners
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google.png', // Path to your image
                        height: 30, // Adjust height
                      ),
        
                      SizedBox(width: 10),
        
                      Text(
                        'Login with Google', 
                        style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold),
                      ),
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
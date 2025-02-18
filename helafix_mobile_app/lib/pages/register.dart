import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

// importing components
import '../components/appbar.dart';

class Register extends StatelessWidget{
  const Register({super.key});

  @override
  Widget build(BuildContext context){
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(

      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,

      appBar: CustomAppBar(),

      body: Padding(
        padding: EdgeInsets.all(20.0),
        
        child: Column(
          children: [

            SizedBox(height: 30),

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

            SizedBox(height: 20),

            TextField(
              style: TextStyle(
                color: themeProvider.isDarkMode ? Colors.white : Colors.black
              ),
              decoration: InputDecoration(
                hintText: "Email Address",
                hintStyle: TextStyle(
                  //color: themeProvider.isDarkMode ? Colors.white : const Color.fromARGB(255, 60, 55, 55)
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                ),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              style: TextStyle(
                color: themeProvider.isDarkMode ? Colors.white : Colors.black
              ),
              decoration: InputDecoration(
                hintText: "Mobile Number",
                hintStyle: TextStyle(
                  //color: themeProvider.isDarkMode ? Colors.white : const Color.fromARGB(255, 60, 55, 55)
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                ),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              obscureText: true,
              style: TextStyle(
                color: themeProvider.isDarkMode ? Colors.white : Colors.black
              ),
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(
                  //color: themeProvider.isDarkMode ? const Color.fromARGB(255, 206, 174, 174) : const Color.fromARGB(255, 60, 55, 55)
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                ),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              obscureText: true,
              style: TextStyle(
                color: themeProvider.isDarkMode ? Colors.white : Colors.black
              ),
              decoration: InputDecoration(
                hintText: "Confirm Password",
                hintStyle: TextStyle(
                  //color: themeProvider.isDarkMode ? const Color.fromARGB(255, 206, 174, 174) : const Color.fromARGB(255, 60, 55, 55)
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
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
                  foregroundColor: themeProvider.isDarkMode ? const Color.fromARGB(255, 0, 0, 0) : Colors.black,
                  backgroundColor: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0), // Rounded corners
                  ),
                ),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),

            SizedBox( height: 25),

            TextButton(
              onPressed: (){
                Navigator.pushNamed(context, '/login');
              }, 
              child: Text('Already have an account? Sign In')
            ),
            
          ],
        ),
      ),
    );
  }
}
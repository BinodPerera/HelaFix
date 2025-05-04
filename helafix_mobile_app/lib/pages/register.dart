import 'package:flutter/material.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../theme/colors.dart';

// importing components
import '../components/appbar.dart';

class Register extends StatelessWidget{
  Register({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void verifyData(BuildContext context) {
    // Add your verification logic here
    // For example, check if the fields are not empty
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        mobileController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }



    // If everything is fine, navigate to the next page
    Navigator.pushNamed(
      context, '/Addhome',
      arguments: {
        'name': nameController.text,
        'email': emailController.text,
        'mobile': mobileController.text,
        'password': BCrypt.hashpw(passwordController.text, BCrypt.gensalt()),
      },
    );
  }

  @override
  Widget build(BuildContext context){
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(

      backgroundColor: themeProvider.isDarkMode ? AppColours.primaryDark : AppColours.primaryLight,

      appBar: CustomAppBar(),

      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: themeProvider.isDarkMode ? AppColours.backgroundGradientDark : AppColours.backgroundGradientLight,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                controller: nameController,
                style: TextStyle(
                  color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight
                ),
                decoration: InputDecoration(
                  hintText: "Name",
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
                controller: emailController,
                style: TextStyle(
                  color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight
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
                controller: mobileController,
                style: TextStyle(
                  color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight
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
                controller: passwordController,
                obscureText: true,
                style: TextStyle(
                  color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight
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
                controller: confirmPasswordController,
                obscureText: true,
                style: TextStyle(
                  color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight
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
                    verifyData(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: themeProvider.isDarkMode ? AppColours.primaryBtnTextDark : AppColours.primaryBtnTextLight,
                    backgroundColor: themeProvider.isDarkMode ? AppColours.primaryBtnDark : AppColours.primaryBtnLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0), // Rounded corners
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
          
              SizedBox( height: 25),
          
              TextButton(
                onPressed: (){
                  
                }, 
                child: Text(
                  'Already have an account? Sign In',
                  style: TextStyle(
                    color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
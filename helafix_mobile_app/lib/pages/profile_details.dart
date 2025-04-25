import 'dart:io';

import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/appbar.dart';
import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {

  File? _imageFile;

  // Future<void> _pickImage() async {
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _imageFile = File(pickedFile.path);
  //     });
  //   }
  // }
  
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(

        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),

        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode ? AppColours.backgroundGradientDark : AppColours.backgroundGradientLight,
        ),

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              SizedBox(height: 20),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : AssetImage('assets/images/users/user-1.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(Icons.add, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
          
              Text(
                'First Name: ',
                style: TextStyle(
                  fontSize: 16,
                  color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                ),
              ),
          
              SizedBox(height: 20),
          
              Text(
                'Last Name: ',
                style: TextStyle(
                  fontSize: 16,
                  color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                ),
              ),
          
              SizedBox(height: 20),
          
              Text(
                'Email Address: ',
                style: TextStyle(
                  fontSize: 16,
                  color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                ),
              ),
          
              SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Country: ',
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16), // space between fields
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Mobile: ',
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40),

              // adding update button
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
                      borderRadius: BorderRadius.circular(40.0), // Rounded corners
                    ),
                  ),
                  child: Text(
                    'Update',
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
      ),
    );
  }
}
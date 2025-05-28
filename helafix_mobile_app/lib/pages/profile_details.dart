import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/appbar.dart';
import 'package:helafix_mobile_app/components/custom_textinput.dart';
import 'package:helafix_mobile_app/models/user.dart';
import 'package:helafix_mobile_app/services/user_service.dart';
import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ProfileDetails extends StatefulWidget {

  final User user;
  final String? docId;

  const ProfileDetails({
    super.key,
    this.docId,
    required this.user,
  });


  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumController = TextEditingController();
  String? _imageBase64;
  File? _imageFile;
  UserService userService = UserService();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.name;
    emailController.text = widget.user.email;
    mobileNumController.text = widget.user.phone;
    _imageBase64 = widget.user.image_base64;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageBytes = await File(pickedFile.path).readAsBytes();
      setState(() {
        _imageFile = File(pickedFile.path);
        _imageBase64 = base64Encode(imageBytes);
      });
    }
  }

  Future<void> _uploadUser() async {
    try{
      // Update user data
      User updatedUser = User(
        name: nameController.text,
        email: emailController.text,
        phone: mobileNumController.text,
        image_base64: _imageBase64,
      );

      userService.userUpdate(updated_user: updatedUser, userId: widget.user.id.toString());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile updated successfully!"))
      );
      Navigator.pop(context, true);
    } 
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating profile: $e")),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
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
          
              SizedBox(height: 40),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : AssetImage('assets/images/users/default.png'),
                        // : _imageBase64 != null
                        //   ? Image.memory(imageBytes!) as ImageProvider
                        //   : AssetImage('assets/images/users/user-1.png'),
                    ),
                    Positioned(
                    bottom: 0,
                    right: 4,
                    child: GestureDetector(
                      onTap: _pickImage,
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
              SizedBox(height: 40),
          
              customTextInput(controller: nameController, hintText: 'Username', icon: Icons.person, isDarkMode: isDarkMode),
          
              SizedBox(height: 20),

              customTextInput(controller: emailController, hintText: 'Email Address:', icon: Icons.email, isDarkMode: isDarkMode),
          
              SizedBox(height: 20),

              customTextInput(controller: mobileNumController, hintText: 'Mobile Number:', icon: Icons.phone, isDarkMode: isDarkMode),

              SizedBox(height: 40),


              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    _uploadUser();
                  },
                  style: ElevatedButton.styleFrom(
        
                    foregroundColor: themeProvider.isDarkMode ? AppColours.primaryBtnTextDark : AppColours.primaryBtnTextLight,
                    backgroundColor: themeProvider.isDarkMode ? AppColours.primaryBtnDark : AppColours.primaryBtnLight,
        
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0), 
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
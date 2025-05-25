import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

import 'package:helafix_mobile_app/components/custom_textinput.dart';
import 'package:helafix_mobile_app/models/category.dart';
import 'package:helafix_mobile_app/services/category_service.dart';

import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:provider/provider.dart';

import 'package:helafix_mobile_app/components/appbar_title.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {

  final TextEditingController nameController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  CategoryService categoryService = CategoryService();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _insertCategory() async {

    if (_image == null || nameController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
    });
    
    try{
      // Read image as bytes and convert to base64
      List<int> imageBytes = await _image!.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      Category category = Category(
        name: nameController.text,
        imageBase64: base64Image,
      );

      categoryService.insertCategory(category: category);
      nameController.clear();
      _image = null;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Category Added!")),
      );
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Category Not Added!")),
      );
    }
    finally {
      setState(() => _isLoading = false);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    return Scaffold(

      appBar: AppbarWithTitle(title: 'Add Category'),

      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: isDark
            ? AppColours.backgroundGradientDark
            : AppColours.backgroundGradientLight
        ),
        height: double.infinity,
        width: double.infinity,

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              customTextInput(controller: nameController, hintText: 'Category Name', icon: Icons.category, isDarkMode: isDark),
              SizedBox(height: 20),
              
              const SizedBox(height: 10),
              _image == null
              ? ElevatedButton(onPressed: _pickImage, child: Text('pick image'))
              : Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: _image != null
                          ? FileImage(_image!)
                          : AssetImage('assets/images/system/image.png'),
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
              
              SizedBox(height: 30),
              _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _insertCategory,
                    child: const Text('Add Category'),
                  ),
            ],
          ),
        ),

      ),
    );
  }
}
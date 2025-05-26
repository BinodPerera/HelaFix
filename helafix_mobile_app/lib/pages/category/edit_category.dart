import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/custom_textinput.dart';
import 'package:helafix_mobile_app/models/category.dart';
import 'package:helafix_mobile_app/services/category_service.dart';

import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:helafix_mobile_app/components/appbar_title.dart';

class EditCategory extends StatefulWidget {

  final String docId;
  final Category category;

  const EditCategory({
    super.key,
    required this.docId,
    required this.category,
  });

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {

  final TextEditingController nameController = TextEditingController();
  File? _image;
  String? _imageBase64;
  
  @override
  void initState() {
    super.initState();
    nameController.text = widget.category.name;
    _imageBase64 = widget.category.imageBase64;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageBytes = await File(pickedFile.path).readAsBytes();
      setState(() {
        _image = File(pickedFile.path);
        _imageBase64 = base64Encode(imageBytes);
      });
    }
  }

  Future<void> _updateCategory() async {
    final name = nameController.text.trim();

    if (name.isEmpty || _imageBase64==null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Name and Image required.")),
      );
    }

    final data = {
      'name': name,
      'image_base64': _imageBase64
    };

    await CategoryService.updateCategory(widget.docId, data);

    if (mounted) {
      Navigator.of(context).pop(); // Go back to the manage page
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Category updated")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageBytes = _imageBase64 != null ? base64Decode(_imageBase64!) : null;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    return Scaffold(

      appBar: AppbarWithTitle(title: 'Edit Category'),

      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: isDark
            ? AppColours.backgroundGradientDark
            : AppColours.backgroundGradientLight
        ),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [

            customTextInput(controller: nameController, hintText: "Category Name", icon: Icons.category_sharp, isDarkMode: isDark),       
            const SizedBox(height: 20),

            imageBytes != null
            ? Image.memory(imageBytes, height: 150)
            : const Text("No image selected"),
            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text("Select New Image"),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: _updateCategory,
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
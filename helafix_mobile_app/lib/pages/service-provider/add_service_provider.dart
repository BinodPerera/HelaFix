import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:helafix_mobile_app/components/appbar_title.dart';
import 'package:helafix_mobile_app/components/custom_textinput.dart';

class AddServiceProvider extends StatefulWidget {
  const AddServiceProvider({super.key});

  @override
  State<AddServiceProvider> createState() => _AddServiceProviderState();
}

class _AddServiceProviderState extends State<AddServiceProvider> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<void> _uploadServiceProvider() async {
    if (_image == null || nameController.text.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      // Read image as bytes and convert to base64
      List<int> imageBytes = await _image!.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      // Add data to Firestore
      await FirebaseFirestore.instance.collection('service_providers').add({
        'name': nameController.text,
        'description': descriptionController.text,
        'image_base64': base64Image,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Service Provider Added")),
      );
      nameController.clear();
      descriptionController.clear();
      setState(() => _image = null);
      Navigator.pushNamed(context, '/manage_service_provider');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    return Scaffold(
      appBar: AppbarWithTitle(
        title: 'Add Service Provider',
        showBackButton: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: isDark
              ? AppColours.backgroundGradientDark
              : AppColours.backgroundGradientLight,
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            customTextInput(
              controller: nameController,
              hintText: 'Service Provider Name',
              icon: Icons.person_2,
              isDarkMode: isDark,
            ),
            const SizedBox(height: 20),
            customTextInput(controller: descriptionController, hintText: 'Description', icon: Icons.description, isDarkMode: isDark),
            const SizedBox(height: 10),
            _image == null
                ? Text("No image selected",
                    style: TextStyle(color: isDark ? Colors.white : Colors.black))
                : Image.file(_image!, height: 150),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text("Select Image"),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _uploadServiceProvider,
                    child: const Text("Add Provider"),
                  ),
          ],
        ),
      ),
    );
  }
}

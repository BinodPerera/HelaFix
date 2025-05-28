import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:bcrypt/bcrypt.dart';

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
  final TextEditingController providerEmailController = TextEditingController();
  final TextEditingController providerPasswordController = TextEditingController();
  final TextEditingController providerConfirmPasswordController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  bool _isLoading = false;

  List<String> _selectedSubcategories = [];

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<void> _uploadServiceProvider() async {
    if (_image == null || nameController.text.isEmpty || providerPasswordController.text.isEmpty || providerConfirmPasswordController.text.isEmpty){
      // showing message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields and select an image")),
      );
      return;
    }

    if (providerPasswordController.text != providerConfirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    };

    setState(() => _isLoading = true);
    try {
      List<int> imageBytes = await _image!.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      await FirebaseFirestore.instance.collection('service_providers').add({
        'name': nameController.text,
        'description': descriptionController.text,
        'image_base64': base64Image,
        'subcategories': _selectedSubcategories,
        'email': providerEmailController.text,
        'password': BCrypt.hashpw(providerPasswordController.text, BCrypt.gensalt()),
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Service Provider Added")),
      );

      nameController.clear();
      descriptionController.clear();
      setState(() {
        _image = null;
        _selectedSubcategories.clear();
      });

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              gradient: isDark
                  ? AppColours.backgroundGradientDark
                  : AppColours.backgroundGradientLight,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      const SizedBox(height: 10),
                      customTextInput(
                        controller: nameController,
                        hintText: 'Service Provider Name',
                        icon: Icons.person_2,
                        isDarkMode: isDark,
                      ),
                      const SizedBox(height: 20),
                      customTextInput(
                        controller: descriptionController,
                        hintText: 'Description',
                        icon: Icons.description,
                        isDarkMode: isDark,
                      ),
                      const SizedBox(height: 20),
                      customTextInput(
                        controller: providerEmailController,
                        hintText: 'Email',
                        icon: Icons.mail,
                        isDarkMode: isDark,
                      ),
                      const SizedBox(height: 20),
                      customTextInput(
                        controller: providerPasswordController,
                        hintText: 'Password',
                        icon: Icons.password,
                        isDarkMode: isDark,
                      ),
                      const SizedBox(height: 20),
                      customTextInput(
                        controller: providerConfirmPasswordController,
                        hintText: 'Confirm Password',
                        icon: Icons.confirmation_num,
                        isDarkMode: isDark,
                      ),
                      
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Select Subcategories:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('sub_categories')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Text("No subcategories available.");
                          }

                          final subcategories = snapshot.data!.docs;

                          return Wrap(
                            spacing: 8,
                            children: subcategories.map((doc) {
                              final subcategoryName = doc['name'];
                              final subcategoryId = doc.id;
                              final isSelected = _selectedSubcategories
                                  .contains(subcategoryId);

                              return FilterChip(
                                label: Text(subcategoryName),
                                selected: isSelected,
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      _selectedSubcategories.add(subcategoryId);
                                    } else {
                                      _selectedSubcategories
                                          .remove(subcategoryId);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      _image == null
                          ? Text("No image selected",
                              style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black))
                          : Image.file(_image!, height: 150),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: const Text("Select Image"),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _uploadServiceProvider,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: const Text("Add Provider"),
                        ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}

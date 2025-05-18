import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';
import 'package:helafix_mobile_app/models/service_provider.dart';
import 'package:helafix_mobile_app/services/service_provider_service.dart';

import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/components/appbar_title.dart';
import 'package:helafix_mobile_app/components/custom_textinput.dart';

class EditServiceProvider extends StatefulWidget {
  final String docId;
  final ServiceProvider provider;

  const EditServiceProvider({
    super.key,
    required this.docId,
    required this.provider,
  });

  @override
  State<EditServiceProvider> createState() => _EditServiceProviderState();
}

class _EditServiceProviderState extends State<EditServiceProvider> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? _image;
  String? _imageBase64;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.provider.name;
    descriptionController.text = widget.provider.description;
    _imageBase64 = widget.provider.imageBase64;
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

  Future<void> _updateProvider() async {
    final name = nameController.text.trim();
    final description = descriptionController.text.trim();

    if (name.isEmpty || _imageBase64 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Name and image are required.")),
      );
      return;
    }

    final data = {
      'name': name,
      'description': description,
      'image_base64': _imageBase64,
    };

    await ServiceProviderService.updateServiceProvider(widget.docId, data);

    if (mounted) {
      Navigator.of(context).pop(); // Go back to the manage page
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Service Provider updated")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageBytes = _imageBase64 != null ? base64Decode(_imageBase64!) : null;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppbarWithTitle(title: 'Edit Service Provider', showModeButton: true,),
      body: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode
            ? AppColours.backgroundGradientDark
            : AppColours.backgroundGradientLight
        ),
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              customTextInput(controller: nameController, hintText: 'Name', icon: Icons.person_2, isDarkMode: themeProvider.isDarkMode),
              const SizedBox(height: 20),
              customTextInput(controller: descriptionController, hintText: 'Description', icon: Icons.description, isDarkMode: themeProvider.isDarkMode),
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProvider,
                child: const Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

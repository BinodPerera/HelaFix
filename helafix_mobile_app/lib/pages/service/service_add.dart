import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/custom_textinput.dart';
import 'package:helafix_mobile_app/models/category.dart';
import 'package:helafix_mobile_app/models/category_sub.dart';
import 'package:helafix_mobile_app/models/service.dart';
import 'package:helafix_mobile_app/models/service_provider.dart';
import 'package:helafix_mobile_app/pages/service/ServiceService.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class InsertServicePage extends StatefulWidget {
  @override
  _InsertServicePageState createState() => _InsertServicePageState();
}

class _InsertServicePageState extends State<InsertServicePage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedCategoryId;
  String? selectedSubCategoryId;
  String? selectedProviderId;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String name = '';
  String description = '';
  String? imageBase64;

  List<Category> categories = [];
  List<SubCategory> subCategories = [];
  List<ServiceProvider> providers = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchProviders();
  }

  Future<void> fetchCategories() async {
    final snapshot = await FirebaseFirestore.instance.collection('categories').get();
    setState(() {
      categories = snapshot.docs.map((doc) => Category.fromMap(doc.data(), doc.id)).toList();
    });
  }

  Future<void> fetchSubCategories(String categoryId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('sub_categories')
        .where('category_id', isEqualTo: categoryId)
        .get();
    setState(() {
      subCategories = snapshot.docs.map((doc) => SubCategory.fromMap(doc.data(), doc.id)).toList();
    });
  }

  Future<void> fetchProviders() async {
    final snapshot = await FirebaseFirestore.instance.collection('service_providers').get();
    setState(() {
      providers = snapshot.docs.map((doc) => ServiceProvider.fromMap(doc.data(), doc.id)).toList();
    });
  }

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        imageBase64 = base64Encode(bytes);
      });
    }
  }

  void submit() async {
    if (_formKey.currentState!.validate() &&
        selectedCategoryId != null &&
        selectedSubCategoryId != null &&
        selectedProviderId != null &&
        imageBase64 != null) {
      _formKey.currentState!.save();

      final newService = Service(
        name: nameController.text,
        description: descriptionController.text,
        imageBase64: imageBase64!,
        categoryId: selectedCategoryId!,
        subCategoryId: selectedSubCategoryId!,
        providerId: selectedProviderId!,
      );

      await ServiceService().insertService(newService);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Service added')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      appBar: AppBar(title: Text('Insert Service')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              customTextInput(controller: nameController, hintText: "Name", icon: Icons.person, isDarkMode: isDarkMode),
              SizedBox(height: 20),
              customTextInput(controller: descriptionController, hintText: "Description", icon: Icons.group, isDarkMode: isDarkMode),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedCategoryId,
                decoration: InputDecoration(labelText: 'Category'),
                items: categories.map((cat) {
                  return DropdownMenuItem(
                    value: cat.id,
                    child: Text(cat.name),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedCategoryId = val;
                    selectedSubCategoryId = null;
                    fetchSubCategories(val!);
                  });
                },
                validator: (val) => val == null ? 'Select category' : null,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedSubCategoryId,
                decoration: InputDecoration(labelText: 'Sub Category'),
                items: subCategories.map((sub) {
                  return DropdownMenuItem(
                    value: sub.id,
                    child: Text(sub.name),
                  );
                }).toList(),
                onChanged: (val) => setState(() => selectedSubCategoryId = val),
                validator: (val) => val == null ? 'Select sub category' : null,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedProviderId,
                decoration: InputDecoration(labelText: 'Service Provider'),
                items: providers.map((prov) {
                  return DropdownMenuItem(
                    value: prov.id,
                    child: Text(prov.name),
                  );
                }).toList(),
                onChanged: (val) => setState(() => selectedProviderId = val),
                validator: (val) => val == null ? 'Select provider' : null,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: submit,
                child: Text('Submit Service'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

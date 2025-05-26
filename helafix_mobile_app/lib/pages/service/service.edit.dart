import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/models/category.dart';
import 'package:helafix_mobile_app/models/category_sub.dart';
import 'package:helafix_mobile_app/models/service.dart';
import 'package:helafix_mobile_app/models/service_provider.dart';
import 'package:helafix_mobile_app/services/ServiceService.dart';
import 'package:image_picker/image_picker.dart';

class EditServicePage extends StatefulWidget {
  final Service service;

  const EditServicePage({super.key, required this.service});

  @override
  State<EditServicePage> createState() => _EditServicePageState();
}

class _EditServicePageState extends State<EditServicePage> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  File? _imageFile;
  String? _base64Image;

  List<ServiceProvider> _providers = [];
  List<Category> _categories = [];
  List<SubCategory> _subCategories = [];

  String? _selectedProviderId;
  String? _selectedCategoryId;
  String? _selectedSubCategoryId;

  bool _isLoading = false;

  final ServiceService _serviceService = ServiceService();

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.service.name);
    _descriptionController = TextEditingController(text: widget.service.description);
    _base64Image = widget.service.imageBase64;
    _selectedProviderId = widget.service.providerId;
    _selectedCategoryId = widget.service.categoryId;
    _selectedSubCategoryId = widget.service.subCategoryId;

    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      _providers = await _serviceService.getServiceProviders();
      _categories = await _serviceService.getCategories();

      if (_selectedCategoryId != null) {
        _subCategories = await _serviceService.getSubCategories(_selectedCategoryId!);
      }

      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to load data")));
    }

    setState(() => _isLoading = false);
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      setState(() {
        _imageFile = File(pickedFile.path);
        _base64Image = base64Encode(imageBytes);
      });
    }
  }

  Future<void> _onCategoryChanged(String? categoryId) async {
    if (categoryId == null) return;

    _selectedCategoryId = categoryId;
    _selectedSubCategoryId = null;
    _subCategories = await _serviceService.getSubCategories(categoryId);

    setState(() {});
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _base64Image == null) return;

    final updatedService = Service(
      id: widget.service.id,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      imageBase64: _base64Image!,
      providerId: _selectedProviderId!,
      categoryId: _selectedCategoryId!,
      subCategoryId: _selectedSubCategoryId!,
    );

    setState(() => _isLoading = true);

    try {
      await _serviceService.updateService(updatedService);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Service updated successfully')));
      Navigator.pop(context, true); // return to previous screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update service')));
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Service")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Service Name
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Service Name'),
                      validator: (value) => value!.isEmpty ? 'Enter a name' : null,
                    ),
                    const SizedBox(height: 16),

                    // Description
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: const InputDecoration(labelText: 'Description'),
                      validator: (value) => value!.isEmpty ? 'Enter a description' : null,
                    ),
                    const SizedBox(height: 16),

                    // Image Picker
                    _imageFile != null
                        ? Image.file(_imageFile!, height: 150)
                        : _base64Image != null
                            ? Image.memory(base64Decode(_base64Image!), height: 150)
                            : const Text("No image selected"),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text("Pick Image"),
                    ),
                    const SizedBox(height: 16),

                    // Provider Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedProviderId,
                      items: _providers
                          .map((p) => DropdownMenuItem(value: p.id, child: Text(p.name)))
                          .toList(),
                      onChanged: (val) => setState(() => _selectedProviderId = val),
                      decoration: const InputDecoration(labelText: 'Service Provider'),
                      validator: (val) => val == null ? 'Select a provider' : null,
                    ),
                    const SizedBox(height: 16),

                    // Category Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedCategoryId,
                      items: _categories
                          .map((c) => DropdownMenuItem(value: c.id, child: Text(c.name)))
                          .toList(),
                      onChanged: _onCategoryChanged,
                      decoration: const InputDecoration(labelText: 'Category'),
                      validator: (val) => val == null ? 'Select a category' : null,
                    ),
                    const SizedBox(height: 16),

                    // Subcategory Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedSubCategoryId,
                      items: _subCategories
                          .map((sc) => DropdownMenuItem(value: sc.id, child: Text(sc.name)))
                          .toList(),
                      onChanged: (val) => setState(() => _selectedSubCategoryId = val),
                      decoration: const InputDecoration(labelText: 'Subcategory'),
                      validator: (val) => val == null ? 'Select a subcategory' : null,
                    ),
                    const SizedBox(height: 24),

                    ElevatedButton(
                      onPressed: _submit,
                      child: const Text("Update Service"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditSubCategory extends StatefulWidget {
  final String subCategoryId;
  final String currentName;
  final String currentCategoryId;

  const EditSubCategory({
    super.key,
    required this.subCategoryId,
    required this.currentName,
    required this.currentCategoryId,
  });

  @override
  State<EditSubCategory> createState() => _EditSubCategoryState();
}

class _EditSubCategoryState extends State<EditSubCategory> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  String? _selectedCategoryId;
  List<Map<String, dynamic>> _categories = [];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.currentName;
    _selectedCategoryId = widget.currentCategoryId;
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('categories')
          .orderBy('name')
          .get();

      setState(() {
        _categories = snapshot.docs
            .map((doc) => {
                  'id': doc.id,
                  'name': doc['name'] ?? 'Unnamed',
                })
            .toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load categories: $e')),
      );
    }
  }

  Future<void> _updateSubCategory() async {
    if (_formKey.currentState!.validate() && _selectedCategoryId != null) {
      try {
        await FirebaseFirestore.instance
            .collection('sub_categories')
            .doc(widget.subCategoryId)
            .update({
          'name': _nameController.text.trim(),
          'category_id': _selectedCategoryId!,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sub-category updated successfully')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Sub-Category')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _categories.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration:
                          const InputDecoration(labelText: 'Sub-Category Name'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Enter a name'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _selectedCategoryId,
                      decoration:
                          const InputDecoration(labelText: 'Select Category'),
                      items: _categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category['id'],
                          child: Text(category['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategoryId = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Please select a category' : null,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _updateSubCategory,
                      child: const Text('Save Changes'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/custom_textinput.dart';
import 'package:helafix_mobile_app/models/category.dart';
import 'package:helafix_mobile_app/services/category_service.dart';

import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
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
  @override
  void initState() {
    super.initState();
    nameController.text = widget.category.name;
  }

  Future<void> _updateCategory() async {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Name is required.")),
      );
    }

    final data = {
      'name': name,
    };

    await CategoryService.updateServiceProvider(widget.docId, data);

    if (mounted) {
      Navigator.of(context).pop(); // Go back to the manage page
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Category updated")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
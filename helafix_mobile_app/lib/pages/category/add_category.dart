import 'package:flutter/material.dart';
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
  CategoryService categoryService = CategoryService();
  bool _isLoading = false;

  Future<void> _insertCategory() async {
    setState(() {
      _isLoading = true;
    });
    try{
      Category category = Category(name: nameController.text);
      categoryService.insertCategory(category: category);
      nameController.clear();
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

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            customTextInput(controller: nameController, hintText: 'Category Name', icon: Icons.category, isDarkMode: isDark),
            
            SizedBox(height: 50),
            _isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: _insertCategory,
                  child: const Text('Add Category'),
                ),
          ],
        ),

      ),
    );
  }
}
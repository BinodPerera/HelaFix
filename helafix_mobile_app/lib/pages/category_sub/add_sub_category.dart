import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helafix_mobile_app/components/custom_textinput.dart';
import 'package:helafix_mobile_app/models/category_sub.dart';
import 'package:helafix_mobile_app/models/category.dart';
import 'package:helafix_mobile_app/services/category_sub_service.dart';

import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:provider/provider.dart';

import 'package:helafix_mobile_app/components/appbar_title.dart';

class AddSubCategory extends StatefulWidget {
  const AddSubCategory({super.key});

  @override
  State<AddSubCategory> createState() => _AddSubCategoryState();
}

class _AddSubCategoryState extends State<AddSubCategory> {

List<Category> categoryList = [];
String? selectedCategoryId;

Future<void> fetchServices() async {
  final snapshot = await FirebaseFirestore.instance.collection('categories').get();

  categoryList = snapshot.docs.map((doc) {
    return Category(
      id: doc.id,
      name: doc['name'],
    );
  }).toList();
}


  @override
  void initState() {
    super.initState();
    fetchServices().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    categoryIdController.dispose(); // ✅ free the memory
    subCategoryNameController.dispose();
    super.dispose();
  }

  final TextEditingController subCategoryNameController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();
  CategorySubService categorySubService = CategorySubService();
  bool _isLoading = false;

  Future<void> _insertSubCategory() async {
    setState(() {
      _isLoading = true;
    });
    try{
      SubCategory subCategory = SubCategory(name: subCategoryNameController.text, categoryId: categoryIdController.text);
      categorySubService.insertSubCategory(subCategory: subCategory);
      subCategoryNameController.clear();
      categoryIdController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sub Category Added!")),
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

      appBar: AppbarWithTitle(title: 'Add Sub-Category'),

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
            customTextInput(controller: subCategoryNameController, hintText: 'Sub-Category Name', icon: Icons.category, isDarkMode: isDark),
            SizedBox(height: 30),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: "Category",
                hintStyle: TextStyle(
                  color: isDark ? Colors.white54 : Colors.black54,
                ),
                prefixIcon: Icon(Icons.data_exploration, color: isDark ? Colors.white : Colors.black),
                filled: true,
                fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              value: selectedCategoryId,
              items: categoryList.map((category) {
                return DropdownMenuItem<String>(
                  value: category.id,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  categoryIdController.text = value ?? '';
                });
              },
              isExpanded: true, // makes it full width
              hint: Text(
                "Select Category",
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              icon: Icon(Icons.arrow_drop_down),
              dropdownColor: Colors.white,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),

            
            SizedBox(height: 50),
            _isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: _insertSubCategory,
                  child: const Text('Add Category'),
                ),
          ],
        ),

      ),
    );
  }
}
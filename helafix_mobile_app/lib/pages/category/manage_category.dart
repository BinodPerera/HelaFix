import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/models/category.dart';
import 'package:helafix_mobile_app/pages/category/edit_category.dart';
import 'package:helafix_mobile_app/services/category_service.dart';

import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:provider/provider.dart';

import 'package:helafix_mobile_app/components/appbar_title.dart';

class ManageCategory extends StatefulWidget {
  const ManageCategory({super.key});

  @override
  State<ManageCategory> createState() => _ManageCategoryState();
}

class _ManageCategoryState extends State<ManageCategory> {
  final TextEditingController nameController = TextEditingController();

  void _confirmDelete(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this service provider?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(ctx).pop(); // Close the dialog
              await CategoryService.deleteServiceProvider(docId);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Service Category deleted")),
              );
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  void _navigateToEditPage(BuildContext context, String docId, Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCategory(docId: docId, category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    return Scaffold(

      appBar: AppbarWithTitle(title: 'Manage Category'),

      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: isDark
            ? AppColours.backgroundGradientDark
            : AppColours.backgroundGradientLight
        ),
        height: double.infinity,
        width: double.infinity,

        child: StreamBuilder<Map<String, Category>>(
            stream: CategoryService.getCategoriesWithIds(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
          
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No service providers found."));
              }
          
              final providerMap = snapshot.data!;
              final providerEntries = providerMap.entries.toList();
          
              return ListView.builder(
                itemCount: providerEntries.length,
                itemBuilder: (context, index) {
                  final docId = providerEntries[index].key;
                  final category = providerEntries[index].value;
          
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(category.name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _navigateToEditPage(context, docId, category),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _confirmDelete(context, docId),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),

      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helafix_mobile_app/pages/category_sub/edit_sub_category.dart';
import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:helafix_mobile_app/components/appbar_title.dart';

class ManageSubCategory extends StatefulWidget {
  const ManageSubCategory({super.key});

  @override
  State<ManageSubCategory> createState() => _ManageSubCategoryState();
}

class _ManageSubCategoryState extends State<ManageSubCategory> {
  final CollectionReference subCategoryCollection =
      FirebaseFirestore.instance.collection('sub_categories');

  Future<void> _deleteSubCategory(String id) async {
    try {
      await subCategoryCollection.doc(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sub-category deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting sub-category: $e')),
      );
    }
  }

  void _confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this sub-category?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _deleteSubCategory(id);
            },
            child: const Text('Yes', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppbarWithTitle(title: 'Manage Sub-Category', showModeButton: true,),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: isDark
              ? AppColours.backgroundGradientDark
              : AppColours.backgroundGradientLight,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: subCategoryCollection.orderBy('name').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No sub-categories found.'));
            }

            final docs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final doc = docs[index];
                final data = doc.data() as Map<String, dynamic>;
                final subCategoryId = doc.id;
                final name = data['name'] ?? 'No Name';
                final categoryId = data['category_id'] ?? 'No Category ID';

                return Card(
                  color: isDark ? Colors.grey[900] : Colors.white,
                  shadowColor: isDark ? Colors.black : Colors.grey.shade300,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      name,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Category ID: $categoryId',
                      style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[800],
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit,
                              color: isDark ? Colors.lightBlueAccent : Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditSubCategory(
                                  subCategoryId: subCategoryId,
                                  currentName: name,
                                  currentCategoryId: categoryId,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDelete(subCategoryId),
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

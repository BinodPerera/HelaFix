import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../theme_provider.dart';
import '../../theme/colors.dart';
import '../../components/bottom_navigation.dart';

class CartDt extends StatefulWidget {
  final String subCategoryId;

  const CartDt({super.key, required this.subCategoryId});

  @override
  State<CartDt> createState() => _CartDtState();
}

class _CartDtState extends State<CartDt> {
  String? categoryName;
  String? subCategoryName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCategoryAndSubCategory();
  }

  Future<void> _fetchCategoryAndSubCategory() async {
    try {
      // Get sub-category document
      final subCatDoc = await FirebaseFirestore.instance
          .collection('sub_categories')
          .doc(widget.subCategoryId)
          .get();

      if (subCatDoc.exists) {
        final subCatData = subCatDoc.data();
        subCategoryName = subCatData?['name'] ?? 'Sub Repair';
        final categoryId = subCatData?['category_id'];

        // Now fetch the parent category
        final catDoc = await FirebaseFirestore.instance
            .collection('categories')
            .doc(categoryId)
            .get();

        if (catDoc.exists) {
          categoryName = catDoc.data()?['name'] ?? 'Repair';
        }
      }
    } catch (e) {
      // Handle error gracefully
      categoryName = 'Repair';
      subCategoryName = 'Sub Repair';
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? AppColours.primaryDark
          : AppColours.primaryLight,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 183, 255),
        title: isLoading
            ? const Text("Loading...")
            : Row(
                children: [
                  Text(
                    categoryName ?? 'Repair',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    subCategoryName ?? 'Sub Repair',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode
              ? AppColours.backgroundGradientDark
              : AppColours.backgroundGradientLight,
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: List.generate(10, (index) => _CompanyCard(context)),
                ),
              ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/bookmarks');
          }
        },
      ),
    );
  }
}

Widget _CompanyCard(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, '/Sp-details');
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/damro_logo.jpg',
                width: 100,
                height: 60,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 247, 247, 247),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Damro Company PVT LTD',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            _serviceIcon('assets/images/cleaning.png'),
                            const SizedBox(width: 6),
                            _serviceIcon('assets/images/maintenance.png'),
                            const SizedBox(width: 6),
                            _serviceIcon('assets/images/repair.png'),
                          ],
                        ),
                        Row(
                          children: List.generate(
                            5,
                            (index) => const Icon(Icons.star,
                                color: Colors.amber, size: 18),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _serviceIcon(String path) {
  return Image.asset(
    path,
    width: 20,
    height: 20,
    fit: BoxFit.contain,
  );
}

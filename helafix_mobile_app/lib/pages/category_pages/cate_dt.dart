import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../models/service_provider.dart';
import '../../theme_provider.dart';
import '../../theme/colors.dart';
import '../../components/bottom_navigation.dart';
import '../sp-details.dart'; // Make sure this import path is correct

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
  List<ServiceProvider> filteredProviders = [];

  @override
  void initState() {
    super.initState();
    _fetchCategoryAndSubCategory();
    _fetchServiceProviders();
  }

  Future<void> _fetchCategoryAndSubCategory() async {
    try {
      final subCatDoc = await FirebaseFirestore.instance
          .collection('sub_categories')
          .doc(widget.subCategoryId)
          .get();

      if (subCatDoc.exists) {
        final subCatData = subCatDoc.data();
        subCategoryName = subCatData?['name'] ?? 'Sub Repair';
        final categoryId = subCatData?['category_id'];

        final catDoc = await FirebaseFirestore.instance
            .collection('categories')
            .doc(categoryId)
            .get();

        if (catDoc.exists) {
          categoryName = catDoc.data()?['name'] ?? 'Repair';
        }
      }
    } catch (e) {
      categoryName = 'Repair';
      subCategoryName = 'Sub Repair';
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _fetchServiceProviders() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('service_providers')
          .get();

      final providers = snapshot.docs.map((doc) {
        return ServiceProvider.fromMap(doc.data(), doc.id);
      }).where((sp) => sp.subcategories.contains(widget.subCategoryId)).toList();

      setState(() {
        filteredProviders = providers;
      });
    } catch (e) {
      print("Error fetching service providers: $e");
    }
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
            : filteredProviders.isEmpty
                ? const Center(child: Text('No service providers found.'))
                : ListView.builder(
                    itemCount: filteredProviders.length,
                    itemBuilder: (context, index) {
                      final provider = filteredProviders[index];
                      return _CompanyCard(context, provider);
                    },
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

  Widget _CompanyCard(BuildContext context, ServiceProvider provider) {
    final imageBytes = provider.imageBytes;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpDetails(serviceProvider: provider),
          ),
        );
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
                child: imageBytes != null
                    ? Image.memory(
                        imageBytes,
                        width: 100,
                        height: 60,
                        fit: BoxFit.contain,
                      )
                    : const Icon(Icons.image_not_supported, size: 60),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
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
                      Text(
                        provider.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _serviceIcon('assets/images/cleaning.png'),
                          const SizedBox(width: 6),
                          _serviceIcon('assets/images/maintenance.png'),
                          const SizedBox(width: 6),
                          _serviceIcon('assets/images/repair.png'),
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
}

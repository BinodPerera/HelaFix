import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helafix_mobile_app/models/service_sub.dart';
import 'package:provider/provider.dart';
import 'package:helafix_mobile_app/models/service_provider.dart';
import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:helafix_mobile_app/components/bottom_navigation.dart';

class SpDetails extends StatefulWidget {
  final ServiceProvider serviceProvider;

  const SpDetails({super.key, required this.serviceProvider});

  @override
  State<SpDetails> createState() => _SpDetailsState();
}

class _SpDetailsState extends State<SpDetails> {
  String _title = 'Services';

  Future<String> getSubCategoryName(String id) async {
    final doc = await FirebaseFirestore.instance
        .collection('sub_categories')
        .doc(id)
        .get();

    if (doc.exists) {
      final subCategory = ServiceSubCategory.fromMap(doc.data()!, doc.id);
      return subCategory.name;
    } else {
      return 'Unknown Subcategory';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final sp = widget.serviceProvider;
    final imageBytes = base64Decode(sp.imageBase64);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? AppColours.primaryDark
          : AppColours.primaryLight,
      appBar: AppBar(
        title: const Text(
          'Service Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 183, 255),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode
              ? AppColours.backgroundGradientDark
              : AppColours.backgroundGradientLight,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.memory(
                                  imageBytes,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sp.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 109, 189, 255),
                                      minimumSize: const Size(80, 30),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      textStyle: const TextStyle(fontSize: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    child: const Text(
                                      'Add to Bookmark',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _title = _title == 'Services'
                                        ? 'Ratings'
                                        : 'Services';
                                  });
                                },
                                child: const Text('90% Positive ratings'),
                              ),
                              const Text('980 Followers'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          sp.description,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Text(
                      _title,
                      style: TextStyle(
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _title == 'Services'
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: sp.subcategories.length,
                          itemBuilder: (context, index) {
                            final subcatId = sp.subcategories[index];
                            return FutureBuilder<String>(
                              future: getSubCategoryName(subcatId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const ListTile(
                                      title: Text('Loading...'));
                                } else if (snapshot.hasError) {
                                  return const ListTile(
                                      title: Text('Error loading subcategory'));
                                } else {
                                  return ExpansionTile(
                                    title: Text(snapshot.data ?? 'Unknown'),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 30, 255, 0),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 45, vertical: 10),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/Booking',
                                              arguments: {
                                                'providerId': sp.id,
                                                'subCategoryId': subcatId,
                                              },
                                            );
                                          },
                                          child: const Text(
                                            'Book here',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            );
                          },
                        )
                      : const Text("Ratings content coming soon..."),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(onItemTapped: (index) {
        if (index == 0) {
          Navigator.pushNamed(context, '/home');
        } else if (index == 1) {
          Navigator.pushNamed(context, '/bookmarks');
        }
      }),
    );
  }
}

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/models/category.dart';
import 'package:helafix_mobile_app/pages/category_pages/home_page_cat.dart';
import 'package:helafix_mobile_app/services/category_service.dart';
import 'package:provider/provider.dart';
import '../components/bottom_navigation.dart';
import '../theme_provider.dart';
import '../theme/colors.dart';

class HelaFixPage extends StatefulWidget {
  const HelaFixPage({super.key});

  @override
  State<HelaFixPage> createState() => _HelaFixPageState();
}

class _HelaFixPageState extends State<HelaFixPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? AppColours.primaryDark
          : AppColours.primaryLight,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 0, 183, 255),
        elevation: 0,
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Image.asset(
            'assets/images/logo_light.png',
            height: 55,
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode
              ? AppColours.backgroundGradientDark
              : AppColours.backgroundGradientLight,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Experts here.....',
                    filled: true,
                    fillColor: themeProvider.isDarkMode
                        ? Colors.grey[800]
                        : Colors.white,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              // Categories
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Categories',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),

              SizedBox(
                height: 100,
                child: StreamBuilder<Map<String, Category>>(
                  stream: CategoryService.getCategoriesWithIds(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No categories found.'));
                    }

                    final categoryEntries = snapshot.data!.entries.toList();

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      itemCount: categoryEntries.length,
                      itemBuilder: (context, index) {
                        final categoryId = categoryEntries[index].key;
                        final category = categoryEntries[index].value;

                        // Decode base64 image
                        final imageBytes = base64Decode(category.imageBase64);

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePageCat(categoryId: categoryId),
                            ),
                          );
                          },
                          child: Container(
                            width: 80,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.memory(
                                    imageBytes,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  category.name,
                                  style: TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
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
              SizedBox(height: 20),


              // Popular Experts
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Popular Experts',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),

              ExpertTile(
                companyLogo: 'assets/images/damro.png',
                companyName: 'Damro Company PVT LTD',
                categoryImage: [
                  'assets/images/repair.png',
                  'assets/images/optimizing.png',
                ],
                rating: 5,
                onTap: () {
                  Navigator.pushNamed(context, '/Sp-details');
                },
              ),

              ExpertTile(
                companyLogo: 'assets/images/Arpico.png',
                companyName: 'Pioneer Cleaning',
                categoryImage: ['assets/images/clean-code.png'],
                rating: 4,
                onTap: () {
                  Navigator.pushNamed(context, '/Sp-details');
                },
              ),
              ExpertTile(
                companyLogo: 'assets/images/Arpico.png',
                companyName: 'Softlogic Holdings PLC',
                categoryImage: [
                  'assets/images/repair.png',
                  'assets/images/optimizing.png',
                  'assets/images/clean-code.png'
                ],
                rating: 4,
                onTap: () {
                  Navigator.pushNamed(context, '/Sp-details');
                },
              ),
              ExpertTile(
                companyLogo: 'assets/images/damro.png',
                companyName: 'Damro Company PVT LTD',
                categoryImage: [
                  'assets/images/repair.png',
                  'assets/images/optimizing.png'
                ],
                rating: 5,
                onTap: () {
                  Navigator.pushNamed(context, '/Sp-details');
                },
              ),
              ExpertTile(
                companyLogo: 'assets/images/damro.png',
                companyName: 'Damro Company PVT LTD',
                categoryImage: [
                  'assets/images/repair.png',
                  'assets/images/optimizing.png'
                ],
                rating: 5,
                onTap: () {
                  Navigator.pushNamed(context, '/Sp-details');
                },
              ),

              // Ongoing Activities
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Text('Recent On-Going Activities',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/Activejob');
                },
                child: const ActivityCard(
                  serviceFlow: 'Cleaning > Home Cleaning > Deep Cleaning',
                  logo: 'assets/images/damro.png',
                  serviceName: 'Damro Cleaning Service',
                  date: '02/02/2025',
                  cost: 'COST NEGOTIABLE',
                  status: 'Active',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/Activejob');
                },
                child: const ActivityCard(
                  serviceFlow: 'Cleaning > Home Cleaning > Deep Cleaning',
                  logo: 'assets/images/damro.png',
                  serviceName: 'Damro Cleaning Service',
                  date: '02/02/2025',
                  cost: 'COST NEGOTIABLE',
                  status: 'Active',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/Activejob');
                },
                child: const ActivityCard(
                  serviceFlow: 'Cleaning > Home Cleaning > Deep Cleaning',
                  logo: 'assets/images/damro.png',
                  serviceName: 'Damro Cleaning Service',
                  date: '02/02/2025',
                  cost: 'COST NEGOTIABLE',
                  status: 'Active',
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
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

// Category Icon
class CategoryIcon extends StatelessWidget {
  final String imagePath;
  final String label;

  const CategoryIcon({required this.imagePath, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).cardColor,
          radius: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

// Expert Tile
class ExpertTile extends StatelessWidget {
  final String companyLogo;
  final String companyName;
  final List<String> categoryImage;
  final int rating;
  final VoidCallback? onTap; // ✅ Add this

  const ExpertTile({
    super.key,
    required this.companyLogo,
    required this.companyName,
    required this.categoryImage,
    required this.rating,
    this.onTap, // ✅ Add this
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // ✅ Wrap Card with InkWell
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      companyLogo,
                      width: 95,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          companyName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: categoryImage
                              .map((img) => Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Image.asset(
                                      img,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Stars
            Positioned(
              bottom: 8,
              right: 12,
              child: Row(
                children: [
                  ...List.generate(
                    rating,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: Image.asset(
                        'assets/images/star.png',
                        width: 13,
                        height: 13,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (rating == 4)
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Image.asset(
                        'assets/images/rating.png',
                        width: 13,
                        height: 13,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Activity Card
class ActivityCard extends StatelessWidget {
  final String serviceFlow;
  final String logo;
  final String serviceName;
  final String date;
  final String status;
  final String cost;

  const ActivityCard({
    required this.serviceFlow,
    required this.logo,
    required this.serviceName,
    required this.date,
    required this.status,
    required this.cost,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(serviceFlow,
                    style:
                        const TextStyle(fontSize: 12, color: Colors.black54)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Image.asset(logo, width: 50, height: 50),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(serviceName,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(date,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black45)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Row(
              children: [
                Text(status,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                const SizedBox(width: 4),
                const Icon(Icons.circle, size: 10, color: Colors.green),
              ],
            ),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: Text(cost,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

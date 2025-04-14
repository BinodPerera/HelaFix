import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class HelaFixPage extends StatelessWidget {
  const HelaFixPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF48C2FF),
        elevation: 0,
        title: Image.asset(
          'assets/images/logo-light.png',
          height: 40, // Adjust size as needed
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF48C2FF), Color(0xFFF9F9F9)], // Light grey to blue
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.41, 1.0], // 41% F9F9F9, the rest 48C2FF
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Experts here.....',
                    filled: true,
                    fillColor: theme.isDarkMode ? Colors.grey[800] : Colors.white,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Categories',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),

              // Category Row with Images
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  CategoryIcon(imagePath: 'assets/images/repair.png', label: 'Repairs'),
                  CategoryIcon(
                      imagePath: 'assets/images/optimizing.png', label: 'Maintenance'),
                  CategoryIcon(imagePath: 'assets/images/clean-code.png', label: 'Cleaning'),
                  CategoryIcon(imagePath: 'assets/images/pawprint.png', label: 'Pets Services'),
                ],
              ),
              const SizedBox(height: 20),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Popular Experts',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),

              // List of Experts (Now with Category Images)
              const ExpertTile(
                companyLogo: 'assets/images/damro.png',
                companyName: 'Damro Company PVT LTD',
                categoryImage: ['assets/images/repair.png', 'assets/images/clean-code.png'],
              ),
              const ExpertTile(
                companyLogo: 'assets/images/Arpico.png',
                companyName: 'Pioneer Cleaning',
                categoryImage: ['assets/images/repair.png', 'assets/images/clean-code.png'],
              ),
              const ExpertTile(
                companyLogo: 'assets/images/Arpico.png',
                companyName: 'Softlogic Holdings PLC',
                categoryImage: ['assets/images/optimizing.png', 'assets/images/repair.png'],
              ),
              const ExpertTile(
                companyLogo: 'assets/images/damro.png',
                companyName: 'Softlogic Holdings PLC',
                categoryImage: [
                  'assets/images/optimizing.png',
                  'assets/images/repair.png',
                  'assets/images/pawprint.png'
                ],
              ),
            ],
          ),
        ),
      ),
      
      // ✅ Custom Bottom Navigation Bar with Image Icons
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem('assets/images/home.png'),
              _divider(),
              _buildNavItem('assets/images/favourite.png'),
              _divider(),
              _buildNavItem('assets/images/restore.png'),
              _divider(),
              _buildNavItem('assets/images/user.png'),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Widget for Navigation Items
  Widget _buildNavItem(String imagePath) {
    return InkWell(
      onTap: () {
        // Add navigation logic here
      },
      child: Image.asset(
        imagePath,
        width: 30,
        height: 30,
      ),
    );
  }

  // 🔹 Divider for spacing in Bottom Navigation Bar
  Widget _divider() {
    return Container(
      width: 1,
      height: 30,
      color: Colors.grey[400],
    );
  }
}

// Category Widget (Updated for Images)
class CategoryIcon extends StatelessWidget {
  final String imagePath;
  final String label;

  const CategoryIcon({required this.imagePath, required this.label, Key? key})
      : super(key: key);

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

// Expert List Tile (Now Uses Category Images Instead of Icons)
class ExpertTile extends StatelessWidget {
  final String companyLogo;
  final String companyName;
  final List<String> categoryImage;

  const ExpertTile({required this.companyLogo, required this.companyName, required this.categoryImage, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: SizedBox(
          width: 100,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(companyLogo, fit: BoxFit.cover),
          ),
        ),
        title: Text(companyName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Row(
          children: categoryImage.map((image) => Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Image.asset(image, width: 20, height: 20),
          )).toList(),
        ),
        trailing: const Icon(Icons.star, color: Colors.yellow),
      ),
    );
  }
}
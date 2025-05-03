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
        backgroundColor: const Color(0xFF48C2FF),
        elevation: 0,
        title: Image.asset(
          'assets/images/logo_light.png',
          height: 40,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF48C2FF), Color(0xFFF9F9F9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.41, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
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
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              // Categories
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Categories',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  CategoryIcon(imagePath: 'assets/images/repair.png', label: 'Repairs'),
                  CategoryIcon(imagePath: 'assets/images/optimizing.png', label: 'Maintenance'),
                  CategoryIcon(imagePath: 'assets/images/clean-code.png', label: 'Cleaning'),
                  CategoryIcon(imagePath: 'assets/images/pawprint.png', label: 'Pets Services'),
                ],
              ),
              const SizedBox(height: 20),

              // Popular Experts
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Popular Experts',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),

              const ExpertTile(
                companyLogo: 'assets/images/damro.png',
                companyName: 'Damro Company PVT LTD',
                categoryImage: ['assets/images/repair.png', 'assets/images/optimizing.png'],
                rating: 5,
              ),
              const ExpertTile(
                companyLogo: 'assets/images/Arpico.png',
                companyName: 'Pioneer Cleaning',
                categoryImage: ['assets/images/clean-code.png'],
                rating: 4,
              ),
              const ExpertTile(
                companyLogo: 'assets/images/Arpico.png',
                companyName: 'Softlogic Holdings PLC',
                categoryImage: ['assets/images/repair.png','assets/images/optimizing.png','assets/images/clean-code.png'],
                rating: 4,
              ),
              const ExpertTile(
                companyLogo: 'assets/images/damro.png',
                companyName: 'Damro Company PVT LTD',
                categoryImage: ['assets/images/repair.png', 'assets/images/optimizing.png'],
                rating: 5,
              ),
              const ExpertTile(
                companyLogo: 'assets/images/damro.png',
                companyName: 'Damro Company PVT LTD',
                categoryImage: ['assets/images/repair.png', 'assets/images/optimizing.png'],
                rating: 5,
              ),

              // Ongoing Activities
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Text('Recent On-Going Activities',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),

              const ActivityCard(
                serviceFlow: 'Cleaning > Home Cleaning > Deep Cleaning',
                logo: 'assets/images/damro.png',
                serviceName: 'Damro Cleaning Service',
                date: '02/02/2025',
                cost: 'LKR 150,000',
                status: 'Active',
              ),
              const ActivityCard(
                serviceFlow: 'Cleaning > Home Cleaning > Deep Cleaning',
                logo: 'assets/images/damro.png',
                serviceName: 'Damro Cleaning Service',
                date: '02/02/2025',
                cost: 'LKR 150,000',
                status: 'Active',
              ),
              const ActivityCard(
                serviceFlow: 'Cleaning > Home Cleaning > Deep Cleaning',
                logo: 'assets/images/damro.png',
                serviceName: 'Damro Cleaning Service',
                date: '02/02/2025',
                cost: 'LKR 150,000',
                status: 'Active',
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

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

  Widget _buildNavItem(String imagePath) {
    return InkWell(
      onTap: () {},
      child: Image.asset(
        imagePath,
        width: 30,
        height: 30,
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 30,
      color: Colors.grey[400],
    );
  }
}

// Category Icon
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

// Expert Tile
class ExpertTile extends StatelessWidget {
  final String companyLogo;
  final String companyName;
  final List<String> categoryImage;
  final int rating;

  const ExpertTile({
    required this.companyLogo,
    required this.companyName,
    required this.categoryImage,
    required this.rating,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
    Key? key,
  }) : super(key: key);

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
                    style: const TextStyle(fontSize: 12, color: Colors.black54)),
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
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
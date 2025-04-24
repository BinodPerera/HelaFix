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
          'assets/images/logo-light.png',
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
              // Search Bar
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

              // Categories Section
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

              // Popular Experts Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Popular Experts',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),

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

              // Recent On-Going Activities
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

      // Bottom Navigation Bar
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

// Reusable Components

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

class ExpertTile extends StatelessWidget {
  final String companyLogo;
  final String companyName;
  final List<String> categoryImage;

  const ExpertTile({
    required this.companyLogo,
    required this.companyName,
    required this.categoryImage,
    Key? key,
  }) : super(key: key);

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
          children: categoryImage
              .map((image) => Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Image.asset(image, width: 20, height: 20),
                  ))
              .toList(),
        ),
        trailing: const Icon(Icons.star, color: Colors.yellow),
      ),
    );
  }
}

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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(serviceFlow,
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400)),
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
                const Spacer(),
                Row(
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
              ],
            ),
            const SizedBox(height: 10),
            Text('Cost: $cost',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

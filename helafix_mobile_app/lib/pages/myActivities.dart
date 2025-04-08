import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/bottomNavigation.dart';
import 'package:helafix_mobile_app/components/customListTile.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../theme/colors.dart';
import 'package:helafix_mobile_app/components/appbar.dart';

class Myactivities extends StatefulWidget {
  const Myactivities({super.key});

  @override
  State<Myactivities> createState() => _MyactivitiesState();
}

class _MyactivitiesState extends State<Myactivities> {
  String selectedValue = 'Inprocess';

  // Step 1: Create a list of all jobs
  final List<Map<String, dynamic>> allJobs = [
    {
      'title': 'Cleaning Service 1',
      'subtitle': '02-02-2025',
      'path': 'cleaning > Home Cleaning > Deep Cleaning',
      'date': '02-02-2025',
      'image': 'assets/images/damro_logo.jpg',
      'isDone': true,
      'type': 'Upcoming',
      'price': 100.0,
      'onTap': () {},
    },
    {
      'title': 'Cleaning Service 2',
      'subtitle': '02-02-2025',
      'path': 'cleaning > Home Cleaning > Deep Cleaning',
      'date': '02-02-2025',
      'image': 'assets/images/damro_logo.jpg',
      'isDone': false,
      'type': 'Past',
      'price': 100.0,
      'onTap': () {},
    },
    {
      'title': 'Cleaning Service 3',
      'subtitle': '02-02-2025',
      'path': 'cleaning > Home Cleaning > Deep Cleaning',
      'date': '02-02-2025',
      'image': 'assets/images/damro_logo.jpg',
      'isDone': false,
      'type': 'Inprocess',
      'price': 100.0,
      'onTap': () {},
    },
    {
      'title': 'Cleaning Service 3',
      'subtitle': '02-02-2025',
      'path': 'cleaning > Home Cleaning > Deep Cleaning',
      'date': '02-02-2025',
      'image': 'assets/images/damro_logo.jpg',
      'isDone': false,
      'type': 'Inprocess',
      'price': 100.0,
      'onTap': () {},
    },
    {
      'title': 'Cleaning Service 3',
      'subtitle': '02-02-2025',
      'path': 'cleaning > Home Cleaning > Deep Cleaning',
      'date': '02-02-2025',
      'image': 'assets/images/damro_logo.jpg',
      'isDone': false,
      'type': 'Inprocess',
      'price': 100.0,
      'onTap': () {},
    },
    {
      'title': 'Cleaning Service 33',
      'subtitle': '02-02-2025',
      'path': 'cleaning > Home Cleaning > Deep Cleaning',
      'date': '02-02-2025',
      'image': 'assets/images/damro_logo.jpg',
      'isDone': false,
      'type': 'Inprocess',
      'price': 100.0,
      'onTap': () {},
    },
    {
      'title': 'Cleaning Service 4',
      'subtitle': '02-02-2025',
      'path': 'cleaning > Home Cleaning > Deep Cleaning',
      'date': '02-02-2025',
      'image': 'assets/images/damro_logo.jpg',
      'isDone': false,
      'type': 'Inprocess',
      'price': 100.0,
      'onTap': () {},
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Step 2: Filter jobs based on dropdown selection
    final filteredJobs = allJobs.where((job) => job['type'] == selectedValue).toList();

    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode
              ? AppColours.backgroundGradientDark
              : AppColours.backgroundGradientLight,
        ),
        child: Column(
          children: [
            // Header with Dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'My Activities',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.isDarkMode
                        ? AppColours.primaryTextDark
                        : AppColours.primaryTextLight,
                  ),
                ),
                DropdownButton(
                  value: selectedValue,
                  items: <String>['Past', 'Inprocess', 'Upcoming']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                )
              ],
            ),
            SizedBox(height: 20),

            // Step 3: Display filtered list
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: filteredJobs.map((job) {
                    return customListTile(
                      title: job['title'],
                      subtitle: job['subtitle'],
                      path: job['path'],
                      date: job['date'],
                      image: job['image'],
                      isDone: job['isDone'],
                      type: job['type'],
                      price: job['price'],
                      onTap: job['onTap'],
                    );
                  }).toList(),
                ),
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

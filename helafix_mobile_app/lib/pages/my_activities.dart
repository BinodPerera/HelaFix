import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:helafix_mobile_app/components/bottom_navigation.dart';
import 'package:helafix_mobile_app/components/custom_list_tile.dart';
import 'package:helafix_mobile_app/components/appbar.dart';
import '../theme_provider.dart';
import '../theme/colors.dart';

class JobStatus {
  static const past = 'Past';
  static const present = 'Present';
  static const future = 'Future';
}

class Myactivities extends StatefulWidget {
  const Myactivities({super.key});

  @override
  State<Myactivities> createState() => _MyactivitiesState();
}

class _MyactivitiesState extends State<Myactivities> {
  String selectedValue = JobStatus.present;

  final List<Map<String, dynamic>> allJobs = [
    {
      'title': 'Cleaning Service 1',
      'subtitle': '02-02-2025',
      'path': 'cleaning > Home Cleaning > Deep Cleaning',
      'date': '02-02-2025',
      'image': 'assets/images/damro_logo.jpg',
      'isDone': true,
      'type': JobStatus.future,
      'price': 100.0,
    },
    {
      'title': 'Cleaning Service 2',
      'subtitle': '02-02-2025',
      'path': 'cleaning > Home Cleaning > Deep Cleaning',
      'date': '02-02-2025',
      'image': 'assets/images/damro_logo.jpg',
      'isDone': false,
      'type': JobStatus.past,
      'price': 100.0,
    },
    {
      'title': 'Cleaning Service 3',
      'subtitle': '02-02-2025',
      'path': 'cleaning > Home Cleaning > Deep Cleaning',
      'date': '02-02-2025',
      'image': 'assets/images/damro_logo.jpg',
      'isDone': false,
      'type': JobStatus.present,
      'price': 100.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final filteredJobs =
        allJobs.where((job) => job['type'] == selectedValue).toList();

    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode
              ? AppColours.backgroundGradientDark
              : AppColours.backgroundGradientLight,
        ),
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                DropdownButton<String>(
                  value: selectedValue,
                  dropdownColor: themeProvider.isDarkMode
                      ? Colors.grey[800]
                      : Colors.white,
                  style: TextStyle(
                    color: themeProvider.isDarkMode
                        ? AppColours.primaryTextDark
                        : AppColours.primaryTextLight,
                  ),
                  underline: SizedBox(),
                  items: <String>[
                    JobStatus.past,
                    JobStatus.present,
                    JobStatus.future
                  ].map((String value) {
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
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Job List
            Expanded(
              child: ListView.builder(
                itemCount: filteredJobs.length,
                itemBuilder: (context, index) {
                  final job = filteredJobs[index];
                  return customListTile(
                    title: job['title'],
                    subtitle: job['subtitle'],
                    path: job['path'],
                    date: job['date'],
                    image: job['image'],
                    isDone: job['isDone'],
                    type: job['type'],
                    price: job['price'],
                    onTap: () {
                      String route;
                      switch (job['type']) {
                        case JobStatus.past:
                        case JobStatus.present:
                          route = '/jobdetails';
                          break;
                        case JobStatus.future:
                        default:
                          route = '/jobdetails';
                          break;
                      }
                      Navigator.pushNamed(context, route);
                    },
                  );
                },
              ),
            ),
          ],
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

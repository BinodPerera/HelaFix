import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helafix_mobile_app/components/bottom_navigation.dart';
import 'package:helafix_mobile_app/components/custom_list_tile.dart';
import 'package:helafix_mobile_app/components/appbar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';
import '../theme_provider.dart';
import '../models/job.dart';
import '../models/service_provider.dart';
import '../models/service_sub.dart';

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
  bool isLoading = true;
  List<Map<String, dynamic>> jobsData = [];

  @override
  void initState() {
    super.initState();
    fetchJobsWithDetails();
  }

  Future<void> fetchJobsWithDetails() async {
    try {
      setState(() {
        isLoading = true;
      });

      final jobSnapshot = await FirebaseFirestore.instance
          .collection('jobs')
          .where('status', isEqualTo: selectedValue)
          .get();

      List<Map<String, dynamic>> combinedData = [];

      for (var jobDoc in jobSnapshot.docs) {
        final job = Job.fromMap(jobDoc.data(), jobDoc.id);

        final providerDoc = await FirebaseFirestore.instance
            .collection('service_providers')
            .doc(job.providerId)
            .get();

        final subCatDoc = await FirebaseFirestore.instance
            .collection('sub_categories')
            .doc(job.subcategoriesid)
            .get();

        if (!providerDoc.exists || !subCatDoc.exists) {
          debugPrint('Missing provider or subcategory for job ${jobDoc.id}');
          continue;
        }

        final provider =
            ServiceProvider.fromMap(providerDoc.data()!, providerDoc.id);
        final subCat =
            ServiceSubCategory.fromMap(subCatDoc.data()!, subCatDoc.id);

        // Convert base64 to temporary file path or pass raw string
        final imageBytes = base64Decode(provider.imageBase64);

        combinedData.add({
          'id': job.jobId,
          'title': provider.name,
          'subtitle': DateFormat('MMM d, y – h:mm a').format(job.createdAt),
          'path': subCat.name,
          'date': formatDate(job.endAt),
          'imageBytes': imageBytes,
          'isDone': true,
          'type': job.status,
        });
      }

      setState(() {
        jobsData = combinedData;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching jobs: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  String? formatDate(DateTime? date) {
    return date != null ? DateFormat('MMMM d, y').format(date) : null;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final filteredJobs =
        jobsData.where((job) => job['type'] == selectedValue).toList();

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
            // Header with dropdown
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
                  underline: const SizedBox(),
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
                    if (newValue != null) {
                      setState(() {
                        selectedValue = newValue;
                      });
                      fetchJobsWithDetails();
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Job List
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredJobs.isEmpty
                      ? const Center(child: Text("No jobs found."))
                      : ListView.builder(
                          itemCount: filteredJobs.length,
                          itemBuilder: (context, index) {
                            final job = filteredJobs[index];
                            return customListTile(
                              title: job['title'],
                              subtitle: job['subtitle'],
                              path: job['path'],
                              date: job['date'],
                              image: base64Encode(job['imageBytes']),
                              isDone: job['isDone'],
                              type: job['type'],
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/jobdetails',
                                  arguments: {'jobId': job['id']},
                                );
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

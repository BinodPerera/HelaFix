import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/bottom_navigation.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../theme_provider.dart';
import '../../theme/colors.dart';
import '../../models/job.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class JobDetails extends StatelessWidget {
  const JobDetails({super.key});

  Future<Job?> _getJob() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('jobs').limit(1).get();
    if (snapshot.docs.isNotEmpty) {
      return Job.fromMap(snapshot.docs.first.data(), snapshot.docs.first.id);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return FutureBuilder<Job?>(
      future: _getJob(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final job = snapshot.data;

        if (job == null) {
          return const Scaffold(
            body: Center(child: Text('No job found')),
          );
        }

        return Scaffold(
          backgroundColor: themeProvider.isDarkMode
              ? AppColours.primaryDark
              : AppColours.primaryLight,
          appBar: AppBar(
            title: const Text(
              'Job Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color.fromARGB(255, 0, 183, 255),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: themeProvider.isDarkMode
                  ? AppColours.backgroundGradientDark
                  : AppColours.backgroundGradientLight,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(1),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black87),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                'Cleaning > Home Cleaning > Deep Cleaning',
                                style: TextStyle(fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: const [
                                Text(
                                  'Done',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.circle,
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    size: 10),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  'assets/images/Arpico.webp',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Damro Cleaning Service',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Text(
                                        "",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    bottom: -5,
                                    right: 0,
                                    child: Text(
                                      'COST: LKR ${job.cost.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //Future
                  if (job.status == "Future") ...[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                        padding:
                            EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Cancel Request',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ],


                  //Present
                  if (job.status == "Present") ...[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 30, 255, 0),
                        padding:
                            EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/job_done_1.1');
                      },
                      child: Text(
                        'Finish Job',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ],
                  const SizedBox(height: 20),
                  _buildSectionTitle(context, 'Job Summary,'),
                  _buildInfo(context, 'Job Id: ${job.jbid}'),
                  _buildInfo(context,
                      'Date: ${DateFormat('EEE, d MMMM, yyyy').format(job.createdAt)}'),
                  _buildInfo(context,
                      'Time: ${DateFormat('hh:mm a').format(job.createdAt)}'),
                  _buildInfo(context, 'Description: ${job.description}'),
                  _buildInfo(context,
                      'Start Date: ${DateFormat('EEE, d MMMM, yyyy').format(job.createdAt)}'),

                  //Past
                  if (job.status == "Past") ...[
                  _buildInfo(context,
                      'End Date: ${DateFormat('EEE, d MMMM, yyyy').format(job.endAt)}'),
                  ],
                  const SizedBox(height: 20),
                  _buildSectionTitle(context, 'Service Provider,'),
                  _buildProviderCard(),

                  //Future
                  if (job.status == "Future") ...[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 30, 255, 0),
                        padding:
                            EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Update Booking',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ],


                  //Past
                  if (job.status == "Past") ...[
                  const SizedBox(height: 20),
                  _buildSectionTitle(context, 'Payment Details,'),
                  _buildInfo(context,
                      'Date: ${DateFormat('EEE, d MMMM, yyyy').format(job.paymentAt)}'),
                  _buildInfo(context,
                      'Time: ${DateFormat('hh:mm a').format(job.paymentAt)}'),
                  _buildInfo(context, 'Final Cost: LKR ${job.cost}'),
                  _buildInfo(
                      context, 'Card Number: ${job.cardNumber ?? "N/A"}'),
                  _buildInfo(context, 'Payment Number: ${job.paymentId}'),
                  const SizedBox(height: 20),
                  _buildSectionTitle(context, 'Your Review,'),
                  _buildInfo(context, job.review),
                  Container(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RatingBarIndicator(
                        rating: job.stars.toDouble(),
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: job.stars,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                    ),
                  ),
                  ],
                  const SizedBox(height: 40),
                ],
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
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: const EdgeInsets.all(15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            color:
                themeProvider.isDarkMode ? AppColours.dark : AppColours.light,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context, String text) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            color:
                themeProvider.isDarkMode ? AppColours.dark : AppColours.light,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildProviderCard() {
    return Container(
      width: 400,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              child: Image.asset(
                'assets/images/Arpico.webp',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
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
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 75),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "90% Positive ratings",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 13,
                        ),
                      ),
                    ],
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

import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helafix_mobile_app/models/service_sub.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../theme_provider.dart';
import '../theme/colors.dart';
import '../components/bottom_navigation.dart';
import 'booking_done.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  int selectedIndex = 2;
  bool isDetailsVisible = true;
  bool isPart2Visible = true;
  bool isPart3Visible = false;

  List<DateTime> upcomingDates = [];

  String providerId = '';
  String subCategoryId = '';

  String providerName = '';
  String providerDescription = '';
  Uint8List? providerImage;
  String subCategoryName = '';

  bool isLoading = true;

  String selectedTime = '';

  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();
    generateUpcomingDates();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      providerId = args['providerId'];
      subCategoryId = args['subCategoryId'];
      loadData();
    }
  }

  void setTimeFromLabel(String timeLabel) {
    final timeParts = timeLabel.split(' ');
    final hourMinute = timeParts[0].split(':');
    int hour = int.parse(hourMinute[0]);
    int minute = int.parse(hourMinute[1]);

    final isPM = timeParts[1].toLowerCase() == 'pm';
    if (isPM && hour != 12) hour += 12;
    if (!isPM && hour == 12) hour = 0;

    final selectedDate = upcomingDates[selectedIndex];
    selectedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      hour,
      minute,
    );

    setState(() {}); // Optional if UI needs to reflect time
  }

  Future<void> submitJob() async {
  if (providerId.isEmpty ||
      subCategoryId.isEmpty ||
      selectedDateTime == null) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Missing data')));
    return;
  }

  final currentUser = FirebaseAuth.instance.currentUser;
  print("Current UID: ${currentUser?.uid}");

  final job = {
    'card_number': null,
    'cost': 0,
    'costsp': 0,
    'created_at': Timestamp.fromDate(selectedDateTime!),
    'description': descriptionController.text,
    'end_at': null,
    'jbid': subCategoryId,
    'payment_at': Timestamp.now(),
    'payment_id': 0,
    'provider_id': providerId,
    'review': '',
    'stars': 0,
    'status': 'Future',
    'user_id': currentUser?.uid,
    'provider_value': false,
    'user_value': false,
    'usercost': false,
    'spcost': false,
  };

    await FirebaseFirestore.instance.collection('jobs').add(job);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Job submitted!')));
  }

  Future<void> loadData() async {
    try {
      final providerSnap = await FirebaseFirestore.instance
          .collection('service_providers')
          .doc(providerId)
          .get();
      final providerData = providerSnap.data();
      if (providerData != null) {
        providerName = providerData['name'] ?? '';
        providerDescription = providerData['description'] ?? '';
        final imageBase64 = providerData['image_base64'] ?? '';
        providerImage = base64Decode(imageBase64);
      }

      final subcatSnap = await FirebaseFirestore.instance
          .collection('sub_categories')
          .doc(subCategoryId)
          .get();

      final subcatData = subcatSnap.data();
      if (subcatData != null) {
        final subcategory =
            ServiceSubCategory.fromMap(subcatData, subcatSnap.id);
        subCategoryName = subcategory.name;
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  void generateUpcomingDates() {
    DateTime now = DateTime.now();
    upcomingDates = List.generate(7, (i) => now.add(Duration(days: i)));
  }

  void toggleText() {
    setState(() {
      isDetailsVisible = !isDetailsVisible;
      if (isDetailsVisible) {
        isPart2Visible = true;
        isPart3Visible = false;
      } else {
        isPart2Visible = false;
        isPart3Visible = true;
      }
    });
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? AppColours.primaryDark
          : AppColours.primaryLight,
      appBar: AppBar(
        title: const Text(
          'Booking',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 183, 255),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
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
                      padding: const EdgeInsets.all(15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          subCategoryName,
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? AppColours.dark
                                : AppColours.light,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 430,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
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
                                  child: providerImage != null
                                      ? Image.memory(providerImage!,
                                          fit: BoxFit.cover)
                                      : const Icon(Icons.image_not_supported),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      providerName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: toggleText,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 85),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              isDetailsVisible
                                                  ? "90% Positive ratings"
                                                  : "Book Appointment",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
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
                    if (isPart2Visible) ...[
                      const SizedBox(height: 50),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: upcomingDates.length,
                          itemBuilder: (context, index) {
                            bool isSelected = index == selectedIndex;
                            DateTime date = upcomingDates[index];
                            String day = [
                              'Mon',
                              'Tue',
                              'Wed',
                              'Thu',
                              'Fri',
                              'Sat',
                              'Sun'
                            ][date.weekday - 1];

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                width: 60,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.green
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      day,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${date.day}',
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.white
                                            : const Color.fromARGB(
                                                255, 53, 189, 64),
                                        shape: BoxShape.circle,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Available Slots: ${[
                              'Mon',
                              'Tue',
                              'Wed',
                              'Thu',
                              'Fri',
                              'Sat',
                              'Sun'
                            ][upcomingDates[selectedIndex].weekday - 1]}, ${upcomingDates[selectedIndex].day} ${_getMonthName(upcomingDates[selectedIndex].month)} ${upcomingDates[selectedIndex].year}',
                            style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? AppColours.dark
                                  : AppColours.light,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '-Morning',
                            style: TextStyle(
                              color: Color.fromARGB(255, 126, 126, 126),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selectedTime == '08:00 AM'
                                      ? Colors.green
                                      : Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  side: BorderSide(
                                    color: themeProvider.isDarkMode
                                        ? AppColours.dark
                                        : AppColours.light,
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedTime = '08:00 AM';
                                  });
                                  setTimeFromLabel('08:00 AM');
                                },
                                child: Text(
                                  '08:00 AM',
                                  style: TextStyle(
                                    color: themeProvider.isDarkMode
                                        ? AppColours.dark
                                        : AppColours.light,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selectedTime == '10:00 AM'
                                      ? Colors.green
                                      : Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  side: BorderSide(
                                    color: themeProvider.isDarkMode
                                        ? AppColours.dark
                                        : AppColours.light,
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedTime = '10:00 AM';
                                  });
                                  setTimeFromLabel('10:00 AM');
                                },
                                child: Text(
                                  '10:00 AM',
                                  style: TextStyle(
                                    color: themeProvider.isDarkMode
                                        ? AppColours.dark
                                        : AppColours.light,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '-Afternoon',
                            style: TextStyle(
                              color: Color.fromARGB(255, 126, 126, 126),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selectedTime == '12:00 PM'
                                      ? Colors.green
                                      : Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  side: BorderSide(
                                    color: themeProvider.isDarkMode
                                        ? AppColours.dark
                                        : AppColours.light,
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedTime = '12:00 PM';
                                  });
                                  setTimeFromLabel('12:00 PM');
                                },
                                child: Text(
                                  '12:00 PM',
                                  style: TextStyle(
                                    color: themeProvider.isDarkMode
                                        ? AppColours.dark
                                        : AppColours.light,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selectedTime == '02:00 PM'
                                      ? Colors.green
                                      : Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  side: BorderSide(
                                    color: themeProvider.isDarkMode
                                        ? AppColours.dark
                                        : AppColours.light,
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedTime = '02:00 PM';
                                  });
                                  setTimeFromLabel('02:00 PM');
                                },
                                child: Text(
                                  '02:00 PM',
                                  style: TextStyle(
                                    color: themeProvider.isDarkMode
                                        ? AppColours.dark
                                        : AppColours.light,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '-Evening',
                            style: TextStyle(
                              color: Color.fromARGB(255, 126, 126, 126),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selectedTime == '04:00 PM'
                                      ? Colors.green
                                      : Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  side: BorderSide(
                                    color: themeProvider.isDarkMode
                                        ? AppColours.dark
                                        : AppColours.light,
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedTime = '04:00 PM';
                                  });
                                  setTimeFromLabel('04:00 PM');
                                },
                                child: Text(
                                  '04:00 PM',
                                  style: TextStyle(
                                    color: themeProvider.isDarkMode
                                        ? AppColours.dark
                                        : AppColours.light,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Description',
                            style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? AppColours.dark
                                  : AppColours.light,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: SizedBox(
                          width: 420.0,
                          child: TextField(
                            controller:
                                descriptionController, // <-- attach controller
                            maxLines: 4,
                            keyboardType: TextInputType
                                .text, // use `text`, not `number`, for description
                            style: TextStyle(fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(60),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 30, 255, 0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 45, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            submitJob();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookingDone()),
                            );
                          },
                          child: Text(
                            'Book Appointment',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                    if (isPart3Visible) ...[
                      const SizedBox(height: 50),
                      Container(
                        width: 420,
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
                        child: SizedBox(
                          height: 557,
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(8, (index) {
                                return Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0)),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.asset(
                                              'assets/images/user.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'This is service details description This is service details description. This is service details description. This is service details description.',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              Row(
                                                children: const [
                                                  Icon(Icons.star,
                                                      color: Colors.yellow),
                                                  Icon(Icons.star,
                                                      color: Colors.yellow),
                                                  Icon(Icons.star,
                                                      color: Colors.yellow),
                                                  Icon(Icons.star,
                                                      color: Colors.yellow),
                                                  Icon(Icons.star,
                                                      color: Colors.yellow),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.black,
                                      thickness: 1.0,
                                      indent: 15.0,
                                      endIndent: 15.0,
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ],
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

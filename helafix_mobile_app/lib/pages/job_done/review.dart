import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helafix_mobile_app/components/bottom_navigation.dart';
import 'package:provider/provider.dart';
import '../../theme_provider.dart';
import '../../theme/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // 👇 Get jobId from arguments
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String jobId = args['jobId'];

    final ValueNotifier<int> currentStep = ValueNotifier(1);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? AppColours.primaryDark
          : AppColours.primaryLight,
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
              ValueListenableBuilder(
                valueListenable: currentStep,
                builder: (context, step, _) {
                  return Container(
                    padding: const EdgeInsets.all(100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 1; i <= 3; i++) ...[
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: i < 4
                                ? const Color.fromARGB(255, 0, 255, 8)
                                : Colors.white,
                            child: Text(
                              '$i',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (i != 3)
                            Container(
                              width: 40,
                              height: 2,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                        ]
                      ],
                    ),
                  );
                },
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(0),
                child: Image.asset(
                  'assets/images/check.png',
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Job Done....',
                  style: TextStyle(
                    color: themeProvider.isDarkMode
                        ? AppColours.dark
                        : AppColours.light,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "We'd love to hear your thoughts!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: themeProvider.isDarkMode
                        ? AppColours.dark
                        : AppColours.light,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: 390.0,
                  child: TextField(
                    controller: _reviewController,
                    maxLines: 4,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: "Write Follow-up Review",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black),
                ),
                child: RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.yellow[700],
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 30, 255, 0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    if (_rating == 0 || _reviewController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please provide rating and review')),
                      );
                      return;
                    }

                    await FirebaseFirestore.instance
                        .collection('jobs')
                        .doc(jobId)
                        .update({
                      'review': _reviewController.text.trim(),
                      'stars': _rating.toInt(),
                      'status': 'Past', 
                    });

                    Navigator.pushNamed(
                      context,
                      '/my_activities',
                    );
                  },
                  child: const Text(
                    'Add Review',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
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
  }
}

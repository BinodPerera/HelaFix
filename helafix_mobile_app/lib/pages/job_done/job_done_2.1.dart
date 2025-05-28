import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/bottom_navigation.dart';
import 'package:provider/provider.dart';
import '../../theme/colors.dart';
import '../../theme_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class JobDoneTwoOne extends StatefulWidget {
  const JobDoneTwoOne({super.key});

  @override
  State<JobDoneTwoOne> createState() => _JobDoneTwoOneState();
}

class _JobDoneTwoOneState extends State<JobDoneTwoOne> {
  final TextEditingController priceController = TextEditingController();
  late String jobId;
  Timer? pollingTimer;

  @override
  void dispose() {
    pollingTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Start polling after first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      jobId = args['jobId'];

      pollingTimer =
          Timer.periodic(Duration(seconds: 5), (_) => checkJobStatus());
    });
  }

  Future<void> submitPrice() async {
    final double? price = double.tryParse(priceController.text);
    if (price == null) return;

    await FirebaseFirestore.instance.collection('jobs').doc(jobId).update({
      'cost': price,
      'usercost': true,
    });
  }

  Future<void> checkJobStatus() async {
    final docSnapshot =
        await FirebaseFirestore.instance.collection('jobs').doc(jobId).get();

    if (!docSnapshot.exists) return;
    final data = docSnapshot.data()!;

    bool usercost = data['usercost'] ?? false;
    bool spcost = data['spcost'] ?? false;

    if (usercost && spcost) {
      double cost = data['cost']?.toDouble() ?? 0.0;
      double costsp = data['costsp']?.toDouble() ?? 0.0;

      if (cost == costsp) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/payment',
              arguments: {'jobId': jobId});
        }
      } else {
        // Show error and reset Firestore fields
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Cost mismatch. Please resubmit.'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }

        // Reset fields after 5 seconds
        Future.delayed(Duration(seconds: 60), () async {
          await FirebaseFirestore.instance
              .collection('jobs')
              .doc(jobId)
              .update({
            'cost': 0,
            'costsp': 0,
            'usercost': false,
            'spcost': false,
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? AppColours.primaryDark
          : AppColours.primaryLight,
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode
              ? AppColours.backgroundGradientDark
              : AppColours.backgroundGradientLight,
        ),
        child: Column(
          children: [
            // Step indicator
            Container(
              padding: EdgeInsets.all(100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 1; i <= 3; i++) ...[
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: i == 1
                          ? Color.fromARGB(255, 0, 255, 8)
                          : Colors.white,
                      child: Text(
                        '$i',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (i != 3)
                      Container(
                        width: 40,
                        height: 2,
                        color: Colors.white,
                      ),
                  ]
                ],
              ),
            ),

            // Title
            Container(
              child: Text(
                'Cost Checking',
                style: TextStyle(
                  color: themeProvider.isDarkMode
                      ? AppColours.dark
                      : AppColours.light,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Instructions
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Proceed with this step only when both parties agree on the same cost.',
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

            // Price Input
            Padding(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                width: 250.0,
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "Enter your final price",
                    prefixText: "LKR ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),

            // Submit Button
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 30, 255, 0),
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: submitPrice,
                child: Text(
                  'Submit Price',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Divider & Spinner
            Divider(color: Colors.black, thickness: 1.0),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Waiting for service provider response...',
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
            SpinKitFadingCircle(
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              size: 100.0,
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

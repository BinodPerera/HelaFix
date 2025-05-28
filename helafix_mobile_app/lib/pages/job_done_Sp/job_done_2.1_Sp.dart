import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/bottom_navigation.dart';
import 'package:helafix_mobile_app/models/service_provider.dart';
import 'package:helafix_mobile_app/pages/provider_home.dart';
import 'package:provider/provider.dart';
import '../../theme/colors.dart';
import '../../theme_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../models/job.dart';

class JobDoneTwoOneSp extends StatefulWidget {
  const JobDoneTwoOneSp({super.key});

  @override
  State<JobDoneTwoOneSp> createState() => _JobDoneTwoOneState();
}

class _JobDoneTwoOneState extends State<JobDoneTwoOneSp> {
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      jobId = args['jobId'];

      pollingTimer = Timer.periodic(Duration(seconds: 5), (_) => checkJobStatus());
    });
  }

  Future<void> submitPrice() async {
    final double? price = double.tryParse(priceController.text);
    if (price == null) return;

    print('SP submitting: costsp = $price, spcost = true');

    await FirebaseFirestore.instance.collection('jobs').doc(jobId).update({
      'costsp': price,
      'spcost': true,
    });
  }

  Future<void> checkJobStatus() async {
    final docSnapshot = await FirebaseFirestore.instance.collection('jobs').doc(jobId).get();

    if (!docSnapshot.exists) return;
    final data = docSnapshot.data()!;
    final job = Job.fromMap(data, jobId);

    if (job.usercost && job.spcost) {
      if (job.cost == job.costsp) {
        String? email = await getServiceProviderEmailFromJob(jobId);
        if (email != null && mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProviderHome(email: email),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Cost mismatch. Please resubmit.'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }

        Future.delayed(Duration(seconds: 60), () async {
          await FirebaseFirestore.instance.collection('jobs').doc(jobId).update({
            'cost': 0,
            'costsp': 0,
            'usercost': false,
            'spcost': false,
          });
        });
      }
    }
  }

  Future<String?> getServiceProviderEmailFromJob(String jobId) async {
    try {
      final jobDoc = await FirebaseFirestore.instance.collection('jobs').doc(jobId).get();

      if (!jobDoc.exists) return null;

      final jobData = jobDoc.data()!;
      final job = Job.fromMap(jobData, jobId);

      final spDoc = await FirebaseFirestore.instance
          .collection('service_providers')
          .doc(job.providerId)
          .get();

      if (!spDoc.exists) return null;

      final spData = spDoc.data()!;
      final sp = ServiceProvider.fromMap(spData, spDoc.id);

      return sp.email;
    } catch (e) {
      print('Error getting service provider email: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor:
          themeProvider.isDarkMode ? AppColours.primaryDark : AppColours.primaryLight,
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode
              ? AppColours.backgroundGradientDark
              : AppColours.backgroundGradientLight,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 1; i <= 3; i++) ...[
                    CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          i == 1 ? Color.fromARGB(255, 0, 255, 8) : Colors.white,
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
            Text(
              'Cost Checking',
              style: TextStyle(
                color: themeProvider.isDarkMode ? AppColours.dark : AppColours.light,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Proceed with this step only when both parties agree on the same cost.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: themeProvider.isDarkMode ? AppColours.dark : AppColours.light,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
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
            Divider(color: Colors.black, thickness: 1.0),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Waiting for customer response...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: themeProvider.isDarkMode ? AppColours.dark : AppColours.light,
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

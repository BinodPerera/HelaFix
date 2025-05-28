import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helafix_mobile_app/components/bottom_navigation.dart';
import 'package:provider/provider.dart';
import '../../theme_provider.dart';
import '../../theme/colors.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final ValueNotifier<Color> buttonColor =
      ValueNotifier(const Color.fromRGBO(217, 217, 217, 1));

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String jobId = args['jobId'];

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('jobs').doc(jobId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Scaffold(
            body: Center(child: Text('Job not found')),
          );
        }

        final jobData = snapshot.data!.data() as Map<String, dynamic>;
        final int cost = (jobData['cost'] is double)
            ? (jobData['cost'] as double).toInt()
            : (jobData['cost'] ?? 0);

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
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Payment',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('assets/images/Visa-card.png', height: 60),
                    Transform.translate(
                      offset: const Offset(-12, 0),
                      child: Image.asset('assets/images/Master-card.png',
                          height: 60),
                    ),
                    Transform.translate(
                      offset: const Offset(-16, 0),
                      child: Image.asset('assets/images/Americanexpress.png',
                          height: 35),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _cardNumberController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Card number",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _expiryController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Expire(MM/YY)",
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _cvvController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "CVV",
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: "Name on card",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ValueListenableBuilder(
                  valueListenable: buttonColor,
                  builder: (context, color, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 30, 255, 0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 45, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        final cardNumber = _cardNumberController.text.trim();
                        final expiry = _expiryController.text.trim();
                        final cvv = _cvvController.text.trim();
                        final name = _nameController.text.trim();

                        // Simple validation check
                        if (cardNumber.isEmpty ||
                            expiry.isEmpty ||
                            cvv.isEmpty ||
                            name.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in all fields'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        // Proceed if all fields are filled
                        await FirebaseFirestore.instance
                            .collection('jobs')
                            .doc(jobId)
                            .update({'card_number': cardNumber});

                        Navigator.pushNamed(context, '/review', arguments: {
                          'jobId': jobId,
                        });
                      },
                      child: Text(
                        'Pay Now LKR ${cost.toString()}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'If an error occurs during payment, you can select a special inquiry button and report the problem.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ValueListenableBuilder(
                  valueListenable: buttonColor,
                  builder: (context, color, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                        backgroundColor: color,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        buttonColor.value = Colors.red;
                      },
                      child: const Text(
                        'Special Inquiries',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
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
      },
    );
  }
}

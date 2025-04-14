import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/bottomNavigation.dart';
import 'package:provider/provider.dart';
import '../../theme_provider.dart';
import '../../theme/colors.dart';

class JobDoneTwoThree extends StatelessWidget {
  const JobDoneTwoThree({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ValueNotifier<bool> isWaiting = ValueNotifier(true);
    final ValueNotifier<Color> buttonColor =
        ValueNotifier(const Color.fromRGBO(217, 217, 217, 1));
    final ValueNotifier<int> currentStep = ValueNotifier(1);
    final TextEditingController priceController = TextEditingController();
    final ValueNotifier<String> matchStatus = ValueNotifier("");
    final ValueNotifier<bool> hasSubmitted = ValueNotifier(false);

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
            ValueListenableBuilder(
              valueListenable: currentStep,
              builder: (context, step, _) {
                return Container(
                  padding: EdgeInsets.all(100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 1; i <= 3; i++) ...[
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: i == 1
                              ? const Color.fromARGB(255, 0, 255, 8)
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
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                      ]
                    ],
                  ),
                );
              },
            ),
            Container(
              padding: EdgeInsets.all(0),
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
            Container(
              padding: EdgeInsets.all(20),
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
            ValueListenableBuilder(
              valueListenable: hasSubmitted,
              builder: (context, submitted, _) {
                if (submitted) {
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    width: 250.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'LKR ${priceController.text.trim()}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: [
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
                      const SizedBox(height: 10),
                      ValueListenableBuilder(
                        valueListenable: buttonColor,
                        builder: (context, color, child) {
                          return ElevatedButton(
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
                              final inputText = priceController.text
                                  .replaceAll(',', '')
                                  .trim();
                              final inputPrice = double.tryParse(inputText);
                              isWaiting.value = false;

                              if (inputPrice == 180000.00) {
                                matchStatus.value = "matched";
                              } else {
                                matchStatus.value = "unmatched";
                              }

                              hasSubmitted.value = true;
                              buttonColor.value =
                                  const Color.fromARGB(255, 30, 255, 0);
                            },
                            child: Text(
                              'Submit Price',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
              },
            ),
            SizedBox(height: 20),
            Divider(
              color: Colors.black,
              thickness: 1.0,
              indent: 15.0,
              endIndent: 15.0,
            ),
            ValueListenableBuilder(
              valueListenable: isWaiting,
              builder: (context, value, child) {
                return Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'The service provider responded',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? AppColours.dark
                          : AppColours.light,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              width: 250.0,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'LKR 180,000.00',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: matchStatus,
              builder: (context, status, child) {
                if (status == "matched") {
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(30),
                        child: Image.asset(
                          'assets/images/check.png',
                          height: 60,
                        ),
                      ),
                      Text(
                        'Values Matched.',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  );
                } else if (status == "unmatched") {
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(30),
                        child: Image.asset(
                          'assets/images/cross.png',
                          height: 60,
                        ),
                      ),
                      Text(
                        'The values are unmatched.',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(129, 0, 255, 21),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  hasSubmitted.value = false;
                                  priceController.clear();
                                  matchStatus.value = "";
                                  isWaiting.value = true;
                                },
                                child: const Text(
                                  'Try again',
                                  style: TextStyle(
                                    color: Colors.black,
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
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 226, 226, 226),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Redirecting to support...")),
                                  );
                                },
                                child: const Text(
                                  'Special Inquiries',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return SizedBox();
                }
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
  }
}

import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/bottom_navigation.dart';
import 'package:provider/provider.dart';
import '../../theme_provider.dart';
import '../../theme/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class JobDoneTwoTwoSp extends StatelessWidget {
  const JobDoneTwoTwoSp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ValueNotifier<bool> isWaiting = ValueNotifier(true);
    final ValueNotifier<Color> buttonColor =
        ValueNotifier(const Color.fromRGBO(217, 217, 217, 1));
    final ValueNotifier<int> currentStep = ValueNotifier(1);
    final TextEditingController priceController = TextEditingController();

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
            Container(
              padding: EdgeInsets.all(10),
              child: ValueListenableBuilder(
                valueListenable: buttonColor,
                builder: (context, color, child) {
                  return ElevatedButton(
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
            ),
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
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Checking values......',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: themeProvider.isDarkMode
                      ? AppColours.dark
                      : AppColours.light,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(0),
              child: SpinKitFadingCircle(
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                size: 60.0,
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

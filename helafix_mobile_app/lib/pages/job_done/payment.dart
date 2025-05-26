import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/bottom_navigation.dart';
import 'package:provider/provider.dart';
import '../../theme_provider.dart';
import '../../theme/colors.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ValueNotifier<bool> isWaiting = ValueNotifier(true);
    final ValueNotifier<Color> buttonColor =
        ValueNotifier(const Color.fromRGBO(217, 217, 217, 1));
    final ValueNotifier<int> currentStep = ValueNotifier(1);

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
                          backgroundColor:
                              i < 3 ?  const Color.fromARGB(255, 0, 255, 8) : Colors.white,
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
                'Payment',
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
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/images/Visa-card.png',
                    height: 60,
                  ),
                  Transform.translate(
                    offset: Offset(-12, 0),
                    child: Image.asset(
                      'assets/images/Master-card.png',
                      height: 60,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(-16, 0),
                    child: Image.asset(
                      'assets/images/Americanexpress.png',
                      height: 35,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                width: 390.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "Card number",
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
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        labelText: "Expire(MM/YY)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        labelText: "CVV",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                width: 390.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "Name on card",
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
              padding: EdgeInsets.all(30),
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
                      'Pay Now LKR 180,000.00',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              child: Text(
                'If an error occurs during payment, you can select a special inquiry button and report the problem.',
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
              padding: EdgeInsets.all(20),
              child: ValueListenableBuilder(
                valueListenable: buttonColor,
                builder: (context, color, child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                      backgroundColor: color,
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      isWaiting.value = false;
                      buttonColor.value = Colors.red;
                    },
                    child: Text(
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

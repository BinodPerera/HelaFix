import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/bottomNavigation.dart';
import 'package:provider/provider.dart';
import '../../theme_provider.dart';
import '../../theme/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class JobDoneOne extends StatelessWidget {
  const JobDoneOne({super.key});

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
                              i < step ?  const Color.fromARGB(255, 0, 255, 8) : Colors.white,
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
            ValueListenableBuilder(
              valueListenable: isWaiting,
              builder: (context, value, child) {
                return Container(
                  padding: EdgeInsets.all(40),
                  child: Text(
                    value
                        ? 'Service Provider Confirmation'
                        : 'The service providers refused a request for confirmation that the work was completed.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? AppColours.dark
                          : AppColours.light,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: isWaiting,
              builder: (context, value, child) {
                return Container(
                  padding: EdgeInsets.all(40),
                  child: Text(
                    value
                        ? 'Waiting for service provider response.....'
                        : 'If the job is not yet finished, you can go back and continue the job, or if there is any problem with the job, you can select the special inquiry button. ',
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
            ValueListenableBuilder(
              valueListenable: isWaiting,
              builder: (context, value, child) {
                return value
                    ? Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(40),
                        child: SpinKitFadingCircle(
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black,
                          size: 100.0,
                        ),
                      )
                    : SizedBox.shrink();
              },
            ),
            Container(
              padding: EdgeInsets.all(40),
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

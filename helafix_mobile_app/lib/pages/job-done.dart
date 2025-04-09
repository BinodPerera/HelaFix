import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/bottomNavigation.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../theme/colors.dart';
import 'package:helafix_mobile_app/components/appbar.dart';

class JobDone extends StatefulWidget {
  const JobDone({super.key});

  @override
  State<JobDone> createState() => _JobDoneState();
}

class _JobDoneState extends State<JobDone> {
  int currentStep = 1;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode ? AppColours.backgroundGradientDark : AppColours.backgroundGradientLight,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            int step = index + 1;
            bool isVisited = step < currentStep;
            bool isCurrent = step == currentStep;

            return Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isCurrent ? Colors.black : Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: isVisited
                        ? const Color.fromARGB(255, 0, 255, 8)
                        : Colors.white,
                    child: Text(
                      '$step',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (step != 3)
                  Container(
                    width: 40,
                    height: 2,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
              ],
            );
          }),
        ),
        
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (currentStep > 1)
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  currentStep--;
                });
              },
              child: Icon(Icons.arrow_back),
            ),
          SizedBox(width: 10),
          if (currentStep < 3)
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  currentStep++;
                });
              },
              child: Icon(Icons.arrow_forward),
            ),
        ],
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
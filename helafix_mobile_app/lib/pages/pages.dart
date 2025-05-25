import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:helafix_mobile_app/components/appbar.dart';
import 'package:helafix_mobile_app/components/bottom_navigation.dart';
import 'package:helafix_mobile_app/theme/colors.dart';

class Pages extends StatelessWidget {
  const Pages({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode
              ? AppColours.backgroundGradientDark
              : AppColours.backgroundGradientLight,
        ),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
          
              Card(
                child: ListTile(
                  title: const Text('Login Page'),
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Home Page'),
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                  },
                ),
              ),
          
              Card(
                child: ListTile(
                  title: const Text('Register Page'),
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                ),
              ),
          
              Card(
                child: ListTile(
                  title: const Text('User Profile Page'),
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
              ),
          
              Card(
                child: ListTile(
                  title: const Text('Service Add Page'),
                  onTap: () {
                    Navigator.pushNamed(context, '/add_service');
                  },
                ),
              ),
          
              Card(
                child: ListTile(
                  title: const Text('Service Manage Page'),
                  onTap: () {
                    Navigator.pushNamed(context, '/manage_service');
                  },
                ),
              ),
          
              Card(
                child: ListTile(
                  title: const Text('Recent Activities Page'),
                  onTap: () {
                    Navigator.pushNamed(context, '/recent_activities');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('My Activities Page'),
                  onTap: () {
                    Navigator.pushNamed(context, '/my_activities');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Job Done Part 1.1'),
                  onTap: () {
                    Navigator.pushNamed(context, '/job_done_1.1');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Job Done Part 1.2'),
                  onTap: () {
                    Navigator.pushNamed(context, '/job_done_1.2');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Job Done Part 2.1'),
                  onTap: () {
                    Navigator.pushNamed(context, '/job_done_2.1');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Job Done Part 2.2'),
                  onTap: () {
                    Navigator.pushNamed(context, '/job_done_2.2');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Job Done Part 2.3'),
                  onTap: () {
                    Navigator.pushNamed(context, '/job_done_2.3');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Payment Page'),
                  onTap: () {
                    Navigator.pushNamed(context, '/payment');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Review Page'),
                  onTap: () {
                    Navigator.pushNamed(context, '/review');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Sp Details Page'),
                  onTap: () {
                    Navigator.pushNamed(context, '/Sp-details');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Booking Page'),
                  onTap: () {
                    Navigator.pushNamed(context, '/Booking');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Add Home Page'),
                  onTap: () {
                    Navigator.pushNamed(context, '/Addhome');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Active Job'),
                  onTap: () {
                    Navigator.pushNamed(context, '/Inprocessjob');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Upcoming Job'),
                  onTap: () {
                    Navigator.pushNamed(context, '/Upcomingjob');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Finished Job'),
                  onTap: () {
                    Navigator.pushNamed(context, '/Pastjob');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Cart'),
                  onTap: () {
                    Navigator.pushNamed(context, '/Cart');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('HomePageCat Page'),
                  onTap: () {
                    Navigator.pushNamed(context, '/HomePageCat');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Provider Home Page'),
                  onTap: () {
                    Navigator.pushNamed(context, '/provider_home');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Emergency Contact Page'),
                  onTap: () {
                    Navigator.pushNamed(context, '/emergency_contact');
                  },
                ),
              ),
              // Card(
              //   child: ListTile(
              //     title: const Text('Esfsdfsdfsdfsf'),
              //     onTap: () {
              //       Navigator.pushNamed(context, '/jobdetails');
              //     },
              //   ),
              // ),
              Card(
                child: ListTile(
                  title: const Text('zdfdzfszdfsdf'),
                  onTap: () {
                    Navigator.pushNamed(context, '/Subcatlist');
                  },
                ),
              ),
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

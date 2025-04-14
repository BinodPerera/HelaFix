import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme_provider.dart';
import '../theme/colors.dart';
import '../components/appbar.dart';
import '../components//bottomNavigation.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? AppColours.primaryDark : AppColours.primaryLight,
      appBar: CustomAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode ? AppColours.backgroundGradientDark : AppColours.backgroundGradientLight,
        ),
        padding: EdgeInsets.all(20.0),
        child: Column(
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/images/users/user-1.png'),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(thickness: 2, height: 10),
                          Text('Binod Perera', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(
                            'Admin',
                            style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? AppColours.secondaryTextDark
                                  : AppColours.secondaryTextLight,
                              fontSize: 16,
                            ),
                          ),
                          Text('yasindubinod@gmai.com'),
                          Text('+94 77 123 4567'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'General Settings',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight,
                            ),
                          ),
                        ],
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.notifications),
                          title: Text('Bookings'),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to edit profile page
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.save_alt),
                          title: Text('Cart'),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to edit profile page
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.history),
                          title: Text('Recent Activities'),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.pushNamed(context, '/recent_activities');
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Emergency'),
                          leading: Icon(Icons.contact_emergency),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to add services page
                          },
                        ),
                      ),
        
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Account Settings',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight,
                            ),
                          ),
                        ],
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Personal Information'),
                          leading: Icon(Icons.edit),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to edit profile page
                            Navigator.pushNamed(context, '/profile_details');
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Change Password'),
                          leading: Icon(Icons.change_circle),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to edit profile page
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Delete Account'),
                          leading: Icon(Icons.warning_rounded),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to edit profile page
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Change Language'),
                          leading: Icon(Icons.language),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to edit profile page
                          },
                        ),
                      ),
        
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Favourite Locations',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight,
                            ),
                          ),
                        ],
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Add Home'),
                          leading: Icon(Icons.home),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to edit profile page
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Add Work'),
                          leading: Icon(Icons.work),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to manage services page
                          },
                        ),
                      ),
        
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Support',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight,
                            ),
                          ),
                        ],
                      ),
                      Card(
                        child: ListTile(
                          title: Text('About Us'),
                          leading: Icon(Icons.info),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to add services page
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Privacy Policy'),
                          leading: Icon(Icons.privacy_tip),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to add services page
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Terms of Service'),
                          leading: Icon(Icons.description),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to add services page
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('FAQ'),
                          leading: Icon(Icons.question_answer),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to add services page
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Logout'),
                          leading: Icon(Icons.logout),
                          trailing: Icon(Icons.arrow_forward_ios),
                          tileColor: Colors.red,
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          onTap: () {
                            // Navigate to add services page
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
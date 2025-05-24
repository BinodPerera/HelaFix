import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/pages/service/service_add.dart';
import 'package:helafix_mobile_app/pages/service/service_manage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../theme_provider.dart';
import '../theme/colors.dart';
import '../components/appbar.dart';
import '../components/bottom_navigation.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final User? user = FirebaseAuth.instance.currentUser;

    String name = user?.displayName ?? 'No Name';
    String email = user?.email ?? 'No Email';
    String phone = user?.phoneNumber ?? 'No Phone';
    String photoURL = user?.photoURL ?? ''; // Might be null for email/password users


    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? AppColours.primaryDark : AppColours.primaryLight,
      appBar: CustomAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode
              ? AppColours.backgroundGradientDark
              : AppColours.backgroundGradientLight,
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
                      backgroundImage: photoURL.isNotEmpty
                          ? NetworkImage(photoURL)
                          : AssetImage('assets/images/users/default.png') as ImageProvider,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(
                            'User',
                            style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? AppColours.secondaryTextDark
                                  : AppColours.secondaryTextLight,
                              fontSize: 16,
                            ),
                          ),
                          Text(email),
                          Text(phone),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 🔽 Existing Profile Menu Items Below This Line
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
                            Navigator.pushNamed(context, '/my_activities');
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.save_alt),
                          title: Text('Bookmarks'),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.pushNamed(context, '/Cart');
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
                          title: Text('Special Inquiries'),
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
                            Navigator.pushNamed(context, '/change_password');
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
                            Navigator.pushNamed(context, '/change_language');
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
                            Navigator.pushNamed(context, '/addhome');
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
                            Navigator.pushNamed(context, '/addhome');
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
                          title: Text('Terms & Conditions'),
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
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Admin Settings',
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
                          title: Text('Add Service Provider'),
                          leading: Icon(Icons.add),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to edit profile page
                            Navigator.pushNamed(context, '/add_service_provider');
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Manage Service Provider'),
                          leading: Icon(Icons.manage_accounts),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to edit profile page
                            Navigator.pushNamed(context, '/manage_service_provider');
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Add Service Category'),
                          leading: Icon(Icons.category),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to edit profile page
                            Navigator.pushNamed(context, '/add_category');
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Manage Service Category'),
                          leading: Icon(Icons.change_circle),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to edit profile page
                            Navigator.pushNamed(context, '/manage_category');
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Add Service Sub-Category'),
                          leading: Icon(Icons.category),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to edit profile page
                            Navigator.pushNamed(context, '/add_sub_category');
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Manage Service Sub-Category'),
                          leading: Icon(Icons.change_circle),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to edit profile page
                            Navigator.pushNamed(context, '/manage_sub_category');
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Add Service'),
                          leading: Icon(Icons.home_repair_service_sharp),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InsertServicePage(),
                              ),
                            );
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Manage Service'),
                          leading: Icon(Icons.design_services),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ServiceManagePage(),
                              ),
                            );
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
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Confirm Logout'),
                                content: Text('Are you sure you want to log out?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(), // Close dialog
                                    child: Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop(); // Close dialog
                                      await FirebaseAuth.instance.signOut();
                                      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                                    },
                                    child: Text('Yes'),
                                  ),
                                ],
                              ),
                            );
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

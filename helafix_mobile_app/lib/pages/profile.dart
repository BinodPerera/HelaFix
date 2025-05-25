import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/pages/profile_details.dart';
import 'package:helafix_mobile_app/pages/service/service_add.dart';
import 'package:helafix_mobile_app/pages/service/service_manage.dart';
import 'package:helafix_mobile_app/models/user.dart' as app_model;
import 'package:helafix_mobile_app/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../theme_provider.dart';
import '../theme/colors.dart';
import '../components/appbar.dart';
import '../components/bottom_navigation.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  app_model.User? firebaseUser;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  void _initializeUser() async {
    final user = await _loadUser();
    if (mounted) {
      setState(() {
        firebaseUser = user;
      });
    }
  }


  /// Loads the user from Firestore based on the current Firebase Auth user ID.
  Future<app_model.User?> _loadUser() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return null;

    final UserService userService = UserService();
    final app_model.User? firestoreUser = await userService.getUserById(userId);

    if (firestoreUser != null) {
      // user found, return the user object
      return firestoreUser;
    } 
    else {
      // user not found, return null
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final User? user = FirebaseAuth.instance.currentUser;

    String name = firebaseUser?.name ?? 'No Name';
    String email = firebaseUser?.email ?? 'No Email';
    String phone = firebaseUser?.phone ?? 'No Phone';
    String googleImage = user?.photoURL ?? '';
    String fireBaseImage = firebaseUser?.image_base64 ?? '';
    bool isAdmin = firebaseUser?.isAdmin ?? false;



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
                      backgroundImage: fireBaseImage.isNotEmpty
                          ? MemoryImage( base64Decode(fireBaseImage),)
                          : googleImage.isNotEmpty
                              ? NetworkImage(googleImage)
                              : AssetImage('assets/images/users/default.png') as ImageProvider,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(
                            isAdmin ? 'Admin' : 'User',
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
                      SettingsCard(
                        title: 'Bookings',
                        icon: Icons.notifications,
                        onTap: () {
                          Navigator.pushNamed(context, '/my_activities');
                        },
                      ),
                      SettingsCard(
                        title: 'Bookmarks',
                        icon: Icons.save_alt,
                        onTap: () {
                          Navigator.pushNamed(context, '/Cart');
                        },
                      ),
                      SettingsCard(
                        title: 'Recent Activities',
                        icon: Icons.history,
                        onTap: () {
                          Navigator.pushNamed(context, '/recent_activities');
                        },
                      ),
                      SettingsCard(
                        title: 'Special Inquiries',
                        icon: Icons.contact_emergency,
                        onTap: () {
                          // Navigate to special inquiries page
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Account Settings',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.isDarkMode
                                  ? AppColours.primaryTextDark
                                  : AppColours.primaryTextLight,
                            ),
                          ),
                        ],
                      ),
                      SettingsCard(
                        title: 'Personal Information',
                        icon: Icons.edit,
                        onTap: () async {
                          final updated = await Navigator.push(context, 
                            MaterialPageRoute(
                              builder: (context) => ProfileDetails(docId:  FirebaseAuth.instance.currentUser.toString(), user: firebaseUser!),
                          ),);

                          // refresh the user data if updated
                          if (updated == true) {
                            _initializeUser();
                          }
                        },
                      ),
                      SettingsCard(
                        title: 'Change Password',
                        icon: Icons.change_circle,
                        onTap: () {
                          Navigator.pushNamed(context, '/change_password');
                        },
                      ),
                      SettingsCard(
                        title: 'Delete Account',
                        icon: Icons.warning_rounded,
                        onTap: () {
                          // Navigate to delete account confirmation
                        },
                      ),
                      SettingsCard(
                        title: 'Change Language',
                        icon: Icons.language,
                        onTap: () {
                          Navigator.pushNamed(context, '/change_language');
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Favourite Locations',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.isDarkMode
                                  ? AppColours.primaryTextDark
                                  : AppColours.primaryTextLight,
                            ),
                          ),
                        ],
                      ),
                      SettingsCard(
                        title: 'Add Home',
                        icon: Icons.home,
                        onTap: () {
                          Navigator.pushNamed(context, '/addhome');
                        },
                      ),
                      SettingsCard(
                        title: 'Add Work',
                        icon: Icons.work,
                        onTap: () {
                          Navigator.pushNamed(context, '/addhome');
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Support',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.isDarkMode
                                  ? AppColours.primaryTextDark
                                  : AppColours.primaryTextLight,
                            ),
                          ),
                        ],
                      ),
                      SettingsCard(
                        title: 'About Us',
                        icon: Icons.info,
                        onTap: () {
                          // Navigate to about page
                        },
                      ),
                      SettingsCard(
                        title: 'Privacy Policy',
                        icon: Icons.privacy_tip,
                        onTap: () {
                          // Navigate to privacy policy
                        },
                      ),
                      SettingsCard(
                        title: 'Terms & Conditions',
                        icon: Icons.description,
                        onTap: () {
                          // Navigate to terms & conditions
                        },
                      ),
                      SettingsCard(
                        title: 'FAQ',
                        icon: Icons.question_answer,
                        onTap: () {
                          // Navigate to FAQ page
                        },
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
                              color: themeProvider.isDarkMode
                                  ? AppColours.primaryTextDark
                                  : AppColours.primaryTextLight,
                            ),
                          ),
                        ],
                      ),
                      SettingsCard(
                        title: 'Add Service Provider',
                        icon: Icons.add,
                        onTap: () {
                          Navigator.pushNamed(context, '/add_service_provider');
                        },
                      ),
                      SettingsCard(
                        title: 'Manage Service Provider',
                        icon: Icons.manage_accounts,
                        onTap: () {
                          Navigator.pushNamed(context, '/manage_service_provider');
                        },
                      ),
                      SettingsCard(
                        title: 'Add Service Category',
                        icon: Icons.category,
                        onTap: () {
                          Navigator.pushNamed(context, '/add_category');
                        },
                      ),
                      SettingsCard(
                        title: 'Manage Service Category',
                        icon: Icons.change_circle,
                        onTap: () {
                          Navigator.pushNamed(context, '/manage_category');
                        },
                      ),
                      SettingsCard(
                        title: 'Add Service Sub-Category',
                        icon: Icons.category,
                        onTap: () {
                          Navigator.pushNamed(context, '/add_sub_category');
                        },
                      ),
                      SettingsCard(
                        title: 'Manage Service Sub-Category',
                        icon: Icons.change_circle,
                        onTap: () {
                          Navigator.pushNamed(context, '/manage_sub_category');
                        },
                      ),

                      SettingsCard( title: 'Add Service', icon: Icons.home_repair_service_sharp, 
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InsertServicePage(),
                              ),
                            );
                          },
                      ),
                      SettingsCard(
                        title: 'Manage Services', 
                        icon: Icons.design_services, 
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceManagePage(),
                            ),
                          );
                        }
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

class SettingsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const SettingsCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(title),
        leading: Icon(icon),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
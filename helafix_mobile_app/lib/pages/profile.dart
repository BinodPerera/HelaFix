import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme_provider.dart';

import '../theme/colors.dart';

// importing components
import '../components/appbar.dart';

class Profile extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(

      backgroundColor: themeProvider.isDarkMode ? AppColours.primaryDark : AppColours.primaryLight,

      appBar: CustomAppBar(),

      body: Padding(
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
                        Text('Binod Perera', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(
                          'Admin',
                          style: TextStyle(
                            color: themeProvider.isDarkMode ? AppColours.secondaryTextDark : AppColours.secondaryTextLight,
                            fontSize: 16
                          )
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

            Text('Account Settings', style: TextStyle( 
              fontSize: 18, 
              fontWeight: FontWeight.bold,
              color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight,
            )),

            Divider(thickness: 2, height: 20),

            Card(
              child: ListTile(
                title: Text('Edit Profile'),
                trailing: Icon(Icons.edit),
                onTap: () {
                  // Navigate to edit profile page
                },
              ),
            ),

            Card(
              child: ListTile(
                title: Text('Manage Services'),
                trailing: Icon(Icons.home_repair_service),
                onTap: () {
                  // Navigate to edit profile page
                },
              ),
            ),

            Card(
              child: ListTile(
                title: Text('Add Services'),
                trailing: Icon(Icons.add_business),
                onTap: () {
                  // Navigate to edit profile page
                },
              ),
            ),

            SizedBox(height: 20),

            Row(
              children: [
                Text(
                  'Recent Activities', 
                  style: TextStyle( 
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    color: themeProvider.isDarkMode ? AppColours.primaryTextDark : AppColours.primaryTextLight,
                  )
                ),

                Spacer(),

                Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text(
                    'View All', 
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
              ],
            ),

            

            Divider(thickness: 2, height: 20),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColours.containerBackgroundLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Service Requested'),
                        subtitle: Text('Service Name'),
                        trailing: Text('2021-09-01'),
                      ),
                      ListTile(
                        title: Text('Service Requested'),
                        subtitle: Text('Service Name'),
                        trailing: Text('2021-09-01'),
                      ),
                      ListTile(
                        title: Text('Service Requested'),
                        subtitle: Text('Service Name'),
                        trailing: Text('2021-09-01'),
                      ),
                      ListTile(
                        title: Text('Service Requested'),
                        subtitle: Text('Service Name'),
                        trailing: Text('2021-09-01'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
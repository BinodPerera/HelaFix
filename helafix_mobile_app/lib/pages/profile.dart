import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme_provider.dart';

// importing components
import '../components/appbar.dart';

class Profile extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(

      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,

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
                        Text('Binod Perera [Admin]', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('yasindubinod@gmai.com'),
                        Text('+94 77 123 4567'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            Text('Account Settings', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold)),

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
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text('Recent Activities', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold)),
                        Divider(thickness: 0, height: 20),
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
                        ListTile(
                          title: Text('Service Requested'),
                          subtitle: Text('Service Name'),
                          trailing: Text('2021-09-01'),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            )


          ],
        ),
      ),
    );
  }
}
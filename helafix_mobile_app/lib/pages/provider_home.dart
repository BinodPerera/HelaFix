import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/components/bottom_navigation.dart';
import 'package:provider/provider.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/components/appbar_title.dart';

class ProviderHome extends StatefulWidget {
  const ProviderHome({super.key});

  @override
  State<ProviderHome> createState() => _ProviderHomeState();
}

class _ProviderHomeState extends State<ProviderHome> {

  final List<Map<String, dynamic>> current_jobs = [
    {
      '_id': '35jnsainsai',
      'path': ['cleaning', 'Home Cleaning', 'Deep Cleaning'],
      'time': '10.00 AM',
      'date': '02/04/2025',
      'user_name': 'Binod Perera',
      'user_image': 'assets/images/users/user-1.png',
      'address': 'No 5/A Nawagamugoda Road, Kumbuka, Gonapola Junction'
    },
    {
      '_id': '32jnsainsai',
      'path': ['cleaning', 'Home Cleaning', 'Deep Cleaning'],
      'time': '12.00 AM',
      'date': '22/04/2025',
      'user_name': 'Binod Perera',
      'user_image': 'assets/images/users/user-1.png',
      'address': 'No 15/B Palawaththa Road, Navinna'
    },
  ];

  final List<Map<String, dynamic>> requested_jobs = [
    {
      '_id': '35jnsainsai',
      'path': ['cleaning', 'Home Cleaning', 'Deep Cleaning'],
      'date': '02/04/2025',
      'user_name': 'Binod Perera',
      'user_image': 'assets/images/users/user-1.png',
    },
    {
      '_id': '32jnsainsai',
      'path': ['cleaning', 'Home Cleaning', 'Deep Cleaning'],
      'date': '22/04/2025',
      'user_name': 'Binod Perera',
      'user_image': 'assets/images/users/user-1.png',
    },
  ];

  final List<Map<String, dynamic>> upcoming_jobs = [
    {
      '_id': '35jnsainsai',
      'path': ['cleaning', 'Home Cleaning', 'Deep Cleaning'],
      'date': '02/04/2025',
      'user_name': 'Binod Perera',
      'user_image': 'assets/images/users/user-1.png',
      'address': 'No 5/A Nawagamugoda Road, Kumbuka, Gonapola Junction'
    },
    {
      '_id': '32jnsainsai',
      'path': ['cleaning', 'Home Cleaning', 'Deep Cleaning'],
      'date': '22/04/2025',
      'user_name': 'Binod Perera',
      'user_image': 'assets/images/users/user-1.png',
      'address': 'No 15/B Palawaththa Road, Navinna'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
  
    final double boxWidth = double.infinity;

    return Scaffold(
        backgroundColor: themeProvider.isDarkMode
            ? AppColours.primaryDark
            : AppColours.primaryLight,
        appBar: AppbarWithTitle(title: 'Helafix', showBackButton: true, showModeButton: true),
        body: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: themeProvider.isDarkMode
                ? AppColours.backgroundGradientDark
                : AppColours.backgroundGradientLight,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Main "My Order" container
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                    width: boxWidth,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      // border: Border.all(
                      //   color: Colors.grey,
                      //   width: 4,
                      // ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(31, 2, 2, 2),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'My Order',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 143,
                              height: 80,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 225, 229, 231),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(31, 182, 178, 178),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '10',
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Ongoing',
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 136, 135, 135),
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 25),
                            Container(
                              
                              width: 143,
                              height: 80,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 225, 229, 231),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(31, 182, 178, 178),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '12',
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Requested',
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 136, 135, 135),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: boxWidth,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 225, 229, 231),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(31, 242, 234, 234),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text(
                                'Completed',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 136, 135, 135),
                                ),
                              ),
                              Text(
                                '24',
                                style: TextStyle(
                                      fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // end of My Order

                  const SizedBox(height: 15.0),

                  // start of second main card
                  Container(
                    width: boxWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      // border: Border.all(
                      //   color: Colors.black,
                      //   width: 1,
                      // ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),

                    padding: const EdgeInsets.all(10),
                  
                    child: Padding(
                      padding: const EdgeInsets.all(10), 
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Today Jobs',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),

                          const SizedBox(height: 1), 
                          Divider(
                            thickness: 1.5,
                          ),
                          const SizedBox(height: 5),

                          ListView.builder(
                            shrinkWrap: true, // tells Flutter to take only the needed space
                            physics: NeverScrollableScrollPhysics(), // disables its own scrolling
                            itemCount: current_jobs.length,
                            itemBuilder: (context, index){
                              final currentJob = current_jobs[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                width: double.infinity,// fixed height you want
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 225, 229, 231),
                                    width: 4,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0, bottom: 12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min, // minimize column height
                                    children: [  
                                      Row(
                                        mainAxisSize: MainAxisSize.min, // prevent Row from expanding full width
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 8), // spacing between icon and text
                                          Text(
                                            currentJob['time'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min, // so row only takes needed width
                                        children: const [
                                          Text(
                                            'Cleaning',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 12, // adjusted size to fit well
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                                          SizedBox(width: 4),
                                          Text(
                                            'Home Cleaning',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                                          SizedBox(width: 4),
                                          Text(
                                            'Deep Cleaning',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            ''
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 20), // increased from 19 to 30 for more space

                                      // Image + Text Row
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,  // align children to the left
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: AssetImage(currentJob['user_image']),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20), // space between image and text
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                currentJob['user_name'],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 7),
                                              Text(
                                                currentJob['date'],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 20),

                                      Center(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.black,
                                              size: 14,
                                            ),
                                            SizedBox(width: 8),
                                            Flexible( // 🔥 This is the fix
                                              child: Text(
                                                currentJob['address'],
                                                overflow: TextOverflow.ellipsis, // adds "..." at the end
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  // end of the second main card

                  const SizedBox(height: 15), // 👈 This is the spacing between
                  
                  // start of the third main card - Requested jobs
                  Container(
                    width: boxWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      // border: Border.all(
                      //   color: Colors.black,
                      //   width: 1,
                      // ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),

                    padding: const EdgeInsets.all(10), // same padding on all sides
                  
                    child: Padding(
                      padding: const EdgeInsets.all(10), // same padding on all sides
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Requested Jobs',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                          const SizedBox(height: 5),

                          ListView.builder(
                            shrinkWrap: true, // tells Flutter to take only the needed space
                            physics: NeverScrollableScrollPhysics(), // disables its own scrolling
                            itemCount: requested_jobs.length,
                            itemBuilder: (context, index){
                              final requestedJob = requested_jobs[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 225, 229, 231),
                                    width: 4,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0, bottom: 12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min, // minimize column height
                                    children: [
                                      // Breadcrumb Row
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min, // so row only takes needed width
                                        children: const [
                                          Text(
                                            'Cleaning',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 12, // adjusted size to fit well
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                                          SizedBox(width: 4),
                                          Text(
                                            'Home Cleaning',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                                          SizedBox(width: 4),
                                          Text(
                                            'Deep Cleaning',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            ''
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 20), // increased from 19 to 30 for more space

                                      // Image + Text Row
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,  // align children to the left
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: AssetImage(requestedJob['user_image']),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20), // space between image and text
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                requestedJob['user_name'],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 7),
                                              Text(
                                                requestedJob['date'],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          'Cost: P/N',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),


                                      const SizedBox(height: 10),

                                      Center(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min, // prevent Row from expanding full width
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end, // Align buttons to the right
                                              children: [
                                                Container(
                                                  height: 40,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius: BorderRadius.circular(8),
                                                    // border: Border.all( // 👈 add this
                                                    //   color: Colors.black, // border color
                                                    //   width: 1.5,           // border width
                                                    // ),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      'Accept',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                Container(
                                                  height: 40,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius: BorderRadius.circular(8),
                                                    // border: Border.all(
                                                    //   color: Colors.black, 
                                                    //   width: 1.5,           
                                                    // ),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      'Decline',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                  ),
                  // end of third main card

                  const SizedBox(height: 15.0),

                  // start of the fourth main card - upcomming jobs
                  Container(
                    width: boxWidth, 
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      // border: Border.all(
                      //   color: Colors.black,
                      //   width: 1,
                      // ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),

                    padding: const EdgeInsets.all(10), // same padding on all sides
                  
                    child: Padding(
                      padding: const EdgeInsets.all(10), // same padding on all sides
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Upcoming Job',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                          const SizedBox(height: 1), 
                          Divider(
                            thickness: 1.5,
                          ),
                          const SizedBox(height: 5),

                          Center(
                            child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start, // prevent Row from expanding full width
                              children: const [
                               
                                SizedBox(width: 8), // spacing between icon and text
                                Text(
                                  'Wed, 3rd March, 2025',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 5),

                          ListView.builder(
                            shrinkWrap: true, // tells Flutter to take only the needed space
                            physics: NeverScrollableScrollPhysics(), // disables its own scrolling
                            itemCount: upcoming_jobs.length,
                            itemBuilder: (context, index){
                              final upcomingJob = upcoming_jobs[index];
                              return Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 225, 229, 231),
                                    width: 4,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0, bottom: 12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min, // minimize column height
                                    children: [
                                      // Breadcrumb Row
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min, // so row only takes needed width
                                        children: const [
                                          Text(
                                            'Cleaning',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 12, // adjusted size to fit well
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                                          SizedBox(width: 4),
                                          Text(
                                            'Home Cleaning',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                                          SizedBox(width: 4),
                                          Text(
                                            'Deep Cleaning',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            ''
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20), // increased from 19 to 30 for more space
                                      // Image + Text Row
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,  // align children to the left
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: AssetImage(upcomingJob['user_image']),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20), // space between image and text
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                upcomingJob['user_name'],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 7),
                                              Text(
                                                upcomingJob['date'],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Center(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.black,
                                              size: 14,
                                            ),
                                            SizedBox(width: 8),
                                            Flexible( // 🔥 This is the fix
                                              child: Text(
                                                upcomingJob['address'],
                                                overflow: TextOverflow.ellipsis, // adds "..." at the end
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
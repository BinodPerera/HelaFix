import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helafix_mobile_app/models/job.dart';
import 'package:helafix_mobile_app/models/service_provider.dart';
import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProviderHome extends StatefulWidget {
  final String email;

  const ProviderHome({
    super.key,
    required this.email,
  });

  @override
  State<ProviderHome> createState() => _ProviderHomeState();
}

class _ProviderHomeState extends State<ProviderHome> {
  String? providerId;
  bool isLoading = true;
  String? errorMessage;

  List<Map<String, dynamic>> current_jobs = [];
  List<Map<String, dynamic>> upcoming_jobs = [];

  @override
  void initState() {
    super.initState();
    fetchUserId();
  }

  // Fetch provider ID based on email
  Future<void> fetchUserId() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('service_providers')
          .where('email', isEqualTo: widget.email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final provider = ServiceProvider.fromMap(doc.data(), doc.id);
        setState(() {
          providerId = provider.id;
        });

        print('Fetched providerId: $providerId');

        // Fetch jobs now
        await fetchJobs();
      } else {
        setState(() {
          errorMessage = 'No provider found for this email';
          isLoading = false;
        });
        print(errorMessage);
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching provider: $e';
        isLoading = false;
      });
      print(errorMessage);
    }
  }

  // NEW: Fetch user location as Google Maps link
  Future<String> getUserLocationLink(String userId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (doc.exists) {
        final data = doc.data();
        final lat = data?['latitude'];
        final lng = data?['longitude'];

        if (lat != null && lng != null) {
          return 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
        }
      }
    } catch (e) {
      print('Error fetching user location: $e');
    }
    return 'https://www.google.com/maps'; // fallback
  }

  Future<String> getSubCategoryName(String subCategoryId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('sub_categories')
          .doc(subCategoryId)
          .get();

      if (doc.exists) {
        return doc.data()?['name'] ?? 'Unknown Subcategory';
      }
    } catch (e) {
      print('Error fetching subcategory name: $e');
    }

    return 'Unknown Subcategory';
  }

  Future<String> getUserName(String userId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (doc.exists) {
        return doc.data()?['name'] ?? 'Unknown User';
      }
    } catch (e) {
      print('Error fetching user name: $e');
    }
    return 'Unknown User';
  }

  // Fetch jobs assigned to provider and filter by status
  Future<void> fetchJobs() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('jobs')
          .where('provider_id', isEqualTo: providerId)
          .get();

      final jobs = querySnapshot.docs
          .map((doc) => Job.fromMap(doc.data(), doc.id))
          .toList();

      final current = await Future.wait(
        jobs.where((job) => job.status == 'Present').map((job) async {
          final userName = job.userId != null
              ? await getUserName(job.userId!)
              : 'Unknown User';

          final subCategoryName = await getSubCategoryName(job.subcategoriesid);

          final createdAt = job.createdAt ?? DateTime.now();

          return {
            '_id': job.jobId,
            'path': ['Job', subCategoryName],
            'time':
                '${createdAt.hour}:${createdAt.minute.toString().padLeft(2, '0')}',
            'date':
                '${createdAt.day.toString().padLeft(2, '0')}/${createdAt.month.toString().padLeft(2, '0')}/${createdAt.year}',
            'user_name': userName,
            'user_image': 'assets/images/users/user-1.png',
            'address': job.userId != null
                ? await getUserLocationLink(job.userId!)
                : 'https://www.google.com/maps',
          };
        }).toList(),
      );

      final upcoming = await Future.wait(
        jobs.where((job) => job.status == 'Future').map((job) async {
          final userName = job.userId != null
              ? await getUserName(job.userId!)
              : 'Unknown User';

          final subCategoryName = await getSubCategoryName(job.subcategoriesid);

          final createdAt = job.createdAt ?? DateTime.now();

          return {
            '_id': job.jobId,
            'path': ['Job', subCategoryName],
            'time':
                '${createdAt.hour}:${createdAt.minute.toString().padLeft(2, '0')}',
            'date':
                '${createdAt.day.toString().padLeft(2, '0')}/${createdAt.month.toString().padLeft(2, '0')}/${createdAt.year}',
            'user_name': userName,
            'user_image': 'assets/images/users/user-1.png',
            'address': job.userId != null
                ? await getUserLocationLink(job.userId!)
                : 'https://www.google.com/maps',
          };
        }).toList(),
      );

      setState(() {
        current_jobs = current;
        upcoming_jobs = upcoming;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching jobs: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }
    final themeProvider = Provider.of<ThemeProvider>(context);

    final double boxWidth = double.infinity;

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? AppColours.primaryDark
          : AppColours.primaryLight,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 0, 183, 255),
        elevation: 0,
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Image.asset(
            'assets/images/logo_light.png',
            height: 55,
            fit: BoxFit.contain,
          ),
        ),
      ),
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
                        'My Orders',
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
                          // Ongoing
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
                                    '${current_jobs.length}',
                                    style: const TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Text(
                                    'Ongoing',
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 136, 135, 135),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          // Upcoming
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
                                  '${upcoming_jobs.length}',
                                  style: const TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const Text(
                                  'Upcoming',
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
                      // Completed
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
                          children: [
                            const Text(
                              'Completed',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 136, 135, 135),
                              ),
                            ),
                            Text(
                              '${current_jobs.length}',
                              style: const TextStyle(
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
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Active Jobs',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 1),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 5),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: current_jobs.length,
                        itemBuilder: (context, index) {
                          final currentJob = current_jobs[index];
                          final jobId = currentJob[
                              '_id']; 

                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/jobdetailsSp',
                                arguments: {
                                  'jobId': jobId
                                }, 
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 225, 229, 231),
                                  width: 4,
                                ),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.access_time,
                                          color: Colors.black),
                                      const SizedBox(width: 8),
                                      Text(
                                        currentJob['time'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(thickness: 1),
                                  if (currentJob['path'] != null &&
                                      currentJob['path'] is List)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        for (int i = 0;
                                            i < currentJob['path'].length;
                                            i++) ...[
                                          if (i != 0)
                                            const Icon(Icons.chevron_right,
                                                color: Colors.grey, size: 20),
                                          Text(
                                            currentJob['path'][i].toString(),
                                            style: TextStyle(
                                              fontWeight: i ==
                                                      currentJob['path']
                                                              .length -
                                                          1
                                                  ? FontWeight.bold
                                                  : FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                currentJob['user_image']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            currentJob['user_name'],
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 7),
                                          Text(
                                            currentJob['date'],
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () async {
                                      final url =
                                          Uri.parse(currentJob['address']);
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url,
                                            mode:
                                                LaunchMode.externalApplication);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.location_on,
                                            color: Colors.black, size: 14),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                            currentJob['address'],
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // end of the second main card

                const SizedBox(height: 15), // 👈 This is the spacing between

                const SizedBox(height: 15.0),

                // start of the fourth main card - upcomming jobs
                Container(
                  width: boxWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
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
                          'Upcoming Job',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Divider(thickness: 1.5),
                        const SizedBox(height: 5),
                        Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(width: 8),
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
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: upcoming_jobs.length,
                          itemBuilder: (context, index) {
                            final job = upcoming_jobs[index];
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
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Breadcrumb (dynamic)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (int i = 0;
                                          i < job['path'].length;
                                          i++) ...[
                                        Text(
                                          job['path'][i],
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight:
                                                i == job['path'].length - 1
                                                    ? FontWeight.bold
                                                    : FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                        if (i != job['path'].length - 1)
                                          Icon(Icons.chevron_right,
                                              color: Colors.grey, size: 20),
                                      ],
                                    ],
                                  ),

                                  const SizedBox(height: 20),

                                  // Image + user name + date
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image:
                                                AssetImage(job['user_image']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            job['user_name'],
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 7),
                                          Text(
                                            job['date'],
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

                                  // Location row
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
                                        Flexible(
                                          child: Text(
                                            job['address'],
                                            overflow: TextOverflow.ellipsis,
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
                            );
                          },
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
    );
  }
}

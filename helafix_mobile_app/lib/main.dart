import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/pages/change_language.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';



// importing pages from pages folder
import './pages/pages.dart';
import './pages/login.dart';
import './pages/register.dart';
import './pages/home.dart'; 
import './pages/profile.dart';
import './pages/service_manage.dart';
import './pages/service_add.dart';
import './pages/recent_activities.dart';
import './pages/sp-details.dart';
import './pages/booking.dart';
import './pages/addhome.dart';
import './pages/cart.dart';


import './pages/job_done/job_done_1.1.dart';
import './pages/job_done/job_done_1.2.dart';
import './pages/job_done/job_done_2.1.dart';
import './pages/job_done/job_done_2.2.dart';
import './pages/job_done/job_done_2.3.dart';
import './pages/job_done/payment.dart';
import './pages/job_done/review.dart';


import './pages/job_details/active_job.dart';
import './pages/job_details/upcoming_job.dart';
import './pages/job_details/finished_job.dart';
import 'pages/my_activities.dart';
import './pages/profile_details.dart';
import 'package:helafix_mobile_app/pages/change_password.dart';
import 'package:helafix_mobile_app/pages/category_pages/home_page_cat.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Pages(),
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/profile': (context) => Profile(),
        '/home':(context) => HelaFixPage(),
        '/add_service':(context) => AddService(),
        '/manage_service':(context) => ManageService(),
        '/recent_activities':(context) => RecentActivities(),
        '/my_activities':(context) => Myactivities(),
        '/job_done_1.1':(context) => JobDoneOne(),
        '/job_done_1.2':(context) => JobDoneOneTwo(),
        '/job_done_2.1':(context) => JobDoneTwoOne(),
        '/job_done_2.2':(context) => JobDoneTwoTwo(),
        '/job_done_2.3':(context) => JobDoneTwoThree(),
        '/payment':(context) => Payment(),
        '/review':(context) => Review(),
        '/Sp-details':(context) => SpDetails(),
        '/Booking':(context) => Booking(),
        '/Addhome':(context) => MapScreen(),
        '/Activejob':(context) => JobActive(),
        '/Upcomingjob':(context) => JobUpcoming(),
        '/Finishedjob':(context) => JobFinished(),
        '/Cart':(context) => CartPage(),
        '/profile_details':(context) => ProfileDetails(),
        '/change_password': (context) => ChangePassword(),
        '/change_language': (context) => Changelanguage(),
        '/HomePageCat': (context) => HomePageCat(),
      }
    );
  }
}
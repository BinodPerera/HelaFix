import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/pages/Update_booking.dart';
import 'package:helafix_mobile_app/pages/about.dart';
import 'package:helafix_mobile_app/pages/category/manage_category.dart';
import 'package:helafix_mobile_app/pages/category_pages/cate_dt.dart';
import 'package:helafix_mobile_app/pages/category_sub/add_sub_category.dart';
import 'package:helafix_mobile_app/pages/category_sub/manage_sub_category.dart';
import 'package:helafix_mobile_app/pages/change_language.dart';
import 'package:helafix_mobile_app/pages/job_details/job_details.dart';
import 'package:helafix_mobile_app/pages/job_details/job_details_sp.dart';
import 'package:helafix_mobile_app/pages/select_location_page.dart';
import 'package:helafix_mobile_app/pages/emergency_contact.dart';
import 'package:helafix_mobile_app/pages/service-provider/provider_login.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

// importing pages from pages folder
import 'pages/authentication/login.dart';
import './pages/authentication/register.dart';
import './pages/home.dart'; 
import './pages/profile.dart';
import './pages/service_manage.dart';
import './pages/service_add.dart';
import './pages/recent_activities.dart';
import './pages/booking.dart';
import './pages/cart.dart';

import './pages/job_done/job_done_1.1.dart';
import './pages/job_done/job_done_1.2.dart';
import './pages/job_done/job_done_2.1.dart';
import './pages/job_done/job_done_2.2.dart';
import './pages/job_done/job_done_2.3.dart';
import './pages/job_done/payment.dart';
import './pages/job_done/review.dart';


import '../pages/service_providers_list_pages/service_providers_page.dart';

import './pages/job_details/active_job.dart';
import './pages/job_details/upcoming_job.dart';
import './pages/job_details/finished_job.dart';
import 'pages/my_activities.dart';
import 'package:helafix_mobile_app/pages/change_password.dart';
import 'package:helafix_mobile_app/pages/service-provider/add_service_provider.dart';
import 'package:helafix_mobile_app/pages/service-provider/manage-service-provider.dart';
import 'package:helafix_mobile_app/pages/category/add_category.dart';

import 'components/splash_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        '/': (context) => SplashScreen(),
        '/login': (context) => Login(),
        '/register': (context) => RegisterPage(),
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
        '/Booking':(context) => Booking(),
        '/Activejob':(context) => JobActive(),
        '/Upcomingjob':(context) => JobUpcoming(),
        '/Finishedjob':(context) => JobFinished(),
        '/Cart':(context) => CartPage(),
        '/change_password': (context) => ChangePassword(),
        '/change_language': (context) => Changelanguage(),
        '/add_service_provider': (context) => AddServiceProvider(),
        '/manage_service_provider': (context) => ManageServiceProvider(),
        '/add_category': (context) => AddCategory(),
        '/manage_category': (context) => ManageCategory(),
        '/Providers':(context) => ServiceProvidersPage(subRepairName: '',),
        '/addhome': (context) => SelectLocationPage(),
        '/add_sub_category': (context) => AddSubCategory(),
        '/manage_sub_category': (context) => ManageSubCategory(),
        '/emergency_contact': (context) => EmergencyContact(),
        '/jobdetails': (context) => JobDetails(),
        '/jobdetailsSp': (context) => JobDetailsSp(),
        '/Cartdt': (context) => CartDt(subCategoryId: '',),
        '/provider_login': (context) => ProviderLoginUI(),
        '/about': (context) => AboutPage(),
        '/updatebooking': (context) => UpdateBookingPage(),
      }
    );
  }
}
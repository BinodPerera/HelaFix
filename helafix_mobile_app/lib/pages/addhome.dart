import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../theme/colors.dart';
import '../components/bottom_navigation.dart';

class MapScreen extends StatefulWidget {
  final String name;
  final String email;
  final String mobile;
  final String password;

  // const MapScreen({super.key});

  const MapScreen({ 
    Key? key, 
    required this.name, 
    required this.email, 
    required this.mobile, 
    required this.password 
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // ignore: unused_field
  GoogleMapController? _mapController;
  String _address = 'Tap on the map to get address';
  Set<Marker> _markers = {};

  void _onMapTapped(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        
        if (place.country?.toLowerCase() == 'sri lanka') {
          final formattedAddress = [
            if (place.street != null && place.street!.isNotEmpty) place.street,
            if (place.locality != null && place.locality!.isNotEmpty)
              place.locality,
            if (place.country != null && place.country!.isNotEmpty)
              place.country,
          ].join(', ');

          setState(() {
            _address = formattedAddress;
            _markers = {
              Marker(
                markerId: MarkerId('selected-location'),
                position: position,
                infoWindow: InfoWindow(
                  title: 'Selected Location',
                  snippet: formattedAddress,
                ),
              ),
            };
          });
        } else {
          setState(() {
            _address = 'Only locations within Sri Lanka are allowed.';
            _markers = {};
          });
        }
      }
    } catch (e) {
      setState(() {
        _address = 'Failed to get address: $e';
        _markers = {};
      });
    }
  }

  void registerUser() {
    // Add your registration logic here
    // For example, send the data to your backend or Firebase
    print('Name: ${widget.name}');
    print('Email: ${widget.email}');
    print('Mobile: ${widget.mobile}');
    print('Password: ${widget.password}');

    // location
    print('Address: $_address');
    // latitude and longitude
    print('Latitude: ${_markers.first.position.latitude}');
    print('Longitude: ${_markers.first.position.longitude}');

    try {
      FirebaseFirestore.instance.collection('users').add({
        'name' : widget.name,
        'email' : widget.email,
        'mobile' : widget.mobile,
        'password' : widget.password,
        'address' : _address,
        'latitude' : _markers.first.position.latitude,
        'longitude' : _markers.first.position.longitude,
        'createdAt': FieldValue.serverTimestamp(),
      }).then((value) {
        Navigator.pushNamed(
          context, 
          '/success',
          arguments: {
            'type' : 'Success',
            'message' : 'Your Account Successfully Created!',
          }
        );
      }).catchError((error) {
        Navigator.pushNamed(
          context, 
          '/success', 
          arguments: {
            'type' : 'Error',
            'message' : 'Error adding user: $error',
          }
        );
      });
    } catch (e) {
      Navigator.pushNamed(
        context, 
        '/success', 
        arguments: {
          'type' : 'Error',
          'message' : 'Error adding user: $e',
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? AppColours.primaryDark
          : AppColours.primaryLight,
      appBar: AppBar(
        title: const Text(
          'Add Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 183, 255),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode
              ? AppColours.backgroundGradientDark
              : AppColours.backgroundGradientLight,
        ),
        child: Column(
          children: [
            Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(6.9271, 79.8612), // Default to Colombo
                  zoom: 12,
                ),
                onMapCreated: (controller) => _mapController = controller,
                onTap: _onMapTapped,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: _markers,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                _address,
                style: TextStyle(
                  color: themeProvider.isDarkMode
                      ? AppColours.dark
                      : AppColours.light,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 30, 255, 0),
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  registerUser();
                },
                child: Text(
                  'Add location',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/bookmarks');
          }
        },
      ),
    );
  }
}

class SuccessMessage extends StatelessWidget {

  final String type;
  final String message;
  
  const SuccessMessage({
    Key? key,
    required this.type,
    required this.message
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? AppColours.primaryDark
          : AppColours.primaryLight,
      body: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode
              ? AppColours.backgroundGradientDark
              : AppColours.backgroundGradientLight,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // add simple animation
            AnimatedContainer(
              duration: Duration(seconds: 3),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: type == 'Success' ? Colors.green : Colors.red,
              ),
              child: Icon(
                type == 'Success' ? Icons.check : Icons.error,
                color: Colors.white,
                size: 50,
              ),
            ),
            Text("$type", style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: type == 'Success' ? Colors.white : Colors.red,
            )),
            SizedBox(height: 20),
            Text("$message", style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: type == 'Success' ? Colors.white : Colors.red,
            )),
            SizedBox(height: 40),
            
            if (type == 'Success')
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/login');
              } , 
              child: Text('Go to login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            if (type == 'Error')
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/register');
              } , 
              child: Text('Go to register'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/bookmarks');
          }
        },
      ),
    );
  }
}

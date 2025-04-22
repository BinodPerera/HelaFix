import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../theme/colors.dart';
import '../components/bottomNavigation.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

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
                onPressed: () {},
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

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helafix_mobile_app/pages/home.dart';
import '../services/auth_service.dart';
import 'authentication/login.dart';

class SelectLocationPage extends StatefulWidget {
  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  LatLng? _selectedLatLng;
  String _address = "No location selected";

  final AuthService _authService = AuthService();
  String name = '';
  String email = '';
  String phone = '';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        setState(() {
          name = doc['name'] ?? '';
          email = doc['email'] ?? '';
          phone = doc['phone'] ?? '';
        });
      }
    }
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks.first;

      setState(() {
        _address =
            "${place.name}, ${place.street}, ${place.locality}, ${place.country}";
      });
    } catch (e) {
      setState(() {
        _address = "Could not fetch address";
      });
    }
  }

  void _saveLocation() async {
    if (_selectedLatLng != null) {
      String result = await _authService.updateUserLocation(
        latitude: _selectedLatLng!.latitude,
        longitude: _selectedLatLng!.longitude,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HelaFixPage()));
    });
  }

  void _skipLocation() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HelaFixPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
        actions: [
          TextButton(
            onPressed: _skipLocation,
            child: Text('Skip', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: Column(
        children: [
          // Top Info Card
          Card(
            margin: EdgeInsets.all(12),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("👤 Name: $name", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 6),
                  Text("📧 Email: $email", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 6),
                  Text("📱 Phone: $phone", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 6),
                  Text("📍 Address: $_address", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),

          // Map Area (Expanded)
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(6.9271, 79.8612),
                    zoom: 12,
                  ),
                  padding: EdgeInsets.only(bottom: 150), // 👈 Push map controls up
                  onTap: (LatLng position) {
                    setState(() {
                      _selectedLatLng = position;
                    });
                    _getAddressFromLatLng(position);
                  },
                  markers: _selectedLatLng != null
                      ? {
                          Marker(
                            markerId: MarkerId("selected_location"),
                            position: _selectedLatLng!,
                          )
                        }
                      : {},
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: _selectedLatLng != null ? _saveLocation : null,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          textStyle: TextStyle(fontSize: 18),
                          foregroundColor: Colors.white,
                          backgroundColor: _selectedLatLng != null ? Colors.blue : Colors.grey,
                        ),
                        child: Text("Save Location"),
                      ),
                      SizedBox(height: 10),
                      OutlinedButton(
                        onPressed: _skipLocation,
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          textStyle: TextStyle(fontSize: 16),
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromARGB(255, 124, 121, 125)
                        ),
                        child: Text("Skip"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

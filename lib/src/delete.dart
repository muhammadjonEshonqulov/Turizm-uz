import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapPage2 extends StatefulWidget {
  const MapPage2({super.key});

  @override
  _MapPage2State createState() => _MapPage2State();
}

class _MapPage2State extends State<MapPage2> {
  late GoogleMapController _mapController;
  Set<Marker> _markers = {};
  LatLng _currentPosition = LatLng(39.654012, 66.959720); // Default position
  Set<Polyline> _polylines = {};
  List<Map<String, String>> categories = [
    {'label': 'Mehmonxonalar', 'placeType': 'lodging'},
    {'label': 'Restoranlar', 'placeType': 'restaurant'},
    {'label': 'Bankomatlar', 'placeType': 'atm'},
    {'label': 'Savdo markazlari', 'placeType': 'shopping_mall'},
  ];

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool shouldOpenSettings = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Location Services Disabled'),
          content: Text('This page requires location services. Please enable it to proceed.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Settings'),
            ),
          ],
        ),
      );

      if (shouldOpenSettings) {
        await Geolocator.openLocationSettings();
      }
    }

    // Check and request location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        return Future.error('Location permissions are permanently denied');
      }
    }

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
    _mapController.animateCamera(CameraUpdate.newLatLng(_currentPosition));
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _getCurrentLocation();
  }

  void _fetchNearbyPlaces(String placeType) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_currentPosition.latitude},${_currentPosition.longitude}&radius=1500&type=$placeType&key=YOUR_GOOGLE_API_KEY';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _markers.clear();
        for (var place in data['results']) {
          final marker = Marker(
            markerId: MarkerId(place['place_id']),
            position: LatLng(place['geometry']['location']['lat'], place['geometry']['location']['lng']),
            infoWindow: InfoWindow(title: place['name']),
            onTap: () {
              _drawRoute(LatLng(place['geometry']['location']['lat'], place['geometry']['location']['lng']));
            },
          );
          _markers.add(marker);
        }
      });
    } else {
      print('Error fetching places');
    }
  }

  void _drawRoute(LatLng destination) async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_currentPosition.latitude},${_currentPosition.longitude}&destination=${destination.latitude},${destination.longitude}&key=YOUR_GOOGLE_API_KEY';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['routes'].isNotEmpty) {
        final polylinePoints = PolylinePoints();
        final List<PointLatLng> result = polylinePoints.decodePolyline(data['routes'][0]['overview_polyline']['points']);

        setState(() {
          List<LatLng> polylineCoordinates = result.map((point) => LatLng(point.latitude, point.longitude)).toList();
          Polyline polyline = Polyline(
            polylineId: PolylineId('route'),
            color: Colors.blue,
            points: polylineCoordinates,
            width: 5,
          );
          _polylines.clear();
          _polylines.add(polyline);
        });
      }
    } else {
      print('Error fetching directions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: _currentPosition, zoom: 14.0),
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
          ),
          Positioned(
            top: 20,
            left: 10,
            right: 10,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return GestureDetector(
                    onTap: () {
                      _fetchNearbyPlaces(category['placeType']!);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                      ),
                      child: Text(category['label']!),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

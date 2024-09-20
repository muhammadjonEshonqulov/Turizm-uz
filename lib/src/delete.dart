import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:turizm_uz/core/common/widgets/loading_widget.dart';
import 'package:turizm_uz/core/res/const_colors.dart';

// class Place {
//   final String name;
//   final String description;
//   final LatLng location;
//
//   Place({required this.name, required this.description, required this.location});
// }
//
// // Provider to manage the selected place
// class PlacesProvider extends ChangeNotifier {
//   Place? _selectedPlace;
//
//   Place? get selectedPlace => _selectedPlace;
//
//   void selectPlace(Place place) {
//     _selectedPlace = place;
//     notifyListeners();
//   }
// }

// class PlacesListScreen extends StatelessWidget {
//   final List<Place> places = [
//     Place(name: "Hospital", description: "City Hospital", location: LatLng(37.7749, -122.4194)),
//     Place(name: "Cafe", description: "Starbucks Cafe", location: LatLng(37.7799, -122.4294)),
//     Place(name: "School", description: "Greenwood High School", location: LatLng(37.7849, -122.4094)),
//     Place(name: "Library", description: "City Library", location: LatLng(37.7649, -122.3994)),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Places"),
//       ),
//       body: ListView.builder(
//         itemCount: places.length,
//         itemBuilder: (context, index) {
//           final place = places[index];
//           return ListTile(
//             title: Text(place.name),
//             subtitle: Text(place.description),
//             onTap: () {
//               Provider.of<PlacesProvider>(context, listen: false).selectPlace(place);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => MapScreen()),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class MapScreen extends StatelessWidget {
//   const MapScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final selectedPlace = Provider.of<PlacesProvider>(context).selectedPlace;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(selectedPlace != null ? selectedPlace.name : 'Map'),
//       ),
//       body: selectedPlace != null
//           ? GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: selectedPlace.location,
//                 zoom: 14.0,
//               ),
//               markers: {
//                 Marker(
//                   markerId: MarkerId(selectedPlace.name),
//                   position: selectedPlace.location,
//                   infoWindow: InfoWindow(
//                     title: selectedPlace.name,
//                     snippet: selectedPlace.description,
//                   ),
//                 ),
//               },
//             )
//           : Center(child: Text("No place selected")),
//     );
//   }
// }

class GoogleMapSample extends StatefulWidget {
  const GoogleMapSample({super.key});

  @override
  _GoogleMapSampleState createState() => _GoogleMapSampleState();
}

class _GoogleMapSampleState extends State<GoogleMapSample> {
  GoogleMapController? _googleMapController;
  Position? _currentPosition;
  final LatLng _initialPosition = const LatLng(37.4223, -122.0848);
  final LatLng _pDinamoPark = const LatLng(39.66644933327316, 66.92736914337651);
  final LatLng _pRegiston = const LatLng(39.660952995532696, 66.96363778572882);

  final Completer<GoogleMapController> _mapCompleter = Completer<GoogleMapController>();

  Map<PolylineId, Polyline> polyLines = {};

  final Location _locationController = Location();

  LatLng? _currentLatLng;

  @override
  void initState() {
    super.initState();
    // _getCurrentLocation();

    getLocationUpdates().then((onValue) => {
          getPolylinePoints().then((coordinates) => {
                generatePolyLineFromPoints(coordinates),
              })
        });
  }

  // Request location permissions and get the current location
  // Future<void> _getCurrentLocation() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
  //     permission = await Geolocator.requestPermission();
  //   }
  //
  //   if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
  //     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  //     setState(() {
  //       _currentPosition = position;
  //       _moveCameraToCurrentPosition();
  //     });
  //   } else {
  //     // Handle permission denied
  //     print("Location permission denied");
  //   }
  // }

  // void _moveCameraToCurrentPosition() {
  //   if (_currentPosition != null) {
  //     LatLng currentLatLng = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
  //     _googleMapController?.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(target: currentLatLng, zoom: 14),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Map Sample')),
      body: _currentLatLng == null
          ? LoadingWidget()
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 13,
              ),
              mapType: MapType.normal,

              markers: {
                Marker(
                  markerId: MarkerId('Current Location'),
                  position: _currentLatLng!,
                ),
                const Marker(
                  markerId: MarkerId('Registan Square'),
                  position: LatLng(39.667391499698184, 66.9279012116597),
                ),
                const Marker(
                  markerId: MarkerId('Dinamo Stadium'),
                  position: LatLng(39.66959104466574, 67.04679515264026),
                ),
              },
              polylines: Set<Polyline>.of(polyLines.values),
              myLocationEnabled: true,
              // Enable "My Location" button on the map
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _googleMapController = controller;
                _mapCompleter.complete(controller);
              },
            ),
    );
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  Future<void> _cameraToPosition(LatLng position) async {
    final GoogleMapController controller = await _mapCompleter.future;

    CameraPosition newCameraPosition = CameraPosition(target: position, zoom: 14.0);

    // controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: position, zoom: 14.0)));

    await controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      print('currentLocation = $currentLocation');
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          _currentLatLng = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentLatLng!);
        });
      }
    });
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: colorGreen,
      points: polylineCoordinates,
      width: 8,
    );

    setState(() {
      polyLines[id] = polyline;
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylinePoints = [];
    PolylinePoints polylinePointsInstance = PolylinePoints();
    PolylineResult result = await polylinePointsInstance.getRouteBetweenCoordinates(
      googleApiKey: "AIzaSyDEK3cRl6V8Su8taSN-VaOaHTNL39x8-QI",
      request: PolylineRequest(origin: PointLatLng(_pDinamoPark.longitude, _pDinamoPark.longitude), destination: PointLatLng(_pRegiston.latitude, _pRegiston.longitude), mode: TravelMode.driving),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylinePoints.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print('result.errorMessage ${result.errorMessage}');
    }
    return polylinePoints;
  }
}

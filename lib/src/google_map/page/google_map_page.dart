import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_box_shadows.dart';
import 'package:turizm_uz/core/res/const_colors.dart';
import 'package:turizm_uz/core/res/const_icons.dart';
import 'package:turizm_uz/core/utils/core_utils.dart';

import '../model/place_result.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  List<dynamic> predictions = [];
  final LatLng _center = const LatLng(39.654012, 66.959720);
  final TextEditingController _searchController = TextEditingController();
  final Set<Marker> _markers = {};
  final String apiKey = 'AIzaSyDEK3cRl6V8Su8taSN-VaOaHTNL39x8-QI';
  Position? _currentPosition;
  Set<Polyline> _polylines = {};

  // List<dynamic> _lodgings = [];

  List<PlaceResult> places = [];

  bool _isLoading = false;

  Map<String, String> _selectedCategory = {};

  bool locationEnabled = false;
  String statusMessage = 'Checking location services...';

  @override
  void initState() {
    super.initState();
    checkLocationService();
    _getCurrentLocation();
    // _fetchLodgingsNearMe();
  }

  Future<void> checkLocationService() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Prompt the user to enable location services
      bool shouldOpenSettings = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Geolokatsiyangiz o\'chiq xolatda'),
          content: Text('Joylashuv xizmatlari o‘chirilgan. Joylashuv sozlamalarini ochmoqchimisiz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // User declined
              child: Text('Yo\'q'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // User accepted
              child: Text('Ha'),
            ),
          ],
        ),
      );

      if (shouldOpenSettings) {
        // Open the location settings so the user can enable location services
        await Geolocator.openLocationSettings();
      }

      setState(() {
        locationEnabled = false;
        statusMessage = 'Location services are disabled. Please enable them.';
      });
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, show a message to the user
        setState(() {
          statusMessage = 'Location permission denied';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        statusMessage = 'Location permissions are permanently denied, you need to enable them from the app settings.';
      });

      await Geolocator.openAppSettings();
      return;
    }

    setState(() {
      locationEnabled = true;
      statusMessage = 'Location services are enabled!';
    });
  }

  Future<void> _fetchLodgingsNearMe() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<dynamic> lodgings = await fetchNearbyLodgings(position.latitude, position.longitude, apiKey);

      // String lodging = lodgings[0];
      print('lodging data => $lodgings');

      for (var action in lodgings) {
        PlaceResult place = PlaceResult.fromJson(action);
        places.add(place);

        // print('_fetchLodgingsNearMe ${photoUrl}');
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching lodgings: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<List<dynamic>> fetchNearbyLodgings(double latitude, double longitude, String apiKey) async {
    final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=1500&type=lodging&key=$apiKey';

    print('url => $url');
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['results'];
    } else {
      throw Exception('Failed to load nearby lodgings');
    }
  }

  final List<Map<String, String>> categories = [
    {'icon': ConstIcons.bed, 'label': 'Mehmonxonalar', 'name_place': 'lodging'},
    {'icon': ConstIcons.wineglassTriangle, 'label': 'Restoranlar', 'name_place': 'restaurant'},
    {'icon': ConstIcons.bag, 'label': 'Savdo markazlari', 'name_place': 'Shopping centers'},
    {'icon': ConstIcons.cashOut, 'label': 'Bankomatlar', 'name_place': 'ATMs'},
    {'icon': ConstIcons.cart, 'label': 'Oziq-ovqatlar', 'name_place': 'Foods'},
    {'icon': ConstIcons.cup, 'label': 'Kafelar', 'name_place': 'Cafes'},
    {'icon': ConstIcons.stethoscope, 'label': 'Shifoxonalar', 'name_place': 'hospital'},
  ];

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void searchPlaces(String query) async {
    String url = '';
    if (_selectedCategory.isNotEmpty == true) {
      print('_selectedCategory.values.last ${_selectedCategory.values.last}');
      url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&types=${_selectedCategory.values.last}&key=$apiKey&language=uz';
    } else {
      url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$apiKey&language=uz';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 && mounted) {
      final data = jsonDecode(response.body);
      setState(() {
        predictions = data['predictions'];
      });
    } else {
      print('Error fetching autocomplete predictions: ${response.reasonPhrase}');
    }
  }

  void setPlaceMarker(dynamic prediction) async {
    final placeId = prediction['place_id'];
    final String url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey&language=uz';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 && mounted) {
      final data = jsonDecode(response.body);
      final result = data['result'];
      final lat = result['geometry']['location']['lat'];
      final lng = result['geometry']['location']['lng'];
      final placeName = result['name'];

      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15),
      );

      setState(() {
        _markers.clear();
        _markers.add(Marker(
          markerId: MarkerId(placeId),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(title: placeName),
        ));
        predictions = [];
        _searchController.text = placeName;
        _drawRoute(LatLng(lat, lng));
      });
    } else {
      print('Error fetching place details: ${response.reasonPhrase}');
    }
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;
      _mapController.animateCamera(CameraUpdate.newLatLng(LatLng(_currentPosition!.latitude, _currentPosition!.longitude)));
    });
  }

  void _drawRoute(LatLng destination) async {
    if (_currentPosition == null) return;

    LatLng currentLatLng = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);

    String url = 'https://maps.googleapis.com/maps/api/directions/json?origin=${currentLatLng.latitude},${currentLatLng.longitude}&destination=${destination.latitude},${destination.longitude}&mode=driving&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['routes'].isNotEmpty) {
        final points = data['routes'][0]['overview_polyline']['points'];
        final List<LatLng> polylineCoordinates = _decodePolyline(points);

        setState(() {
          _polylines.clear();
          _polylines.add(Polyline(
            polylineId: PolylineId('route'),
            visible: true,
            points: polylineCoordinates,
            width: 5,
            color: Colors.blue,
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
          ));
        });
      }
    } else {
      print('Error fetching directions: ${response.reasonPhrase}');
    }
  }

  String getPhotoUrl(String photoReference, String apiKey, {int? maxWidth = 400}) {
    return 'https://maps.googleapis.com/maps/api/place/photo'
        '?maxwidth=$maxWidth'
        '&photoreference=$photoReference'
        '&key=$apiKey';
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      polyline.add(LatLng((lat / 1E5), (lng / 1E5)));
    }

    return polyline;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
            markers: _markers,
            polylines: _polylines,
            zoomControlsEnabled: false,
            myLocationEnabled: false,
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Search for places',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              searchPlaces(value);
                            } else {
                              setState(() {
                                predictions = [];
                              });
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            predictions = [];
                          });
                        },
                      ),
                    ],
                  ),
                ),
                if (predictions.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: predictions.length,
                      itemBuilder: (context, index) {
                        var prediction = predictions[index];
                        return ListTile(
                          leading: const Icon(Icons.location_on),
                          title: Text(prediction['description'] ?? ''),
                          onTap: () {
                            setPlaceMarker(prediction);
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          if (predictions.isEmpty)
            Positioned(
              top: 70,
              left: 16,
              right: 16,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((category) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (_selectedCategory == category) {
                            _selectedCategory = {};
                          } else {
                            _selectedCategory = category;
                          }
                        });
                        /*  searchPlaces(_searchController.text);*/

                        _fetchLodgingsNearMe();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: _selectedCategory == category ? colorPrimary : colorWhite,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: ConstBoxShadows.boxShadowsForFinanceItem(
                              shadowColor: colorBlack.withOpacity(0.1),
                              dy: 3,
                            )),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              category.values.first,
                              width: 20,
                              colorFilter: _selectedCategory == category ? ColorFilter.mode(colorWhite, BlendMode.srcIn) : null,
                            ),
                            const Gap(8),
                            text12Poppins(category.values.elementAt(1), color: _selectedCategory == category ? colorWhite : colorDefTex),
                          ],
                        ) /*ChoiceChip(
                        label: Row(
                          children: [
                            SvgPicture.asset(category.values.first),
                            text12Poppins(category.values.last),
                          ],
                        ),
                        selected: _selectedCategory == category,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = category;
                          });
                          searchPlaces(_searchController.text);
                        },
                      )*/
                        ,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          if (places.isNotEmpty)
            Positioned(
              bottom: 13,
              left: 16,
              right: 16,
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: places.length,
                    itemBuilder: (context, index) {
                      final photoReference = places[index].photos?.first.photoReference ?? '';
                      final photoUrl = getPhotoUrl(photoReference, apiKey, maxWidth: places[index].photos?.first.width);
                      print('photoUrl => $photoUrl');
                      print('places[index] => ${places[index]}');
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: colorWhite, boxShadow: ConstBoxShadows.boxShadows),
                        child: Row(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: photoUrl,
                                  width: 140,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const SizedBox(width: 20, height: 20, child: CupertinoActivityIndicator()),
                                  errorWidget: (context, url, error) => Image.asset(ConstIcons.placeHolderImg),
                                )),
                            const Gap(8),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text14Poppins(formatName(places[index].name), fontWeight: FontWeight.w500),
                                  Gap(4),
                                  text10Poppins('\$50 dan boshlang’ich narxlar'),
                                  Gap(4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: colorWarning, width: 1),
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(ConstIcons.crownMinimalistic),
                                            const Gap(4),
                                            text12Poppins('VIP', color: colorWarning),
                                          ],
                                        ),
                                      ),
                                      // const Gap(38),
                                      InkWell(
                                        onTap: () {},
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [text12Poppins('Ko’rish', color: colorPrimary), Icon(Icons.arrow_forward, color: colorPrimary, size: 20)],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            )
        ],
      ),
    );
  }
}

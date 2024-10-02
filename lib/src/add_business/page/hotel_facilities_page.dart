import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turizm_uz/core/common/widgets/buttons.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_colors.dart';

import '../../registration/page/widgets.dart';

class HotelFacilitiesPage extends StatefulWidget {
  const HotelFacilitiesPage({super.key, required this.onNext});

  final Function() onNext;

  @override
  State<HotelFacilitiesPage> createState() => _HotelFacilitiesPageState();
}

class _HotelFacilitiesPageState extends State<HotelFacilitiesPage> {
  TextEditingController hotelNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  final Set<Marker> _markers = {};

  final _formKey = GlobalKey<FormState>();

  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text16Poppins('Mehmonxona ma’lumotlari'),
          const Gap(24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.circular(8.0)),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textField(hotelNameController, 'Mehmonxona nomi ', (v) {}, isUnderlined: true, errorText: 'Ushbu qator to’ldirilishi shart', isRequired: true),
                  textField(cityController, 'Shahar ', (v) {}, isUnderlined: true, errorText: 'Ushbu qator to’ldirilishi shart', isRequired: true),
                  textField(streetController, 'Ko’cha ', (v) {}, isUnderlined: true, errorText: 'Ushbu qator to’ldirilishi shart', isRequired: true),
                  textField(locationController, 'Lokatsiya', (v) {}, isUnderlined: true, errorText: 'Ushbu qator to’ldirilishi shart', isRequired: true, isEnabled: false),
                  const Gap(20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 200,
                      child: _currentPosition == null ? loadingGoogleMap() : googleMap(),
                    ),
                  ),
                  const Gap(24),
                  defSecondaryButton('Davom etish', () {
                    if (_formKey.currentState?.validate() == true) {
                      widget.onNext.call();
                    }
                  }),
                  const Gap(16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleTap(LatLng tappedPoint) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
      ));
    });
    locationController.text = '${tappedPoint.latitude}, ${tappedPoint.longitude}';
  }

  Widget googleMap() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _currentPosition!,
        zoom: 15.0,
      ),
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      markers: _markers,
      onTap: _handleTap,
    );
  }

  Widget loadingGoogleMap() {
    return Stack(
      children: [
        const GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(39.6563664679254, 66.98444917446845),
            zoom: 15.0,
          ),
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        ),
        Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
          height: 200,
          width: double.infinity,
          child: CupertinoActivityIndicator(),
        )
      ],
    );
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await _showLocationDisabledDialog();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await _showPermissionDeniedDialog();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await _showPermissionDeniedDialog();
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> _showLocationDisabledDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Services Disabled'),
          content: Text('Please enable location services.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Geolocator.openLocationSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showPermissionDeniedDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Permission Denied'),
          content: Text('Please allow location permission from settings.'),
          actions: <Widget>[
            TextButton(
              child: Text('Open Settings'),
              onPressed: () {
                Geolocator.openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

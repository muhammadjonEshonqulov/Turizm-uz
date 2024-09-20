import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexMapExample extends StatefulWidget {
  const YandexMapExample({super.key});

  @override
  _YandexMapExampleState createState() => _YandexMapExampleState();
}

class _YandexMapExampleState extends State<YandexMapExample> {
  late YandexMapController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yandex Map Example'),
      ),
      body: YandexMap(
        onMapCreated: (YandexMapController yandexMapController) {
          controller = yandexMapController;
        },
        mapObjects: [
          PlacemarkMapObject(
            point: const Point(latitude: 55.751244, longitude: 37.618423), // Example coordinates
            icon: PlacemarkIcon.single(PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage('assets/marker.png'),
            )),
            mapId: MapObjectId('placemark_1'),
          )
        ],
        // initialCameraPosition: const CameraPosition(
        //   target: Point(latitude: 55.751244, longitude: 37.618423), // Moscow coordinates
        //   zoom: 10.0,
        // ),
      ),
    );
  }
}

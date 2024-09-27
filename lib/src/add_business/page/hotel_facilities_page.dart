import 'package:flutter/material.dart';

class HotelFacilitiesPage extends StatefulWidget {
  @override
  _HotelFacilitiesPageState createState() => _HotelFacilitiesPageState();
}

class _HotelFacilitiesPageState extends State<HotelFacilitiesPage> {
  Map<String, bool> facilities = {
    'WiFi': false,
    'Parking': false,
    'Pool': false,
    'Gym': false,
    // Add more facilities here
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mehmonxonadagi qulayliklar'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: facilities.keys.map((String key) {
          return CheckboxListTile(
            title: Text(key),
            value: facilities[key],
            onChanged: (bool? value) {
              setState(() {
                facilities[key] = value!;
              });
            },
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Proceed to next step
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HotelDetailsPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mehmonxona ma’lumotlari'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mehmonxona nomi',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Iltimos, mehmonxona nomini kiriting';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Shahar',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Iltimos, shaharni kiriting';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Ko\'cha',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Iltimos, ko\'chani kiriting';
                  }
                  return null;
                },
              ),
              // Add map widget for location if needed
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Proceed to next step
                  }
                },
                child: Text('Davom etish'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

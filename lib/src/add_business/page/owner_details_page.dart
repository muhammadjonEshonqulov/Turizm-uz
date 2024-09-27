import 'package:flutter/material.dart';

import 'hotel_details_page.dart';

class OwnerDetailsPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  OwnerDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mehmonxona egasi ma’lumotlari'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Ism va familiya',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Iltimos, ism va familiyangizni kiriting';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Telefon',
                  prefixText: '+998 ',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Iltimos, telefon raqamingizni kiriting';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Iltimos, elektron pochtangizni kiriting';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Proceed to next step
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HotelDetailsPage()),
                    );
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

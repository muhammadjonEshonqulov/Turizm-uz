import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotosPage extends StatefulWidget {
  @override
  _UploadPhotosPageState createState() => _UploadPhotosPageState();
}

class _UploadPhotosPageState extends State<UploadPhotosPage> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _images = [];

  Future<void> _pickImage() async {
    final pickedImages = await _picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        _images!.addAll(pickedImages);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mehmonxona rasmlarini yuklang'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Rasm yuklash'),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _images!.length,
              itemBuilder: (context, index) {
                return Image.file(File(_images![index].path));
              },
            ),
          ),
        ],
      ),
    );
  }
}

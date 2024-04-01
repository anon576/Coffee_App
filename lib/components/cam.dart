import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AppComponent{
  
static Future<void> handleImagePicker(context,File image) async {
  final ImagePicker _picker = ImagePicker();
  
  // Show options for choosing from the gallery or capturing from the camera
  final action = await showDialog<ImageSource>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select Image Source'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text('Camera'),
                onTap: () {
                  Navigator.pop(context, ImageSource.camera);
                },
              ),
            ],
          ),
        ),
      );
    },
  );

  if (action != null) {
    File? pickedFile = (await _picker.pickImage(source: action)) as File?;

    if (pickedFile != null) {
      image = pickedFile;
      // Handle the picked image
      // For example, you can display the image or upload it to a server
    }
  }
}

}

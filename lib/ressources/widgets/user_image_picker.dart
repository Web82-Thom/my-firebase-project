import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myfirebaseproject/modules/auth/views/auth_view.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn,);

  final void Function(File pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    setState(() {
      pickedImage != null?
      _pickedImage = File(pickedImage.path): null;
      // authController.imageSignUp = _pickedImage;
      print("_pickedImage = $_pickedImage");
    });
    pickedImage != null?
    widget.imagePickFn(File(pickedImage.path)): null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImage != null ? FileImage(_pickedImage!) : null,
          radius: 80,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 0,
              left: 130,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.amber,
                size: 45,
              ),
              // onPressed: pickImage,
              onPressed: pickImage,
            ),
          ),
        ),
      ],
    );
  }
}

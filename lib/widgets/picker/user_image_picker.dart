import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? pickedUserImage;

  void pickImage() async{
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);

    setState(() {
      pickedUserImage = pickedImageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey.shade300,
          backgroundImage : pickedUserImage != null ? FileImage(pickedUserImage!) : null,
        ),
        TextButton.icon(
            icon: const Icon(Icons.image),
            label: const Text('Add Image'),
            onPressed: pickImage,
          ),
      ],
    );
  }
}

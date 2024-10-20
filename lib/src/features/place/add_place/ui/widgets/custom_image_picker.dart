import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'image_content_view.dart';

class CustomImagePicker extends StatefulWidget {
  const CustomImagePicker({
    super.key,
    required this.onImageSelected,
  });

  final Function(File file) onImageSelected;

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File? _selectedImageFile;
  Uint8List? _selectedImageBytes;

  Future<void> _pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 24
    );
    if (pickedImage == null) {
      return;
    }

    setState(() {
      _selectedImageFile = File(pickedImage.path);
    });
    widget.onImageSelected(_selectedImageFile!);
  }

  Future<void> _takePictureWithCamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 25,
      maxWidth: 600,
    );
    if (pickedImage == null) {
      return;
    }

    if (kIsWeb) {
      final imageBytes = await pickedImage.readAsBytes();
      setState(() {
        _selectedImageBytes = imageBytes;
      });
    } else {
      setState(() {
        _selectedImageFile = File(pickedImage.path);
      });
      widget.onImageSelected(_selectedImageFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          child: ImageContentView(
            imageBytes: _selectedImageBytes,
            imageFile: _selectedImageFile,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: _pickImageFromGallery,
              icon: const Icon(Icons.photo_album_rounded),
              label: const Text("Pick Image"),
            ),
            const Text(
              "or",
              style: TextStyle(color: Colors.white70),
            ),
            TextButton.icon(
              onPressed: _takePictureWithCamera,
              icon: const Icon(Icons.camera_alt_rounded),
              label: const Text("Take Picture"),
            ),
          ],
        ),
      ],
    );
  }
}

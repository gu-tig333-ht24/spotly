import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class ImageDisplay extends StatefulWidget {
  const ImageDisplay({
    super.key,
    required this.onImageSelected,
  });

  final Function(File file) onImageSelected;

  @override
  State<ImageDisplay> createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  File? _selectedImageFile;
  Uint8List? _selectedImageBytes;

  Future<void> _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
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
    Widget imageDisplay = TextButton.icon(
      icon: const Icon(Icons.camera),
      label: const Text('Take Picture'),
      onPressed: _takePicture,
    );

    if (kIsWeb && _selectedImageBytes != null) {
      imageDisplay = GestureDetector(
        onTap: _takePicture,
        child: Image.memory(
          _selectedImageBytes!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    } else if (_selectedImageFile != null) {
      imageDisplay = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _selectedImageFile!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return imageDisplay;
  }
}

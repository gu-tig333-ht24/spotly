import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../../../../../core/constants/app_sizes.dart';
import 'image_content_view.dart';

class CustomImagePicker extends StatefulWidget {
  const CustomImagePicker({
    super.key,
    required this.onImageSelected,
    this.initialSelection,
  });

  final Function(File file) onImageSelected;
  final File? initialSelection;

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File? _selectedImageFile;
  Uint8List? _selectedImageBytes;

  @override
  void initState() {
    super.initState();

    if (widget.initialSelection == null) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePicker(widget.initialSelection!);
    });
  }

  void _initializePicker(File image) {
    _changeImage(image);
  }

  void _changeImage(File file) {
    setState(() => _selectedImageFile = file);
    widget.onImageSelected(file);
  }

  Future<void> _pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    if (pickedImage == null) {
      return;
    }

    _changeImage(File(pickedImage.path));
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
      _changeImage(File(pickedImage.path));
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
        const SizedBox(height: AppSizes.s10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: _pickImageFromGallery,
              icon: const Icon(Icons.photo_album_rounded),
              label: const Text("Pick Image"),
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

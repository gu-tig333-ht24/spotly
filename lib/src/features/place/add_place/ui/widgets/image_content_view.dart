import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageContentView extends StatelessWidget {
  const ImageContentView({
    super.key,
    this.imageBytes,
    this.imageFile,
  });

  final Uint8List? imageBytes;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb && imageBytes != null) {
      return Image.memory(
        imageBytes!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    } else if (imageFile != null) {
      return Image.file(
        imageFile!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    return Text(
      "No image chosen",
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onSurface),
    );
  }
}

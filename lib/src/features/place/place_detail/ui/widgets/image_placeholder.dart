import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.image_not_supported_rounded,
      color: Colors.white70,
      size: 100,
    );
  }
}

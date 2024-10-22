import 'package:flutter/material.dart';

class CenteredPlaceholderText extends StatelessWidget {
  const CenteredPlaceholderText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 24,
        ),
      ),
    );
  }
}

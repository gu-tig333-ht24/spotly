import 'package:flutter/material.dart';

class CenteredErrorText extends StatelessWidget {
  const CenteredErrorText({
    super.key,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 24,
        ),
      ),
    );
  }
}

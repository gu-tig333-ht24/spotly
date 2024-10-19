import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'This app is created by students at Gothenburg University.\n\n'
            '© 2024, TIG333, All Rights Reserved.',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              height: 1.5,
              color: Theme.of(context).colorScheme.onSurface, // Dynamic text colour for dark/light mode support
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

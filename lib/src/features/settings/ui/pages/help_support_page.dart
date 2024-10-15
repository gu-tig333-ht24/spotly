import 'package:flutter/material.dart';
import '../../../places/providers/places.dart';
import '../../../../core/widgets/places_list.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help and Support'),
      ),
      body: const Center(
        child: Text('Help and Support Information'),
      ),
    );
  }
}

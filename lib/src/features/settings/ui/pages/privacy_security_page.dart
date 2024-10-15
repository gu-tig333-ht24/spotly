import 'package:flutter/material.dart';
import '../../../places/providers/places.dart';
import '../../../../core/widgets/places_list.dart';

class PrivacySecurityPage extends StatelessWidget {
  const PrivacySecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy and Security'),
      ),
      body: const Center(
        child: Text('Privacy and Security Settings'),
      ),
    );
  }
}

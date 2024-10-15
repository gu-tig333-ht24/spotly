import 'package:flutter/material.dart';
import '../../../places/providers/places.dart';
import '../../../../core/widgets/places_list.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: const Center(
        child: Text('Contact Us Information'),
      ),
    );
  }
}

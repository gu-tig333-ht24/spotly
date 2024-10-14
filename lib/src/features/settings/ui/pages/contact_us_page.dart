import 'package:flutter/material.dart';
import 'package:spotly/src/features/places/providers/places.dart';
import 'package:spotly/src/core/widgets/places_list.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

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

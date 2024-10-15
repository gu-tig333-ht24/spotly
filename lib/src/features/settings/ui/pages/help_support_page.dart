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
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Need help or have questions?',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'For any inquiries regarding the app, including technical support, bug reports, or feature requests, feel free to contact us via the following channels:',
              style: TextStyle(fontSize: 16, height: 1.5, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              '1. Visit our support page:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            ),
            Text(
              'https://support.spotly.com',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
            SizedBox(height: 20),
            Text(
              '2. Email our support team:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            ),
            Text(
              'support@spotly.com',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              '3. Frequently Asked Questions (FAQ):',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            ),
            Text(
              'You can find answers to common questions and issues in our FAQ section within the app or on our website.',
              style: TextStyle(fontSize: 16, height: 1.5, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

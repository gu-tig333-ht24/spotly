import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help and Support'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Need help or have questions?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white ),
            ),
            const SizedBox(height: 20),
            const Text(
              'For any inquiries regarding the app, including technical support, bug reports, or feature requests, feel free to contact us via the following channels:',
              style: TextStyle(fontSize: 16, height: 1.5, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              '1. Visit our support page:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
            ),
            const Text(
              'https://support.spotly.com',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            const Text(
              '2. Email our support team:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
            ),
            const Text(
              'support@spotly.com',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              '3. Frequently Asked Questions (FAQ):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
            ),
            const Text(
              'You can find answers to common questions and issues in our FAQ section within the app or on our website.',
              style: TextStyle(fontSize: 16, height: 1.5, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

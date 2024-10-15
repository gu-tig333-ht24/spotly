import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'If you have any questions or need support, feel free to reach us:',
              style: TextStyle(fontSize: 16, height: 1.5, color: Colors.white), // White color
            ),
            const SizedBox(height: 20), // Add space between text and contact info
            const Text(
              'Phone:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white), // White color
            ),
            const Text(
              '+46-31-786 00 00',
              style: TextStyle(fontSize: 16, color: Colors.white), // White color
            ),
            const SizedBox(height: 20),
            const Text(
              'Email:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white), // White color
            ),
            const Text(
              'spotly@student.gu.se',
              style: TextStyle(fontSize: 16, color: Colors.white), // White color
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'If you have any questions or need support, feel free to reach us:',
              style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.white), // White color
            ),
            SizedBox(height: 20), // Add space between text and contact info
            Text(
              'Phone:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white), // White color
            ),
            Text(
              '+46-31-786 00 00',
              style:
                  TextStyle(fontSize: 16, color: Colors.white), // White color
            ),
            SizedBox(height: 20),
            Text(
              'Email:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white), // White color
            ),
            Text(
              'spotly@student.gu.se',
              style:
                  TextStyle(fontSize: 16, color: Colors.white), // White color
            ),
          ],
        ),
      ),
    );
  }
}

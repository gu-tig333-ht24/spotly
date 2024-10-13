import 'package:flutter/material.dart';

class PrivacySecurityPage extends StatelessWidget {
  const PrivacySecurityPage({Key? key}) : super(key: key);

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

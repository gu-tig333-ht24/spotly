// Update SettingsPage for use of Riverpod for state handling

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../main/ui/custom_app_bar.dart';
import '../../../main/ui/custom_navigation_bar.dart';
import '../../providers/settings_provider.dart'; // Import Riverpod-provider
import 'privacy_security_page.dart';
import 'help_support_page.dart';
import 'contact_us_page.dart';
import 'about_page.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get settings state from Riverpod
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: "Settings",
      ),
      bottomNavigationBar: const CustomNavigationBar(),
      body: ListView(
        children: [
          // Notifications toggle switch
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: settings.notificationsEnabled,
            onChanged: (bool value) {
              ref.read(settingsProvider.notifier).toggleNotifications(value);
            },
          ),
          const Divider(),

          // Privacy and Security
          ListTile(
            title: const Text('Privacy and Security'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PrivacySecurityPage()),
              );
            },
          ),
          const Divider(),

          // Help and Support
          ListTile(
            title: const Text('Help and Support'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HelpSupportPage()),
              );
            },
          ),
          const Divider(),

          // Contact Us
          ListTile(
            title: const Text('Contact Us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactUsPage()),
              );
            },
          ),
          const Divider(),

          // About
          ListTile(
            title: const Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

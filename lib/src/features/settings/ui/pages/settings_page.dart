import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/providers/dark_mode_provider.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_navigation_bar.dart';
import '../../providers/settings_provider.dart';
import 'about_page.dart';
import 'contact_us_page.dart';
import 'help_support_page.dart';
import 'privacy_security_page.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SettingsState settings = ref.watch(settingsProvider);

    // Fetch dark mode state from provider
    final isDarkMode = ref.watch(darkModeProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: "Settings",
      ),
      bottomNavigationBar: const CustomNavigationBar(),
      body: ListView(
        padding: const EdgeInsets.only(bottom: AppSizes.s20),
        children: [
          // Dark mode toggle switch
          SwitchListTile(
            title: const Text("Dark Mode"),
            tileColor: Colors.transparent,
            value: isDarkMode, // current value from provider
            onChanged: (bool value) {
              ref.read(darkModeProvider.notifier).toggleDarkMode();
            },
          ),
          const Divider(height: 0),

          // Notifications toggle switch
          SwitchListTile(
            title: const Text("Enable Notifications"),
            tileColor: Colors.transparent,
            value: settings.notificationsEnabled,
            onChanged: (bool value) {
              ref.read(settingsProvider.notifier).toggleNotifications(value);
            },
          ),
          const Divider(height: 0),

          // Privacy and Security
          ListTile(
            title: const Text("Privacy and Security"),
            tileColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PrivacySecurityPage()),
              );
            },
          ),
          const Divider(height: 0),

          // Help and Support
          ListTile(
            title: const Text("Help and Support"),
            tileColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HelpSupportPage()),
              );
            },
          ),
          const Divider(height: 0),

          // Contact Us
          ListTile(
            title: const Text("Contact Us"),
            tileColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactUsPage()),
              );
            },
          ),
          const Divider(height: 0),

          // About
          ListTile(
            title: const Text("About"),
            tileColor: Colors.transparent,
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

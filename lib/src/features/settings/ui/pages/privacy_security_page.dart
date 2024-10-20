import 'package:flutter/material.dart';

class PrivacySecurityPage extends StatelessWidget {
  const PrivacySecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy and Security'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy:',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 10), 
            Text(
              'Spotly stores all data locally on your device. If you are logged into iCloud and have enabled its backup option or the Spotly iCloud sync feature, your data will be backed up to your personal iCloud account. You can manage your backup settings directly in your iCloud preferences.',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    height: 1.5,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 20), // Distance between textblocks
            Text(
              'Data security:',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              'Spotly does not collect any personal data. However, the app uses Google Maps, which may collect location information as part of its functionality. For more information on how Google Maps handles your data, please refer to Google\'s Privacy Policy.',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    height: 1.5,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 20),
            Text(
              'Security measures:',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              'All data transmitted between the app and external services, such as iCloud, is encrypted to ensure your data is protected during transmission.',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    height: 1.5,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

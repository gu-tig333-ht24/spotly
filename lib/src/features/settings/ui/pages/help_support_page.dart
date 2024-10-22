import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: "Help and Support",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.s20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Need help or have questions?",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 18,
                  ),
            ),
            const SizedBox(height: AppSizes.s20),
            Text(
              "For any inquiries regarding the app, including technical "
              "support, bug reports, or feature requests, feel free to "
              "contact us via the following channels:",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    height: 1.5,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: AppSizes.s20),
            Text(
              "1. Visit our support page:",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            Text(
              "https://support.spotly.com",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.blue,
                  ),
            ),
            const SizedBox(height: AppSizes.s20),
            Text(
              "2. Email our support team:",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            Text(
              "support@spotly.com",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: AppSizes.s20),
            Text(
              "3. Frequently Asked Questions (FAQ):",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            Text(
              "You can find answers to common questions and issues in our FAQ "
              "section within the app or on our website.",
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

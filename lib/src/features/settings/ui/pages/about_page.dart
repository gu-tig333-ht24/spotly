import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: "About",
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.s20),
        child: Center(
          child: Text(
            "This app was created by students at Gothenburg University.\n\n"
            "© 2024, TIG333, All Rights Reserved.",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  height: 1.5,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface, // Dynamic text colour for dark/light mode support
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

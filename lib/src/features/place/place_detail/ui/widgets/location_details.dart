import 'package:flutter/material.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/models/location.dart';
import 'location_rich_text.dart';

class LocationDetails extends StatelessWidget {
  const LocationDetails({
    super.key,
    required this.location,
  });

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Location",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: AppSizes.s10),
        LocationRichText(
          label: "Latitude",
          text: location.latitude.toString(),
        ),
        const SizedBox(height: AppSizes.s4),
        LocationRichText(
          label: "Longitude",
          text: location.longitude.toString(),
        ),
      ],
    );
  }
}

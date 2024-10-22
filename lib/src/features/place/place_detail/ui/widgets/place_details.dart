import 'package:flutter/material.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/models/place.dart';
import '../../../../../core/utils/datetime_extensions.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          place.title,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSizes.s10),
        if (place.description != null && place.description!.isNotEmpty)
          Text(
            place.description!,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        const SizedBox(height: AppSizes.s10),
        Text(
          "Created on: ${place.createdAt.toLocal().friendlyFormat}",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ],
    );
  }
}

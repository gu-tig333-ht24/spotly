import 'package:flutter/material.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/models/place.dart';

class PlaceListTile extends StatelessWidget {
  const PlaceListTile({
    super.key,
    required this.place,
    required this.onTap,
  });

  final Place place;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.image_rounded,
                color: place.imagePath == null ? Colors.teal.shade700 : null,
              ),
              const SizedBox(height: AppSizes.s4),
              Icon(
                Icons.location_on_rounded,
                color: place.location == null ? Colors.teal.shade700 : null,
              ),
            ],
          ),
          const SizedBox(width: AppSizes.s10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                place.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              if (place.description != null &&
                  place.description!.isNotEmpty) ...[
                const SizedBox(height: AppSizes.s4),
                Text(
                  place.description!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.9),
                      ),
                ),
              ],
            ],
          ),
        ],
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.white54,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSizes.s20,
      ),
    );
  }
}

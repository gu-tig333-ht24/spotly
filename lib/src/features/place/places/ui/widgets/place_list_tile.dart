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
      tileColor: Colors.indigo,
      title: Text(
        place.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: place.description != null && place.description!.isNotEmpty
          ? Text(
              place.description!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      leading: Icon(
        Icons.image_rounded,
        color: place.imagePath == null ? Colors.grey : Colors.green,
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

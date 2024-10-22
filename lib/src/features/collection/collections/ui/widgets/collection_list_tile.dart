import 'package:flutter/material.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/models/collection.dart';
import '../../../../../core/theme/app_theme.dart';

class CollectionListTile extends StatelessWidget {
  const CollectionListTile({
    super.key,
    required this.collection,
    required this.onTap,
  });

  final Collection collection;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: Colors.teal.shade900,
      title: Text(
        collection.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle:
          collection.description != null && collection.description!.isNotEmpty
              ? Text(
                  collection.description!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              : null,
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

import 'package:flutter/material.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/models/place.dart';

class PlaceItemsList extends StatelessWidget {
  PlaceItemsList({super.key});

  final List<Place> items = [];

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Text(
          "No places available.",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 24,
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: items.length,
      itemBuilder: (BuildContext _, int index) {
        final Place place = items[index];

        return ListTile(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const Text("Place Detail Page"),
            ),
          ),
          title: Text(place.title),
          trailing: const Icon(
            Icons.chevron_right,
            color: Colors.white54,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.s10),
        );
      },
      separatorBuilder: (_, __) => const Divider(thickness: 0.5),
    );
  }
}

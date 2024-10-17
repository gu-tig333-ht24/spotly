import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/models/place_collection.dart';
import '../../../place_items/ui/pages/place_items_page.dart';
import '../../providers/place_collection_list_provider.dart';

class PlaceCollectionList extends ConsumerWidget {
  const PlaceCollectionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<PlaceCollection>> placeCollectionsValue = ref.watch(
      placeCollectionListProvider,
    );

    return placeCollectionsValue.when(
      data: (List<PlaceCollection> placeCollections) {
        if (placeCollections.isEmpty) {
          return const Center(
            child: Text(
              "No collections available.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 24,
              ),
            ),
          );
        }

        return ListView.separated(
          itemCount: placeCollections.length,
          itemBuilder: (BuildContext _, int index) {
            final PlaceCollection collection = placeCollections[index];

            return ListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PlaceItemsPage(),
                ),
              ),
              title: Text(collection.title),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.white54,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: AppSizes.s10),
            );
          },
          separatorBuilder: (_, __) => const Divider(thickness: 0.5),
        );
      },
      error: (e, _) => Center(
        child: Text(e.toString()),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: Colors.deepPurpleAccent,
        ),
      ),
    );
  }
}

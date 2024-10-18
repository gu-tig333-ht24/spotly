import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

import '../../../../../core/models/place_collection.dart';
import '../../../../../core/widgets/centered_error_text.dart';
import '../../../../../core/widgets/centered_progress_indicator.dart';
import '../../../place_items/ui/pages/place_items_page.dart';
import '../../providers/place_collection_list_provider.dart';
import 'collection_list_tile.dart';

class PlaceCollectionList extends ConsumerStatefulWidget {
  const PlaceCollectionList({super.key});

  @override
  ConsumerState createState() => _PlaceCollectionListState();
}

class _PlaceCollectionListState extends ConsumerState<PlaceCollectionList> {
  late final PlaceCollectionListController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ref.read(placeCollectionListProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.retrieveCollections();
    });
  }

  @override
  Widget build(BuildContext context) {
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

            return SwipeActionCell(
              key: ObjectKey(collection.id),
              backgroundColor: Colors.transparent,
              selectedForegroundColor: Colors.transparent,
              trailingActions: [
                SwipeAction(
                    title: "Delete",
                    color: Colors.red,
                    onTap: (CompletionHandler handler) async {
                      await handler(true);
                      await _controller.deleteCollection(collection);
                    }),
                SwipeAction(
                    title: "Edit",
                    color: Colors.deepPurpleAccent,
                    onTap: (CompletionHandler handler) async {
                      // TODO: Navigate to Edit Page
                    }),
              ],
              child: CollectionListTile(
                collection: collection,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlaceItemsPage(
                      collection: collection,
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 1),
        );
      },
      error: (e, _) => CenteredErrorText(errorMessage: e.toString()),
      loading: () => const CenteredProgressIndicator(),
    );
  }
}

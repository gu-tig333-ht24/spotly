import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

import '../../../../../core/models/collection.dart';
import '../../../../../core/widgets/centered_error_text.dart';
import '../../../../../core/widgets/centered_progress_indicator.dart';
import '../../../../place/places/ui/pages/place_list_page.dart';
import '../../providers/collection_list_provider.dart';
import 'collection_list_tile.dart';

class CollectionListView extends ConsumerStatefulWidget {
  const CollectionListView({super.key});

  @override
  ConsumerState createState() => _CollectionListViewState();
}

class _CollectionListViewState extends ConsumerState<CollectionListView> {
  late final CollectionListController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ref.read(collectionListProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.retrieveCollections();
    });
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Collection>> collectionsValue = ref.watch(
      collectionListProvider,
    );

    return collectionsValue.when(
      data: (List<Collection> collections) {
        if (collections.isEmpty) {
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
          itemCount: collections.length,
          itemBuilder: (BuildContext _, int index) {
            final Collection collection = collections[index];

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
                    builder: (_) => PlaceListPage(
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

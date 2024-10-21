import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

import '../../../../../core/models/place.dart';
import '../../../../../core/widgets/centered_error_text.dart';
import '../../../../../core/widgets/centered_placeholder_text.dart';
import '../../../../../core/widgets/centered_progress_indicator.dart';
import '../../../../share/providers/share_provider.dart';
import '../../../../share/services/share_service.dart';
import '../../../place_detail/ui/pages/place_detail_page.dart';
import '../../providers/place_list_provider.dart';
import 'place_list_tile.dart';

class PlaceListView extends ConsumerStatefulWidget {
  const PlaceListView({
    super.key,
    required this.collectionId,
  });

  final int collectionId;

  @override
  ConsumerState createState() => _PlaceListViewState();
}

class _PlaceListViewState extends ConsumerState<PlaceListView> {
  late final PlaceListController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ref.read(placeListProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.retrievePlaces(widget.collectionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Place>> placeValue = ref.watch(
      placeListProvider,
    );

    return placeValue.when(
      data: (List<Place> places) {
        if (places.isEmpty) {
          return const CenteredPlaceholderText(
            text: "No places available.",
          );
        }

        return ListView.separated(
          itemCount: places.length,
          itemBuilder: (BuildContext _, int index) {
            final Place place = places[index];

            return SwipeActionCell(
              key: ObjectKey(place.id),
              backgroundColor: Colors.transparent,
              selectedForegroundColor: Colors.transparent,
              leadingActions: [
                SwipeAction(
                    title: "Share",
                    color: Colors.deepPurpleAccent,
                    onTap: (CompletionHandler handler) async {
                      handler(false);

                      final ShareService shareService =
                          ref.read(shareServiceProvider);
                      final RenderBox? box =
                          context.findRenderObject() as RenderBox?;
                      Rect? sharePositionOrigin;
                      if (await shareService.isThisDeviceIpad()) {
                        sharePositionOrigin =
                            box!.localToGlobal(Offset.zero) & box.size;
                      }
                      await shareService.sharePlace(place, sharePositionOrigin);
                    })
              ],
              trailingActions: [
                SwipeAction(
                    title: "Delete",
                    color: Colors.red,
                    onTap: (CompletionHandler handler) async {
                      await handler(true);
                      await _controller.deletePlace(place);
                    }),
                SwipeAction(
                    title: "Edit",
                    color: Colors.deepPurpleAccent,
                    onTap: (CompletionHandler handler) async {
                      // TODO: Navigate to Edit Page
                    }),
              ],
              child: PlaceListTile(
                place: place,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlaceDetailPage(place: place),
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

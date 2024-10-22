import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

import '../../../../core/models/place.dart';
import '../../../../core/widgets/centered_placeholder_text.dart';
import '../../../place/add_edit_place/ui/pages/edit_place_page.dart';
import '../../../place/place_detail/ui/pages/place_detail_page.dart';
import '../../../place/places/ui/widgets/place_list_tile.dart';
import '../../../share/providers/share_provider.dart';
import '../../../share/services/share_service.dart';

class PlaceList extends StatelessWidget {
  const PlaceList({
    super.key,
    required this.places,
    required this.onDelete,
  });

  final List<Place> places;
  final Function(Place place) onDelete;

  void _navigateToEditPlacePage(
    BuildContext context,
    Place place,
  ) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EditPlacePage(
            place: place,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return const CenteredPlaceholderText(
        text: "No places available.",
      );
    }

    return Consumer(builder: (context, WidgetRef ref, _) {
      return ListView.separated(
        itemCount: places.length,
        separatorBuilder: (_, __) => const SizedBox(height: 1),
        itemBuilder: (BuildContext _, int index) {
          final Place place = places[index];

          return SwipeActionCell(
            key: ObjectKey(place.id),
            backgroundColor: Colors.transparent,
            selectedForegroundColor: Colors.transparent,
            leadingActions: [
              SwipeAction(
                  title: "Share",
                  color: Colors.teal.shade700,
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
                  color: Colors.red.shade900,
                  onTap: (CompletionHandler handler) async {
                    await handler(true);
                    onDelete(place);
                  }),
              SwipeAction(
                  title: "Edit",
                  color: Colors.teal.shade700,
                  onTap: (CompletionHandler handler) async {
                    handler(false);
                    _navigateToEditPlacePage(context, place);
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
      );
    });
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/models/place.dart';
import '../../../../../core/widgets/centered_error_text.dart';
import '../../../../../core/widgets/centered_progress_indicator.dart';
import '../../../../shared/ui/widgets/place_list.dart';
import '../../providers/place_list_provider.dart';

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
        return PlaceList(
          places: places,
          onDelete: (Place placeToDelete) {
            ref.read(placeListProvider.notifier).deletePlace(placeToDelete);
          },
        );
      },
      error: (e, _) => CenteredErrorText(errorMessage: e.toString()),
      loading: () => const CenteredProgressIndicator(),
    );
  }
}

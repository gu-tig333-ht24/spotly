import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/place.dart';
import '../../../../core/widgets/centered_error_text.dart';
import '../../../../core/widgets/centered_progress_indicator.dart';
import '../../providers/place_search_provider.dart';
import 'place_list.dart';

class SearchListView extends ConsumerStatefulWidget {
  const SearchListView({super.key});

  @override
  ConsumerState createState() => _SearchListViewState();
}

class _SearchListViewState extends ConsumerState<SearchListView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Place>> searchResultsValue = ref.watch(
      placeSearchProvider,
    );

    return searchResultsValue.when(
      data: (List<Place> places) {
        return PlaceList(
          places: places,
          onDelete: (Place placeToDelete) {},
        );
      },
      loading: () => const CenteredProgressIndicator(),
      error: (e, _) => CenteredErrorText(errorMessage: e.toString()),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/place_search_provider.dart';

class CustomSearchBar extends ConsumerStatefulWidget {
  const CustomSearchBar({super.key});

  @override
  ConsumerState createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<CustomSearchBar> {
  late final PlaceSearchController _placeSearchController;
  late final TextEditingController _searchTextController;

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _placeSearchController = ref.read(placeSearchProvider.notifier);

    _searchTextController.addListener(() {
      _placeSearchController.searchPlaces(_searchTextController.text);
    });
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchTextController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Search for Places...",
        hintStyle: const TextStyle(color: Colors.white60),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        suffixIcon: _searchTextController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.white),
                onPressed: () {
                  _searchTextController.clear();
                  _placeSearchController
                      .searchPlaces(_searchTextController.text);
                },
              )
            : null,
      ),
    );
  }
}

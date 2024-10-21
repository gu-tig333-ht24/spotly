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
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface), // Dynamic colour
      decoration: InputDecoration(
        hintText: "Search for Places...",
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)), 
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        suffixIcon: _searchTextController.text.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear, color: Theme.of(context).colorScheme.onSurface),
                onPressed: () {
                  _searchTextController.clear();
                  _placeSearchController.searchPlaces(_searchTextController.text);
                },
              )
            : null,
      ),
    );
  }
}

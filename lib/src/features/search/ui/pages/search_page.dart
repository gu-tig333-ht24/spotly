import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/place_collection.dart';
import '../../../main/ui/custom_app_bar.dart';
import '../../../main/ui/custom_navigation_bar.dart';
import '../../../places/place_collections/providers/place_collection_list_provider.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<PlaceCollection> _filteredPlaces = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterPlaces);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterPlaces() {
    final query = _searchController.text.toLowerCase();
    final allPlaces = ref.read(placeCollectionListProvider).whenOrNull(data: (places) => places) ?? [];
    setState(() {
      if (query.isNotEmpty) {
        _filteredPlaces = allPlaces
            .where((place) => place.title.toLowerCase().startsWith(query)) 
            .toList();
      } else {
        _filteredPlaces = []; 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final placesList = ref.watch(placeCollectionListProvider);

    return placesList.when(
      data: (allPlaces) {
        return Scaffold(
          appBar: const CustomAppBar(),
          bottomNavigationBar: const CustomNavigationBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search places...',
                    hintStyle: const TextStyle(color: Colors.white60),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _filteredPlaces.isEmpty
                    ? const Center(
                        child: Text(
                          'No places found.',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredPlaces.length,
                        itemBuilder: (context, index) {
                          final place = _filteredPlaces[index];
                          return ListTile(
                            title: Text(
                              place.title,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => const Center(child: Text('Error loading places')),
    );
  }
}

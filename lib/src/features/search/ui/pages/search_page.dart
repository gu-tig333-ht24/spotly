import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart'; 
import '../../../../core/models/place.dart';  
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_navigation_bar.dart';
import '../../../place/places/providers/place_list_provider.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Place> _filteredPlaces = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterPlaces);

    // Delay the provider update to avoid modifying it during the widget build process
    Future.microtask(() {
      _retrievePlaces(); // Retrieve places after the widget tree has built
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Retrieve places using the provider (with collectionId)
  void _retrievePlaces() {
    ref.read(placeListProvider.notifier).retrievePlaces(1); // Use the correct collectionId
  }

  
  void _filterPlaces() {
    final query = _searchController.text.toLowerCase(); 
    final allPlaces = ref.read(placeListProvider).whenOrNull(data: (places) => places) ?? []; 

    
    setState(() {
      if (query.isNotEmpty) {
        _filteredPlaces = allPlaces.where((place) {
          return place.title.toLowerCase().startsWith(query); 
        }).toList();
      } else {
        _filteredPlaces = allPlaces; 
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final placesList = ref.watch(placeListProvider);

    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: const CustomNavigationBar(),
      body: Column(
        children: [
          _buildSearchField(),
          Expanded(
            child: placesList.when(
              data: (allPlaces) => _buildPlacesList(),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => const Center(child: Text('Error loading places')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: const TextStyle(color: Colors.white60),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white),
                  onPressed: _clearSearch,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildPlacesList() {
    return _filteredPlaces.isEmpty
        ? const Center(
            child: Text(
              'No places found.',
              style: TextStyle(color: Colors.white),
            ),
          )
        : ListView.separated(
            itemCount: _filteredPlaces.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.white24,
              thickness: 1,
              height: 1,
            ),
            itemBuilder: (context, index) {
              final place = _filteredPlaces[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Icon(
                  Icons.place,
                  color: Colors.blue[300],
                  size: 30.0,
                ),
                title: Text(
                  place.title, 
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                subtitle: Text(
                  'Created on: ${DateFormat('yyyy-MM-dd').format(place.createdAt)}', 
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12.0,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white60,
                  size: 16.0,
                ),
                onTap: () {
                },
              );
            },
          );
  }
}

import 'package:flutter/material.dart';

import '../../../../main/ui/custom_app_bar.dart';
import '../../../../main/ui/custom_navigation_bar.dart';
import '../../../add_place_collection/ui/pages/add_place_collection_page.dart';
import '../widgets/place_collection_list.dart';

class PlaceCollectionListPage extends StatelessWidget {
  const PlaceCollectionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          Tooltip(
            message: "Add Collection",
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddPlaceCollectionPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white70,
              ),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(),
      body: const PlaceCollectionList(),
    );
  }
}

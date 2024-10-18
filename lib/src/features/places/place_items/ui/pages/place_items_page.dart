import 'package:flutter/material.dart';

import '../../../../../core/models/place_collection.dart';
import '../../../../main/ui/custom_app_bar.dart';
import '../../../add_place_item/ui/pages/add_place_page.dart';
import '../widgets/place_items_list.dart';

class PlaceItemsPage extends StatelessWidget {
  const PlaceItemsPage({
    super.key,
    required this.collection,
  });

  final PlaceCollection collection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: collection.title,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddPlacePage(
              collectionId: collection.id,
            ),
          ),
        ),
        backgroundColor: Colors.deepPurple,
        label: const Text(
          "Add Place",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: PlaceList(collectionId: collection.id),
    );
  }
}

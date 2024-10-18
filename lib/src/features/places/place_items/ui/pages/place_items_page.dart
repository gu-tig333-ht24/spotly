import 'package:flutter/material.dart';

import '../../../../../core/models/add_places.dart';
import '../../../../../core/models/place_collection.dart';
import '../../../../main/ui/custom_app_bar.dart';
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
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddPlaceScreen(),
                ),
              );
            },
            child: const Text(
              "Add",
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
      body: PlaceItemsList(),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../core/models/add_places.dart';
import '../../../../main/ui/custom_app_bar.dart';
import '../widgets/place_items_list.dart';

class PlaceItemsPage extends StatelessWidget {
  const PlaceItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: "Place Collection Title",
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

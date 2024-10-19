import 'package:flutter/material.dart';

import '../../../../../core/models/collection.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../add_place/ui/pages/add_place_page.dart';
import '../widgets/place_list_view.dart';

class PlaceListPage extends StatelessWidget {
  const PlaceListPage({
    super.key,
    required this.collection,
  });

  final Collection collection;

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
      body: PlaceListView(collectionId: collection.id),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../core/models/collection.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import '../../../add_place/ui/pages/add_place_page.dart';
import '../widgets/place_list_view.dart';

class PlaceListPage extends StatelessWidget {
  const PlaceListPage({
    super.key,
    required this.collection,
  });

  final Collection collection;

  void _navigateToAddPlacePage(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AddPlacePage(
            collectionId: collection.id,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: collection.title,
        actions: [
          CustomIconButton(
            onPressed: () => _navigateToAddPlacePage(context),
            icon: Icons.add_rounded,
          ),
        ],
      ),
      body: PlaceListView(collectionId: collection.id),
    );
  }
}

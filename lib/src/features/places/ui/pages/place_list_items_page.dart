import 'package:flutter/material.dart';
import 'package:spotly/src/features/places/providers/places.dart';
import '../../../main/ui/custom_app_bar.dart';
import 'package:spotly/src/core/widgets/places_list.dart';

class PlaceListItemsPage extends StatelessWidget {
  const PlaceListItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        appBarTitle: "Place List Title",
      ),
      body: Center(
        child: Text("Place List Items Content"),
      ),
    );
  }
}

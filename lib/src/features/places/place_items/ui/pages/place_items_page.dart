import 'package:flutter/material.dart';
import '../../../../main/ui/custom_app_bar.dart';

class PlaceItemsPage extends StatelessWidget {
  const PlaceItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        appBarTitle: "Place Collection Title",
      ),
      body: Center(
        child: Text("Place Items"),
      ),
    );
  }
}

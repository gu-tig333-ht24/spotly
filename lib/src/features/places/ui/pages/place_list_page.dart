import 'package:flutter/material.dart';
import 'package:spotly/src/features/places/providers/places.dart';
import '../../../main/ui/custom_app_bar.dart';
import '../../../main/ui/custom_navigation_bar.dart';
import 'package:spotly/src/core/widgets/places_list.dart';

class PlaceListPage extends StatelessWidget {
  const PlaceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomNavigationBar(),
      body: Center(
        child: Text(
          "Places Content",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

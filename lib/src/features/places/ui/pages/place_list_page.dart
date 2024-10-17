import 'package:flutter/material.dart';

import '../../../main/ui/custom_app_bar.dart';
import '../../../main/ui/custom_navigation_bar.dart';
import '../../add_place_list/ui/pages/add_place_list_page.dart';

class PlaceListPage extends StatelessWidget {
  const PlaceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddPlaceListPage(),
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
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(),
      body: const Center(
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

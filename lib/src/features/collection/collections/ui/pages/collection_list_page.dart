import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_navigation_bar.dart';
import '../../../add_collection/ui/pages/add_collection_page.dart';
import '../widgets/collection_list_view.dart';

class CollectionListPage extends StatelessWidget {
  const CollectionListPage({super.key});

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
                  builder: (context) => const AddCollectionPage(),
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
      body: const CollectionListView(),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../core/widgets/custom_navigation_bar.dart';
import '../../../add_collection/ui/pages/add_collection_page.dart';
import '../widgets/collection_list_view.dart';

class CollectionListPage extends StatelessWidget {
  const CollectionListPage({super.key});

  void _navigateToAddCollectionPage(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddCollectionPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: "Collections",
        actions: [
          CustomIconButton(
            onPressed: () => _navigateToAddCollectionPage(context),
            icon: Icons.add_rounded,
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(),
      body: const CollectionListView(),
    );
  }
}

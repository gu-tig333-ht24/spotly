import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_navigation_bar.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/search_list_view.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomNavigationBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(AppSizes.s20),
            child: CustomSearchBar(),
          ),
          Expanded(
            child: SearchListView(),
          ),
        ],
      ),
    );
  }
}

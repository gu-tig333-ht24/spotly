import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/custom_navigation_bar.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/search_list_view.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(AppSizes.s40),
          child: SafeArea(
            minimum: EdgeInsets.all(AppSizes.s20),
            child: CustomSearchBar(),
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
      body: const SearchListView(),
    );
  }
}

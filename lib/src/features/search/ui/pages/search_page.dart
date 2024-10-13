import 'package:flutter/material.dart';

import '../../../main/ui/custom_app_bar.dart';
import '../../../main/ui/custom_navigation_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomNavigationBar(),
      body: Center(
        child: Text(
          "Search Content",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

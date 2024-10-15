import 'package:flutter/material.dart';
import '../../places/providers/places.dart';
import '../../../core/widgets/places_list.dart';

import '../../../core/constants/app_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;

  const CustomAppBar({
    super.key,
    this.appBarTitle = AppConstants.appTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(appBarTitle),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

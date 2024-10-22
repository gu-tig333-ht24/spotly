import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../constants/app_sizes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    this.appBarTitle = AppConstants.appTitle,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(appBarTitle),
      actions: actions != null
          ? [
              ...actions!,
              const SizedBox(width: AppSizes.s16),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

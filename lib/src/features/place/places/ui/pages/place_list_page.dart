import 'dart:io';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/models/collection.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import '../../../add_place/ui/pages/add_place_page.dart';
import '../../providers/place_list_provider.dart';
import '../widgets/place_list_view.dart';

class PlaceListPage extends StatelessWidget {
  const PlaceListPage({
    super.key,
    required this.collection,
  });

  final Collection collection;

  void _navigateToAddPlacePage(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AddPlacePage(
            collectionId: collection.id,
          ),
        ),
      );

  Future<void> pickFile(BuildContext context, WidgetRef ref) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["json"],
    );

    if (result == null) {
      return;
    }

    final file = File(result.files.single.path!);
    ref.read(placeListProvider.notifier).importPlace(file, collection.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: collection.title,
        actions: [
          Tooltip(
            message: "Import a Place",
            preferBelow: true,
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, _) {
                return CustomIconButton(
                  onPressed: () => pickFile(context, ref),
                  icon: Icons.file_open_rounded,
                );
              },
            ),
          ),
          Tooltip(
            message: "Add a Place",
            preferBelow: true,
            child: CustomIconButton(
              onPressed: () => _navigateToAddPlacePage(context),
              icon: Icons.add_rounded,
            ),
          ),
        ],
      ),
      body: PlaceListView(collectionId: collection.id),
    );
  }
}

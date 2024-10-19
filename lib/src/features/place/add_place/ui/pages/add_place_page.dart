import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/dtos/place_dto.dart';
import '../../../../../core/models/place.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../places/providers/place_list_provider.dart';
import '../widgets/add_place_form.dart';

class AddPlacePage extends ConsumerWidget {
  const AddPlacePage({
    super.key,
    required this.collectionId,
  });

  final int collectionId;

  void _addPlace(
    BuildContext context,
    WidgetRef ref,
    PlaceDto dto,
  ) {
    final place = Place(
      id: -1,
      collectionId: collectionId,
      title: dto.title,
      description: dto.description,
      imagePath: dto.imagePath,
      createdAt: DateTime.now(),
    );
    ref.read(placeListProvider.notifier).addPlace(place);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: "Add Place",
      ),
      body: AddPlaceForm(
        onSubmit: (PlaceDto dto) => _addPlace(
          context,
          ref,
          dto,
        ),
      ),
    );
  }
}

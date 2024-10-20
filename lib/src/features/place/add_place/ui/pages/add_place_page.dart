import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/models/place.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import '../../../places/providers/place_list_provider.dart';
import '../../providers/add_place_form_provider.dart';
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
    AddPlaceFormState formState,
  ) {
    final place = Place(
      id: -1,
      collectionId: collectionId,
      title: formState.title,
      description: formState.description,
      imagePath: formState.imagePath,
      createdAt: DateTime.now(),
    );
    ref.read(placeListProvider.notifier).addPlace(place);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AddPlaceFormState formState = ref.watch(addPlaceFormProvider);

    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: "Add Place",
        actions: [
          Tooltip(
            message: "Save",
            preferBelow: true,
            child: CustomIconButton(
              onPressed: formState.isValid
                  ? () => _addPlace(context, ref, formState)
                  : null,
              icon: Icons.check_rounded,
            ),
          ),
        ],
      ),
      body: AddPlaceForm(
        onSubmit: () => _addPlace(context, ref, formState),
      ),
    );
  }
}

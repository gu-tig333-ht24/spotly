import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import '../../../places/providers/place_list_provider.dart';
import '../../providers/place_form_provider.dart';
import '../widgets/place_form.dart';

class AddPlacePage extends ConsumerWidget {
  const AddPlacePage({
    super.key,
    required this.collectionId,
  });

  final int collectionId;

  void _addPlace(
    BuildContext context,
    WidgetRef ref,
    PlaceFormState formState,
  ) {
    // TODO: uncomment if location should be mandatory.
    // if (formState.location == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text("Please select a location."),
    //     ),
    //   );
    //   return;
    // }

    ref
        .read(placeListProvider.notifier)
        .addPlaceFromFormState(formState, collectionId);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PlaceFormState formState = ref.watch(placeFormProvider);

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
      body: PlaceForm(
        onSubmit: () => _addPlace(context, ref, formState),
      ),
    );
  }
}

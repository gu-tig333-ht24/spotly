import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/models/place.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import '../../../places/providers/place_list_provider.dart';
import '../../providers/place_form_provider.dart';
import '../widgets/place_form.dart';

class EditPlacePage extends ConsumerWidget {
  const EditPlacePage({
    super.key,
    required this.place,
  });

  final Place place;

  void _editPlace(
    BuildContext context,
    WidgetRef ref,
    PlaceFormState formState,
  ) {
    ref
        .read(placeListProvider.notifier)
        .updatePlaceFromFormState(place, formState);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PlaceFormState formState = ref.watch(placeFormProvider);

    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: "Edit Place",
        actions: [
          Tooltip(
            message: "Save",
            preferBelow: true,
            child: CustomIconButton(
              onPressed: formState.isValid
                  ? () => _editPlace(context, ref, formState)
                  : null,
              icon: Icons.check_rounded,
            ),
          ),
        ],
      ),
      body: PlaceForm(
        place: place,
        onSubmit: () => _editPlace(context, ref, formState),
      ),
    );
  }
}

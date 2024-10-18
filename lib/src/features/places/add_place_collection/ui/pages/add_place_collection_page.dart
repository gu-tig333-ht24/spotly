import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../main/ui/custom_app_bar.dart';
import '../../../place_collections/providers/place_collection_list_provider.dart';
import '../../providers/add_place_collection_form_provider.dart';
import '../widgets/add_place_collection_form.dart';

class AddPlaceCollectionPage extends ConsumerWidget {
  const AddPlaceCollectionPage({super.key});

  void _addPlaceCollection(
      BuildContext context, WidgetRef ref, String title, String description) {
    ref
        .read(placeCollectionListProvider.notifier)
        .addPlaceCollection(title, description);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AddPlaceCollectionFormState formState =
        ref.watch(addPlaceCollectionFormProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: "Add Collection",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.s20),
        child: AddPlaceCollectionForm(
          onSubmit: () => _addPlaceCollection(
              context, ref, formState.title, formState.description),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../main/ui/custom_app_bar.dart';
import '../../providers/add_place_collection_form_controller.dart';
import '../widgets/add_place_collection_form.dart';

class AddPlaceCollectionPage extends StatelessWidget {
  const AddPlaceCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: "Add Place Collection",
        actions: [
          Consumer(
            builder: (_, WidgetRef ref, __) {
              final AddPlaceCollectionFormState formState =
                  ref.watch(addPlaceCollectionFormProvider);

              return TextButton(
                onPressed: formState.isValid
                    ? () {
                        Navigator.of(context).pop();
                      }
                    : null,
                child: const Text(
                  "Add",
                  style: TextStyle(fontSize: 20),
                ),
              );
            },
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.s20),
        child: AddPlaceCollectionForm(),
      ),
    );
  }
}

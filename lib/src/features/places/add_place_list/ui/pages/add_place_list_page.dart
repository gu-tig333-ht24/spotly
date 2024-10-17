import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../main/ui/custom_app_bar.dart';
import '../../providers/add_place_list_form_controller.dart';
import '../widgets/add_place_list_form.dart';

class AddPlaceListPage extends StatelessWidget {
  const AddPlaceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: "Add Place List",
        actions: [
          Consumer(
            builder: (_, WidgetRef ref, __) {
              final AddPlaceListFormState formState =
                  ref.watch(addPlaceListFormProvider);

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
        child: AddPlaceListForm(),
      ),
    );
  }
}

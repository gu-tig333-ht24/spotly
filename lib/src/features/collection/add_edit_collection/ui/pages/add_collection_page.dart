import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../collections/providers/collection_list_provider.dart';
import '../../providers/collection_form_provider.dart';
import '../widgets/collection_form.dart';

class AddCollectionPage extends ConsumerWidget {
  const AddCollectionPage({super.key});

  void _addCollection(
    BuildContext context,
    WidgetRef ref,
    String title,
    String? description,
  ) {
    ref.read(collectionListProvider.notifier).addCollection(title, description);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CollectionFormState formState = ref.watch(collectionFormProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: "Add Collection",
      ),
      body: CollectionForm(
        onSubmit: () => _addCollection(
          context,
          ref,
          formState.title,
          formState.description,
        ),
      ),
    );
  }
}

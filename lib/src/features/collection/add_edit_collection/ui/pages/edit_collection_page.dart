import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/models/collection.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../collections/providers/collection_list_provider.dart';
import '../../providers/collection_form_provider.dart';
import '../widgets/collection_form.dart';

class EditCollectionPage extends ConsumerWidget {
  const EditCollectionPage({
    super.key,
    required this.collection,
  });

  final Collection collection;

  void _editCollection(
    BuildContext context,
    WidgetRef ref,
    String title,
    String? description,
  ) {
    ref.read(collectionListProvider.notifier).updateCollection(
          collection.copyWith(title: title, description: description),
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CollectionFormState formState = ref.watch(collectionFormProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: "Edit Collection",
      ),
      body: CollectionForm(
        collection: collection,
        onSubmit: () => _editCollection(
          context,
          ref,
          formState.title,
          formState.description,
        ),
      ),
    );
  }
}

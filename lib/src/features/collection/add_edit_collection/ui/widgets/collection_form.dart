import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/models/collection.dart';
import '../../../../../core/widgets/custom_filled_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../providers/collection_form_provider.dart';

class CollectionForm extends ConsumerStatefulWidget {
  const CollectionForm({
    super.key,
    required this.onSubmit,
    this.collection,
  });

  final VoidCallback? onSubmit;
  final Collection? collection;

  @override
  ConsumerState<CollectionForm> createState() => _CollectionFormState();
}

class _CollectionFormState extends ConsumerState<CollectionForm> {
  late final CollectionFormController _formController;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  late final FocusNode _titleNode;
  late final FocusNode _descriptionNode;

  @override
  void initState() {
    super.initState();

    _formController = ref.read(collectionFormProvider.notifier);

    _titleController = TextEditingController();
    _descriptionController = TextEditingController();

    _titleNode = FocusNode();
    _descriptionNode = FocusNode();

    if (widget.collection != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _titleController.text = widget.collection!.title;
        _formController.changeTitle(_titleController.text);

        _descriptionController.text = widget.collection!.description ?? "";
        _formController.changeDescription(_descriptionController.text);
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    _titleNode.dispose();
    _descriptionNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CollectionFormState formState = ref.watch(collectionFormProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.s20),
      child: Form(
        child: Column(
          children: [
            const SizedBox(height: AppSizes.s10),
            CustomTextFormField(
              controller: _titleController,
              labelText: "Title",
              onChanged: _formController.changeTitle,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionNode);
              },
              focusNode: _titleNode,
              textInputAction: TextInputAction.next,
              isRequired: true,
            ),
            const SizedBox(height: AppSizes.s20),
            CustomTextFormField(
              controller: _descriptionController,
              labelText: "Description",
              onChanged: _formController.changeDescription,
              onFieldSubmitted: (_) {
                if (formState.isValid) {
                  widget.onSubmit?.call();
                }
              },
              focusNode: _descriptionNode,
              textInputAction: TextInputAction.done,
              hasClearButton: false,
              maxLines: 3,
            ),
            const SizedBox(height: AppSizes.s20),
            Row(
              children: [
                Expanded(
                  child: CustomFilledButton(
                    onPressed: formState.isValid
                        ? () => widget.onSubmit?.call()
                        : null,
                    text: "Save",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/widgets/custom_filled_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../providers/add_collection_form_provider.dart';

class AddCollectionForm extends ConsumerStatefulWidget {
  const AddCollectionForm({
    super.key,
    required this.onSubmit,
  });

  final VoidCallback? onSubmit;

  @override
  ConsumerState<AddCollectionForm> createState() => _AddCollectionFormState();
}

class _AddCollectionFormState extends ConsumerState<AddCollectionForm> {
  late final AddCollectionFormController _formController;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  late final FocusNode _titleNode;
  late final FocusNode _descriptionNode;

  @override
  void initState() {
    super.initState();

    _formController = ref.read(addCollectionFormProvider.notifier);

    _titleController = TextEditingController();
    _descriptionController = TextEditingController();

    _titleNode = FocusNode();
    _descriptionNode = FocusNode();
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
    final AddCollectionFormState formState =
        ref.watch(addCollectionFormProvider);

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

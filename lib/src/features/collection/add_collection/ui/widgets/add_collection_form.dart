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

  @override
  void initState() {
    super.initState();
    _formController = ref.read(addCollectionFormProvider.notifier);
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AddCollectionFormState formState =
        ref.watch(addCollectionFormProvider);

    return Form(
      child: Column(
        children: [
          const SizedBox(height: AppSizes.s10),
          CustomTextFormField(
            controller: _titleController,
            labelText: "Title",
            isRequired: true,
            onChanged: _formController.changeTitle,
          ),
          const SizedBox(height: AppSizes.s20),
          CustomTextFormField(
            controller: _descriptionController,
            labelText: "Description",
            hasClearButton: false,
            maxLines: 3,
            onChanged: _formController.changeDescription,
            onSubmit: () => formState.isValid ? widget.onSubmit?.call() : null,
          ),
          const SizedBox(height: AppSizes.s20),
          Row(
            children: [
              Expanded(
                child: CustomFilledButton(
                  onPressed:
                      formState.isValid ? () => widget.onSubmit?.call() : null,
                  text: "Save",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

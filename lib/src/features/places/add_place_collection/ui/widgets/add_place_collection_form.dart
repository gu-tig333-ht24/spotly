import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../providers/add_place_collection_form_provider.dart';

class AddPlaceCollectionForm extends ConsumerStatefulWidget {
  const AddPlaceCollectionForm({
    super.key,
    required this.onSubmit,
  });

  final VoidCallback? onSubmit;

  @override
  ConsumerState<AddPlaceCollectionForm> createState() =>
      _AddPlaceCollectionFormState();
}

class _AddPlaceCollectionFormState
    extends ConsumerState<AddPlaceCollectionForm> {
  late final AddPlaceCollectionFormController _formController;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _formController = ref.read(addPlaceCollectionFormProvider.notifier);
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
    final AddPlaceCollectionFormState formState =
        ref.watch(addPlaceCollectionFormProvider);

    return Form(
      child: Column(
        children: [
          const SizedBox(height: AppSizes.s10),
          TextFormField(
            onChanged: _formController.changeTitle,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            onFieldSubmitted:
                formState.isValid ? (_) => widget.onSubmit?.call() : null,
            controller: _titleController,
            cursorColor: Colors.deepPurpleAccent,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.none,
            textInputAction: TextInputAction.done,
            maxLines: 1,
            // Customize the input text style
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: "Title*",
              labelStyle: const TextStyle(
                color: Colors.white70,
                fontSize: 24,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  _titleController.clear();
                },
                icon: const Icon(
                  Icons.clear,
                  color: Colors.redAccent,
                ),
                tooltip: "Clear",
              ),
              // The style for the border by default and enabled
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.deepPurple,
                ),
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
              // // The style for the border when focused
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.deepPurpleAccent,
                ),
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.s20),
          // Add new TextFormField for description
          TextFormField(
            onChanged: _formController.changeDescription,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            onFieldSubmitted:
                formState.isValid ? (_) => widget.onSubmit?.call() : null,
            controller: _descriptionController,
            cursorColor: Colors.deepPurpleAccent,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.done,
            maxLines: 3,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: "Description",
              labelStyle: const TextStyle(
                color: Colors.white70,
                fontSize: 24,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.deepPurple,
                ),
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.deepPurpleAccent,
                ),
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.s20),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed:
                      formState.isValid ? () => widget.onSubmit?.call() : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.borderRadius),
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

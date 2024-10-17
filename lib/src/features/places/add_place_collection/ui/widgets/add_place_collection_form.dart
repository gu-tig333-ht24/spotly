import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/app_constants.dart';
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
  late final TextEditingController _descriptionController;  // Add description controller

  @override
  void initState() {
    super.initState();
    _formController = ref.read(addPlaceCollectionFormProvider.notifier);
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();  // Initialize description controller
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();  // Dispose description controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AddPlaceCollectionFormState formState =
        ref.watch(addPlaceCollectionFormProvider);

    return Column(
      children: [
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
            hintText: "Title",
            // Customize the placeholder text style
            hintStyle: const TextStyle(
              color: Colors.white54,
              // fontSize: 16.0,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                _titleController.clear();
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.deepPurpleAccent,
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
            // The style for the border when focused
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.deepPurpleAccent,
              ),
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
          ),
        ),
        const SizedBox(height: 16),
        // Add new TextFormField for description
        TextFormField(
          onChanged: _formController.changeDescription,  // Handle description changes
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
            hintText: "Description",
            hintStyle: const TextStyle(
              color: Colors.white54,
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
      ],
    );
  }
}

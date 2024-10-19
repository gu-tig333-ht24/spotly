import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/models/place_location.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../core/widgets/location_input.dart';
import '../../providers/add_place_form_provider.dart';
import 'custom_image_picker.dart';

class AddPlaceForm extends ConsumerStatefulWidget {
  const AddPlaceForm({
    super.key,
    required this.onSubmit,
  });

  final VoidCallback onSubmit;

  @override
  ConsumerState<AddPlaceForm> createState() => _AddPlaceFormState();
}

class _AddPlaceFormState extends ConsumerState<AddPlaceForm> {
  late final AddPlaceFormController _formController;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  File? _selectedImageFile;
  PlaceLocation? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _formController = ref.read(addPlaceFormProvider.notifier);
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _selectPlaceLocation(PlaceLocation location) {
    _selectedLocation = location;
  }

  Future<void> _submit(BuildContext context) async {
    if (_selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a location.'),
        ),
      );
      return;
    }

    if (_selectedImageFile != null) {
      final filePath = _selectedImageFile!.path;
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = path.basename(filePath);
      await File(filePath).copy("${appDir.path}/$fileName");
    }

    widget.onSubmit();
  }

  @override
  Widget build(BuildContext context) {
    final AddPlaceFormState formState = ref.watch(addPlaceFormProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.s20),
      child: Form(
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
              onSubmit: formState.isValid ? () => _submit(context) : null,
            ),
            const SizedBox(height: AppSizes.s20),
            CustomImagePicker(onImageSelected: (File file) {
              _selectedImageFile = file;
              _formController.changeImagePath(file.path);
            }),
            LocationInput(onSelectLocation: _selectPlaceLocation),
          ],
        ),
      ),
    );
  }
}

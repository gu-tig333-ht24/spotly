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

  late final FocusNode _titleNode;
  late final FocusNode _descriptionNode;

  File? _selectedImageFile;
  PlaceLocation? _selectedLocation;

  @override
  void initState() {
    super.initState();

    _formController = ref.read(addPlaceFormProvider.notifier);

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

  void _selectPlaceLocation(PlaceLocation location) {
    _selectedLocation = location;
  }

  Future<void> _submit(BuildContext context) async {
    // TODO: handle this later in AddPlacePage

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
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              focusNode: _descriptionNode,
              textInputAction: TextInputAction.done,
              hasClearButton: false,
              maxLines: 3,
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

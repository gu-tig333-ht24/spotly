import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/dtos/place_dto.dart';
import '../../../../../core/models/place_location.dart';
import '../../../../../core/widgets/custom_filled_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../core/widgets/location_input.dart';
import '../../providers/add_place_form_provider.dart';
import 'image_display.dart';

class AddPlaceForm extends ConsumerStatefulWidget {
  const AddPlaceForm({
    super.key,
    required this.onSubmit,
  });

  final Function(PlaceDto place) onSubmit;

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

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) return;

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(pickedImage.path);
    final savedImage =
        await File(pickedImage.path).copy('${appDir.path}/$fileName');

    _selectedImageFile = savedImage; // Spara filen
  }

  void _submit(BuildContext context) {
    if (_selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a location.'),
        ),
      );
      return;
    }

    widget.onSubmit(
      PlaceDto(
        title: _titleController.text,
        description: _descriptionController.text,
        imagePath: _selectedImageFile?.path,
        location: _selectedLocation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AddPlaceFormState formState = ref.watch(addPlaceFormProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.s20),
      child: Form(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text("Pick an Image"),
            ),
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
            const SizedBox(height: AppSizes.s10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ),
              ),
              height: 250,
              width: double.infinity,
              alignment: Alignment.center,
              child: ImageDisplay(
                onImageSelected: (File file) {
                  _selectedImageFile = file;
                },
              ),
            ),
            const SizedBox(height: AppSizes.s10),
            LocationInput(onSelectLocation: _selectPlaceLocation),
            const SizedBox(height: AppSizes.s20),
            Row(
              children: [
                Expanded(
                  child: CustomFilledButton(
                    onPressed:
                        formState.isValid ? () => _submit(context) : null,
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

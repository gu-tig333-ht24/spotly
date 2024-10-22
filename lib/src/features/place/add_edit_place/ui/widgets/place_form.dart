import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/models/location.dart';
import '../../../../../core/models/place.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../core/widgets/location_input.dart';
import '../../providers/place_form_provider.dart';
import 'custom_image_picker.dart';

class PlaceForm extends ConsumerStatefulWidget {
  const PlaceForm({
    super.key,
    required this.onSubmit,
    this.place,
  });

  final VoidCallback onSubmit;
  final Place? place;

  @override
  ConsumerState<PlaceForm> createState() => _PlaceFormState();
}

class _PlaceFormState extends ConsumerState<PlaceForm> {
  late final PlaceFormController _formController;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  late final FocusNode _titleNode;
  late final FocusNode _descriptionNode;

  Location? _selectedLocation;

  @override
  void initState() {
    super.initState();

    _formController = ref.read(placeFormProvider.notifier);

    _titleController = TextEditingController();
    _descriptionController = TextEditingController();

    _titleNode = FocusNode();
    _descriptionNode = FocusNode();

    if (widget.place == null) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeForm(widget.place!);
    });
  }

  void _initializeForm(Place place) {
    _titleController.text = place.title;
    _formController.changeTitle(_titleController.text);

    _descriptionController.text = place.description ?? "";
    _formController.changeDescription(_descriptionController.text);

    if (place.location != null) {
      _selectPlaceLocation(place.location!);
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

  void _selectPlaceLocation(Location location) {
    setState(() => _selectedLocation = location);
    _formController.changeLocation(_selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    final PlaceFormState formState = ref.watch(placeFormProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.s20),
      child: SafeArea(
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
                maxLines: 2,
              ),
              const SizedBox(height: AppSizes.s20),
              CustomImagePicker(
                  initialSelection: widget.place?.imagePath != null
                      ? File(widget.place!.imagePath!)
                      : null,
                  onImageSelected: (File file) {
                    _formController.changeImagePath(file.path);
                    _formController.changeSelectedImageFile(file);
                  }),
              const SizedBox(height: AppSizes.s10),
              LocationInput(
                initialSelection: _selectedLocation ?? widget.place?.location,
                onLocationSelected: _selectPlaceLocation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

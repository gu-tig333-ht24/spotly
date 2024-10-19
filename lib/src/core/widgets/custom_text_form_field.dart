import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.onChanged,
    this.onSubmit,
    this.isRequired = false,
    this.hasClearButton = false,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String labelText;
  final Function(String) onChanged;
  final VoidCallback? onSubmit;
  final bool isRequired;
  final bool hasClearButton;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (_) => onChanged(controller.text),
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      onFieldSubmitted: (_) => onSubmit,
      controller: controller,
      cursorColor: Colors.deepPurpleAccent,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.done,
      maxLines: maxLines,
      // Customize the input text style
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: isRequired ? "$labelText*" : labelText,
        labelStyle: const TextStyle(
          color: Colors.white70,
          fontSize: 24,
        ),
        suffixIcon: hasClearButton
            ? IconButton(
                onPressed: () {
                  controller.clear();
                },
                icon: const Icon(
                  Icons.clear,
                  color: Colors.redAccent,
                ),
                tooltip: "Clear",
              )
            : null,
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
    );
  }
}

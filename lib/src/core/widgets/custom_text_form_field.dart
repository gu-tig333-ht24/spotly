import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputAction,
    this.isRequired = false,
    this.hasClearButton = false,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String labelText;
  final Function(String) onChanged;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool isRequired;
  final bool hasClearButton;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      onChanged: (_) => onChanged(controller.text),
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      onFieldSubmitted: onFieldSubmitted,
      cursorColor: theme.colorScheme.primary,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: textInputAction,
      maxLines: maxLines,
      // Customize the input text style
      style: TextStyle(color: theme.colorScheme.onSurface),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: isRequired ? "$labelText*" : labelText,
        labelStyle: TextStyle(
          color: theme.colorScheme.onSurface.withOpacity(0.7),
          fontSize: 24,
        ),
        suffixIcon: hasClearButton
            ? IconButton(
                onPressed: () {
                  controller.clear();
                },
                icon: Icon(
                  Icons.clear,
                  color: theme.colorScheme.error,
                ),
                tooltip: "Clear",
              )
            : null,
        // The style for the border by default and enabled
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
          ),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        // The style for the border when focused
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.colorScheme.primary.withOpacity(0.7),
          ),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
      ),
    );
  }
}

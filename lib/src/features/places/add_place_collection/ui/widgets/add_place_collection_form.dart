// import 'package:flutter/material.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../../../core/constants/app_constants.dart';
// import '../../providers/add_place_collection_form_provider.dart';

// class AddPlaceCollectionForm extends ConsumerStatefulWidget {
//   const AddPlaceCollectionForm({
//     super.key,
//     this.onSubmit,
//   });

//   final VoidCallback? onSubmit;

//   @override
//   ConsumerState<AddPlaceCollectionForm> createState() =>
//       _AddPlaceCollectionFormState();
// }

// class _AddPlaceCollectionFormState
//     extends ConsumerState<AddPlaceCollectionForm> {
//   late final AddPlaceCollectionFormController _formController;
//   late final TextEditingController _titleController;

//   @override
//   void initState() {
//     super.initState();
//     _formController = ref.read(addPlaceCollectionFormProvider.notifier);
//     _titleController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final AddPlaceCollectionFormState formState =
//         ref.watch(addPlaceCollectionFormProvider);

//     return Column(
//       children: [
//         TextFormField(
//           onChanged: _formController.changeTitle,
//           onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
//           onFieldSubmitted:
//               formState.isValid ? (_) => widget.onSubmit?.call() : null,
//           controller: _titleController,
//           cursorColor: Colors.deepPurpleAccent,
//           keyboardType: TextInputType.text,
//           textCapitalization: TextCapitalization.none,
//           textInputAction: TextInputAction.done,
//           maxLines: 1,
//           // Customize the input text style
//           style: const TextStyle(color: Colors.white),
//           decoration: InputDecoration(
//             hintText: "Title",
//             // Customize the placeholder text style
//             hintStyle: const TextStyle(
//               color: Colors.white54,
//               // fontSize: 16.0,
//             ),
//             suffixIcon: IconButton(
//               onPressed: () {
//                 _titleController.clear();
//               },
//               icon: const Icon(
//                 Icons.clear,
//                 color: Colors.deepPurpleAccent,
//               ),
//               tooltip: "Clear",
//             ),
//             // The style for the border by default and enabled
//             enabledBorder: OutlineInputBorder(
//               borderSide: const BorderSide(
//                 color: Colors.deepPurple,
//               ),
//               borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//             ),
//             // The style for the border when focused
//             focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(
//                 color: Colors.deepPurpleAccent,
//               ),
//               borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
// import 'package:flutter/foundation.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final addPlaceCollectionFormProvider = StateNotifierProvider.autoDispose<
//     AddPlaceCollectionFormController, AddPlaceCollectionFormState>((ref) {
//   return AddPlaceCollectionFormController();
// });

// class AddPlaceCollectionFormController extends StateNotifier<AddPlaceCollectionFormState> {
//   AddPlaceCollectionFormController() : super(AddPlaceCollectionFormState.initial());

//   void changeTitle(String newTitle) {
//     state = state.copyWith(title: newTitle);
//   }
// }

// @immutable
// class AddPlaceCollectionFormState {
//   const AddPlaceCollectionFormState({
//     required this.title,
//   });

//   factory AddPlaceCollectionFormState.initial() =>
//       const AddPlaceCollectionFormState(title: "");

//   final String title;

//   bool get isValid => title.isNotEmpty;

//   AddPlaceCollectionFormState copyWith({
//     String? title,
//   }) {
//     return AddPlaceCollectionFormState(
//       title: title ?? this.title,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../providers/add_place_collection_form_provider.dart';

class AddPlaceCollectionForm extends ConsumerStatefulWidget {
  const AddPlaceCollectionForm({
    super.key,
    this.onSubmit,
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

  @override
  void initState() {
    super.initState();
    _formController = ref.read(addPlaceCollectionFormProvider.notifier);
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
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
          style: const TextStyle(color: Colors.white), // Vit text
          decoration: InputDecoration(
            hintText: "Title",
            hintStyle:
                const TextStyle(color: Colors.white54), // Vit placeholder
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
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.deepPurpleAccent),
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
          ),
        ),
      ],
    );
  }
}

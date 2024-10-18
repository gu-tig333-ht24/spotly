// import 'package:flutter/material.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../../../core/constants/app_sizes.dart';
// import '../../../../main/ui/custom_app_bar.dart';
// import '../../../place_collections/providers/place_collection_list_provider.dart';
// import '../../providers/add_place_collection_form_provider.dart';
// import '../widgets/add_place_collection_form.dart';

// class AddPlaceCollectionPage extends ConsumerWidget {
//   const AddPlaceCollectionPage({super.key});

//   void _addPlaceCollection(BuildContext context, WidgetRef ref, String title) {
//     ref
//         .read(placeCollectionListProvider.notifier)
//         .addPlaceCollection(title);
//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final AddPlaceCollectionFormState formState =
//         ref.watch(addPlaceCollectionFormProvider);

//     return Scaffold(
//       appBar: CustomAppBar(
//         appBarTitle: "Add Collection",
//         actions: [
//           TextButton(
//             onPressed: formState.isValid
//                 ? () => _addPlaceCollection(context, ref, formState.title)
//                 : null,
//             child: const Text(
//               "Add",
//               style: TextStyle(fontSize: 20),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: AppSizes.s20),
//         child: AddPlaceCollectionForm(
//           onSubmit: () => _addPlaceCollection(context, ref, formState.title),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../../../core/constants/app_sizes.dart';
// import '../../../../main/ui/custom_app_bar.dart';
// import '../../../place_collections/providers/place_collection_list_provider.dart';
// import '../../providers/add_place_collection_form_provider.dart';
// import '../widgets/add_place_collection_form.dart';

// class AddPlaceCollectionPage extends ConsumerWidget {
//   const AddPlaceCollectionPage({super.key});

//   void _addPlaceCollection(BuildContext context, WidgetRef ref, String title) {
//     ref.read(placeCollectionListProvider.notifier).addPlaceCollection(title);
//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final AddPlaceCollectionFormState formState =
//         ref.watch(addPlaceCollectionFormProvider);

//     return Scaffold(
//       appBar: CustomAppBar(
//         appBarTitle: "Add Collection",
//         actions: [
//           TextButton(
//             onPressed: formState.isValid
//                 ? () => _addPlaceCollection(context, ref, formState.title)
//                 : null,
//             child: const Text(
//               "Add",
//               style: TextStyle(fontSize: 20),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: AppSizes.s20),
//         child: AddPlaceCollectionForm(
//           onSubmit: () => _addPlaceCollection(context, ref, formState.title),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../main/ui/custom_app_bar.dart';
import '../../../place_collections/providers/place_collection_list_provider.dart';
import '../../providers/add_place_collection_form_provider.dart';
import '../widgets/add_place_collection_form.dart';
import 'package:path_provider/path_provider.dart'; // För att hantera lokal lagring
import 'package:path/path.dart' as path; // För att hantera filvägar

class AddPlaceCollectionPage extends ConsumerWidget {
  const AddPlaceCollectionPage({super.key});

  void _addPlaceCollection(
      BuildContext context, WidgetRef ref, String title, String description) {
    ref
        .read(placeCollectionListProvider.notifier)
        .addPlaceCollection(title, description);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AddPlaceCollectionFormState formState =
        ref.watch(addPlaceCollectionFormProvider);

    File? selectedImageFile; // Fil för att lagra den valda bilden

    // Funktion för att välja bild
    Future<void> pickImage() async {
      final imagePicker = ImagePicker();
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedImage == null) return;

      final appDir = await getApplicationDocumentsDirectory();
      final fileName = path.basename(pickedImage.path);
      final savedImage =
          await File(pickedImage.path).copy('${appDir.path}/$fileName');

      selectedImageFile = savedImage; // Spara filen
    }

    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: "Add Collection",
        actions: [
          TextButton(
            onPressed: formState.isValid
                ? () => _addPlaceCollection(
                    context, ref, formState.title, formState.description)
                : null,
            child: const Text(
              "Add",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.s20),
        child: AddPlaceCollectionForm(
          onSubmit: () => _addPlaceCollection(
              context, ref, formState.title, formState.description),
        ),
      ),
    );
  }
}

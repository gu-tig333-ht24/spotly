// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../../core/constants/app_sizes.dart';
// import '../../../../main/ui/custom_app_bar.dart';
// import '../../../place_collections/providers/collection_list_provider.dart';
// import '../../providers/add_collection_form_provider.dart';
// import '../widgets/add_collection_form.dart';
// import 'package:path_provider/path_provider.dart'; // För att hantera lokal lagring
// import 'package:path/path.dart' as path; // För att hantera filvägar
// import 'dart:io'; // För att använda File
// import 'package:image_picker/image_picker.dart'; // För att använda ImagePicker och ImageSource
// import '../../../../../core/widgets/location_input.dart';

// class AddPlaceCollectionPage extends ConsumerWidget {
//   const AddPlaceCollectionPage({super.key});

//   void _addPlaceCollection(BuildContext context, WidgetRef ref, String title,
//       String description, String imagePath) {
//     ref.read(placeCollectionListProvider.notifier).addPlaceCollection(
//         title, description, imagePath); // Lägg till imagePath här
//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final AddPlaceCollectionFormState formState =
//         ref.watch(addPlaceCollectionFormProvider);

//     File? selectedImageFile; // Fil för att lagra den valda bilden

//     // Funktion för att välja bild
//     Future<void> pickImage() async {
//       final imagePicker = ImagePicker();
//       final pickedImage =
//           await imagePicker.pickImage(source: ImageSource.gallery);

//       if (pickedImage == null) return;

//       final appDir = await getApplicationDocumentsDirectory();
//       final fileName = path.basename(pickedImage.path);
//       final savedImage =
//           await File(pickedImage.path).copy('${appDir.path}/$fileName');

//       selectedImageFile = savedImage; // Spara filen
//     }

//     return Scaffold(
//       appBar: CustomAppBar(
//         appBarTitle: "Add Collection",
//         actions: [
//           TextButton(
//             onPressed: formState.isValid && selectedImageFile != null
//                 ? () => _addPlaceCollection(
//                       context,
//                       ref,
//                       formState.title,
//                       formState.description,
//                       selectedImageFile!.path, // Skicka bildvägen till metoden
//                     )
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
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: pickImage, // Anropa funktionen för att välja bild
//               child: const Text('Pick an Image'),
//             ),
//             const SizedBox(height: 10),
//             AddPlaceCollectionForm(
//               onSubmit: () => _addPlaceCollection(
//                   context,
//                   ref,
//                   formState.title,
//                   formState.description,
//                   selectedImageFile?.path ?? ''), // Kontrollera om bild finns
//             ),
//             const SizedBox(height: 10),
//             const LocationInput(),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/models/place_location.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../collection/add_collection/providers/add_collection_form_provider.dart';
import '../collection/add_collection/ui/widgets/add_collection_form.dart';
import 'package:path_provider/path_provider.dart'; // För att hantera lokal lagring
import 'package:path/path.dart' as path; // För att hantera filvägar
import 'dart:io'; // För att använda File
import 'package:image_picker/image_picker.dart'; // För att använda ImagePicker och ImageSource
import '../../core/widgets/location_input.dart'; // Importera din LocationInput

class AddPlaceCollectionPage2 extends ConsumerWidget {
  AddPlaceCollectionPage2({super.key});

  // Variabel för att lagra den valda platsen
  PlaceLocation? _selectedLocation;

  // Callback för att ta emot platsdata från LocationInput
  void _selectPlaceLocation(PlaceLocation location) {
    _selectedLocation = location;
  }

  void _addPlaceCollection(BuildContext context, WidgetRef ref, String title,
      String description, String imagePath) {
    if (_selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a location.'),
        ),
      );
      return;
    }

    // Lägg till platskollektionen
    // ref.read(placeCollectionListProvider.notifier).addPlaceCollection(
    //     title, description, imagePath); // Lägg till imagePath här
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AddCollectionFormState formState =
        ref.watch(addCollectionFormProvider);

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
            onPressed: formState.isValid && selectedImageFile != null
                ? () => _addPlaceCollection(
                      context,
                      ref,
                      formState.title,
                      formState.description,
                      selectedImageFile!.path, // Skicka bildvägen till metoden
                    )
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
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickImage, // Anropa funktionen för att välja bild
              child: const Text('Pick an Image'),
            ),
            const SizedBox(height: 10),
            AddCollectionForm(
              onSubmit: () => _addPlaceCollection(
                  context,
                  ref,
                  formState.title,
                  formState.description,
                  selectedImageFile?.path ?? ''), // Kontrollera om bild finns
            ),
            const SizedBox(height: 10),
            // Skicka funktionen för att ta emot platsdata från LocationInput
            LocationInput(onSelectLocation: _selectPlaceLocation),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:typed_data'; // För att använda Uint8List
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'place.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../widgets/location_input.dart'; // Lägg till Riverpod för state management

// // Definiera din provider
// final userPlacesProvider =
//     StateNotifierProvider<UserPlacesNotifier, List<Place>>((ref) {
//   return UserPlacesNotifier();
// });

// // Skapa en StateNotifier för att hantera platser
// class UserPlacesNotifier extends StateNotifier<List<Place>> {
//   UserPlacesNotifier() : super([]);

//   void addPlace(Place place) {
//     state = [...state, place]; // Lägg till en ny plats i listan
//   }
// }

// class AddPlaceScreen extends ConsumerStatefulWidget {
//   const AddPlaceScreen({super.key});

//   @override
//   _AddPlaceScreenState createState() => _AddPlaceScreenState();
// }

// class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
//   final _titleController = TextEditingController();
//   final _descriptionController =
//       TextEditingController(); // Beskrivningskontroller
//   File? _selectedImageFile;
//   Uint8List? _selectedImageBytes;

//   void _takePicture() async {
//     final imagePicker = ImagePicker();
//     final pickedImage = await imagePicker.pickImage(
//       source: ImageSource.camera,
//       maxWidth: 600,
//     );

//     if (pickedImage == null) {
//       return;
//     }

//     if (kIsWeb) {
//       final imageBytes = await pickedImage.readAsBytes();
//       setState(() {
//         _selectedImageBytes = imageBytes;
//       });
//     } else {
//       setState(() {
//         _selectedImageFile = File(pickedImage.path);
//       });
//     }
//   }

//   // Lägg till funktionalitet för att spara platsen
//   void _savePlace() {
//     final enteredTitle = _titleController.text;
//     final enteredDescription = _descriptionController.text;

//     if (enteredTitle.isEmpty ||
//         (_selectedImageFile == null && _selectedImageBytes == null) ||
//         enteredDescription.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please provide a title, description, and an image.'),
//         ),
//       );
//       return;
//     }

//     // Skapa ett nytt Place-objekt
//     final newPlace = Place(
//       title: enteredTitle,
//       description: enteredDescription, // Lägger till beskrivning
//       image: _selectedImageFile ?? File(''), // Hanterar bilden
//       createdAt: DateTime.now(), // Tidpunkt då platsen skapades
//     );

//     // Lägg till platsen i listan via din provider
//     ref.read(userPlacesProvider.notifier).addPlace(newPlace);

//     print('Place saved! Title: $enteredTitle');
//     Navigator.of(context).pop(); // Gå tillbaka efter att platsen sparats
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget imageDisplay = TextButton.icon(
//       icon: const Icon(Icons.camera),
//       label: const Text('Take Picture'),
//       onPressed: _takePicture,
//     );

//     if (_selectedImageBytes != null) {
//       imageDisplay = GestureDetector(
//         onTap: _takePicture,
//         child: Image.memory(
//           _selectedImageBytes!,
//           fit: BoxFit.cover,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//       );
//     } else if (_selectedImageFile != null) {
//       imageDisplay = GestureDetector(
//         onTap: _takePicture,
//         child: Image.file(
//           _selectedImageFile!,
//           fit: BoxFit.cover,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add new Place'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: TextField(
//               decoration: InputDecoration(
//                 labelText: 'Title',
//                 labelStyle: TextStyle(
//                   color: Theme.of(context)
//                       .colorScheme
//                       .onSurface, // Fast färg för etiketten
//                 ),
//               ),
//               controller: _titleController,
//               style: TextStyle(
//                 color: Theme.of(context)
//                     .colorScheme
//                     .onSurface, // Fast färg för inmatad text
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: TextField(
//               decoration: InputDecoration(
//                 labelText: 'Description',
//                 labelStyle: TextStyle(
//                   color: Theme.of(context)
//                       .colorScheme
//                       .onSurface, // Fast färg för etiketten
//                 ),
//               ),
//               controller:
//                   _descriptionController, // Lägg till beskrivningskontroll
//               style: TextStyle(
//                 color: Theme.of(context)
//                     .colorScheme
//                     .onSurface, // Fast färg för inmatad text
//               ),
//               maxLines: 3, // Tillåter flera rader för beskrivning
//             ),
//           ),
//           const SizedBox(height: 10),
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(
//                 width: 1,
//                 color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
//               ),
//             ),
//             height: 250,
//             width: double.infinity,
//             alignment: Alignment.center,
//             child: imageDisplay,
//           ),
//           const SizedBox(height: 10),
//           const LocationInput(),
//           ElevatedButton.icon(
//             onPressed: _savePlace,
//             icon: const Icon(Icons.add),
//             label: const Text('Add Place'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data'; // För att använda Uint8List
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../core/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/place_location.dart';
import '../../core/widgets/location_input.dart';

// Definiera din provider
final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place2>>((ref) {
  return UserPlacesNotifier();
});

// Skapa en StateNotifier för att hantera platser
class UserPlacesNotifier extends StateNotifier<List<Place2>> {
  UserPlacesNotifier() : super([]);

  void addPlace(Place2 place) {
    state = [...state, place]; // Lägg till en ny plats i listan
  }
}

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _selectedImageFile;
  Uint8List? _selectedImageBytes;
  PlaceLocation? _selectedLocation; // Lagra vald plats

  // Callback för att ta emot plats från LocationInput
  void _selectPlaceLocation(PlaceLocation location) {
    _selectedLocation = location;
  }

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }

    if (kIsWeb) {
      final imageBytes = await pickedImage.readAsBytes();
      setState(() {
        _selectedImageBytes = imageBytes;
      });
    } else {
      setState(() {
        _selectedImageFile = File(pickedImage.path);
      });
    }
  }

  // Lägg till funktionalitet för att spara platsen
  void _savePlace() {
    final enteredTitle = _titleController.text;
    final enteredDescription = _descriptionController.text;

    if (enteredTitle.isEmpty ||
        (_selectedImageFile == null && _selectedImageBytes == null) ||
        enteredDescription.isEmpty ||
        _selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Please provide a title, description, image, and location.'),
        ),
      );
      return;
    }

    // Skapa ett nytt Place-objekt med platsinformation
    final newPlace = Place2(
      title: enteredTitle,
      description: enteredDescription,
      image: _selectedImageFile ?? File(''),
      createdAt: DateTime.now(),
      //location: _selectedLocation!, // Använd vald plats
    );

    // Lägg till platsen i listan via din provider
    ref.read(userPlacesProvider.notifier).addPlace(newPlace);

    print(
        'Place saved! Title: $enteredTitle, Location: ${_selectedLocation!.address}');
    Navigator.of(context).pop(); // Gå tillbaka efter att platsen sparats
  }

  @override
  Widget build(BuildContext context) {
    Widget imageDisplay = TextButton.icon(
      icon: const Icon(Icons.camera),
      label: const Text('Take Picture'),
      onPressed: _takePicture,
    );

    if (_selectedImageBytes != null) {
      imageDisplay = GestureDetector(
        onTap: _takePicture,
        child: Image.memory(
          _selectedImageBytes!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    } else if (_selectedImageFile != null) {
      imageDisplay = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _selectedImageFile!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              controller: _descriptionController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              maxLines: 3,
            ),
          ),
          const SizedBox(height: 10),
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
            child: imageDisplay,
          ),
          const SizedBox(height: 10),
          // Lägg till LocationInput med callback för att ta emot platsdata
          LocationInput(onSelectLocation: _selectPlaceLocation),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../features/main/providers/user_places.dart';
// import '../widgets/image_input.dart';
// import 'dart:io';

// class AddPlaceScreen extends ConsumerStatefulWidget {
//   const AddPlaceScreen({super.key});

//   @override
//   ConsumerState<AddPlaceScreen> createState() {
//     return _AddPlaceScreenState();
//   }
// }

// class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
//   final _titleController = TextEditingController();
//   File? _selectedImage;

//   void _savePlace() {
//     final enteredTitle = _titleController.text;

//     if (enteredTitle.isEmpty || _selectedImage == null) {
//       return;
//     }

//     ref
//         .read(userPlacesProvider.notifier)
//         .addPlace(enteredTitle, _selectedImage!);

//     Navigator.of(context).pop();
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add new Place'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             TextField(
//               decoration: const InputDecoration(labelText: 'Title'),
//               controller: _titleController,
//               style: TextStyle(
//                 color: Theme.of(context).colorScheme.onSurface,
//               ),
//             ),
//             const SizedBox(height: 10),
//             ImageInput(
//               onPickImage: (image) {
//                 _selectedImage = image;
//               },
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton.icon(
//               onPressed: _savePlace,
//               icon: const Icon(Icons.add),
//               label: const Text('Add Place'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;

// class AddPlaceScreen extends StatefulWidget {
//   const AddPlaceScreen({super.key});

//   @override
//   _AddPlaceScreenState createState() => _AddPlaceScreenState();
// }

// class _AddPlaceScreenState extends State<AddPlaceScreen> {
//   final _titleController = TextEditingController();
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

//   void _savePlace() {
//     final enteredTitle = _titleController.text;

//     if (enteredTitle.isEmpty ||
//         (_selectedImageFile == null && _selectedImageBytes == null)) {
//       // If title or image is not set, show an error
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please provide a title and image.')),
//       );
//       return;
//     }

//     // Handle saving the place data (e.g., send to database, API, etc.)
//     print('Place saved! Title: $enteredTitle');

//     // Reset form after saving
//     _titleController.clear();
//     setState(() {
//       _selectedImageFile = null;
//       _selectedImageBytes = null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget imageDisplay = TextButton.icon(
//       icon: const Icon(Icons.camera),
//       label: const Text('Take Picture'),
//       onPressed: _takePicture,
//     );

//     if (kIsWeb && _selectedImageBytes != null) {
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
//               decoration: const InputDecoration(labelText: 'Title'),
//               controller: _titleController,
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
import 'package:path_provider/path_provider.dart'; // För lokal lagring
import 'package:shared_preferences/shared_preferences.dart'; // För att spara metadata lokalt
import 'package:path/path.dart' as path; // För att hantera filvägar

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImageFile;
  Uint8List? _selectedImageBytes;

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

  // Spara bilden lokalt och returnera dess sökväg
  Future<String> _saveImageLocally(File imageFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    return savedImage.path;
  }

  Future<void> _savePlace() async {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty ||
        (_selectedImageFile == null && _selectedImageBytes == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide a title and an image.')),
      );
      return;
    }

    String imagePath = '';
    if (_selectedImageFile != null) {
      imagePath = await _saveImageLocally(_selectedImageFile!);
    }

    // Spara titel och bildväg i SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final savedPlaces = prefs.getStringList('places') ?? [];
    final newPlaceData = '$enteredTitle|$imagePath';
    savedPlaces.add(newPlaceData);
    await prefs.setStringList('places', savedPlaces);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Place saved locally!')),
    );

    _titleController.clear();
    setState(() {
      _selectedImageFile = null;
      _selectedImageBytes = null;
    });
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
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
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}

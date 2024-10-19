// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'place.dart';

// class PlaceDetailScreen extends StatelessWidget {
//   const PlaceDetailScreen({super.key, required this.place});

//   final Place place;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(place.title),
//       ),
//        body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Show the picture place if it exist
//             if (place.image.path.isNotEmpty)
//               Container(
//                 height: 250,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                 ),
//                 child: Image.file(
//                   File(place.image.path),
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                 ),
//               ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 place.title,
//                 style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onSurface,
//                     ),
//               ),
//             ),
//             // Add additional info about place
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 'Additional details about the place can go here.',
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                       color: Theme.of(context).colorScheme.onSurface,
//                     ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final Place2 place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show the picture place if it exists
            if (place.image.path.isNotEmpty)
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
                child: Image.file(
                  File(place.image.path),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                place.title,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            // Add additional info about place
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                place.description, // Display the description from the place object
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                         ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Created on: ${place.createdAt.toLocal().toString()}', // Show when the place was created
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

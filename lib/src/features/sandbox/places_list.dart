// import 'package:flutter/material.dart';
// import '../models/place.dart';
// import '../models/place_detail.dart';

// class PlacesList extends StatelessWidget {
//   const PlacesList({super.key, required this.places});

//   final List<Place> places;

//   @override
//   Widget build(BuildContext context) {
//     if (places.isEmpty) {
//       return Center(
//         child: Text(
//           'No places added yet',
//           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                 color: Theme.of(context).colorScheme.onSurface,
//               ),
//         ),
//       );
//     }

//     return ListView.builder(
//       itemCount: places.length,
//       itemBuilder: (ctx, index) => ListTile(
//         leading: CircleAvatar(
//           radius: 26,
//           backgroundImage: FileImage(places[index].image),
//         ),
//         title: Text(
//           places[index].title,
//           style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                 color: Theme.of(context).colorScheme.onSurface,
//               ),
//         ),
//         onTap: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (ctx) => PlaceDetailScreen(place: places[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import '../../core/models/place.dart';
import 'place_detail.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          'No places added yet',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      );
    }

    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) => ListTile(
        leading: places[index].imagePath == null
            ? const Icon(Icons.image_not_supported)
            : CircleAvatar(
                radius: 26,
                backgroundImage: FileImage(File(places[index].imagePath!)),
              ),
        title: Text(
          places[index].title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => PlaceDetailScreen(place: places[index]),
            ),
          );
        },
      ),
    );
  }
}

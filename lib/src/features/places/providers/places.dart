// import 'package:flutter/material.dart';
// import 'package:spotly/src/core/widgets/places_list.dart';

// class PlacesScreen extends StatelessWidget {
//   const PlacesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Places'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: PlacesList(
//         places: [],
//       ),
//     );
//   }

import 'package:flutter/material.dart';
import 'package:spotly/src/core/widgets/places_list.dart';
import 'package:spotly/src/core/models/add_places.dart'; // Make sure the path is correct
import 'package:spotly/src/core/widgets/places_list.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to AddPlaceScreen when the "+" icon is pressed
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddPlaceScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: PlacesList(
        places: [], // Ensure PlacesList is handled properly
      ),
    );
  }
}

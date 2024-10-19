// //För mobila enheter:

// import 'package:flutter/material.dart';
// import 'package:location/location.dart';

// class LocationInput extends StatefulWidget {
//   const LocationInput({super.key});

//   @override
//   State<LocationInput> createState() {
//     return _LocationInputState();
//   }
// }

// class _LocationInputState extends State<LocationInput> {
//   Location? _pickedLocation;
//   var _isGettingLocation = false;

//   void _getCurrentLocation() async {
//     // setState(() {
//     //   _isGettingLocation = true;
//     // });
//     Location location = Location();

//     bool serviceEnabled;
//     PermissionStatus permissionGranted;
//     LocationData locationData;

//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return;
//       }
//     }

//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     setState(() {
//       _isGettingLocation = true;
//     });

//     locationData = await location.getLocation();

//     setState(() {
//       _isGettingLocation = false;
//     });

//     print(locationData.latitude);
//     print(locationData.longitude);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget previewContent = Text(
//       'No location chosen', // Placerat texten inuti child
//       textAlign: TextAlign.center,
//       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//             color: Theme.of(context).colorScheme.onSurface,
//           ),
//     );

//     if (_isGettingLocation) {
//       previewContent = const CircularProgressIndicator();
//     }
//     return Column(
//       children: [
//         Container(
//           height: 170,
//           width: double.infinity,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             border: Border.all(
//               width: 1,
//               color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
//             ),
//           ),
//           child: Text(
//             'No location chosen', // Placerat texten inuti child
//             textAlign: TextAlign.center,
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                   color: Theme.of(context).colorScheme.onSurface,
//                 ),
//           ),
//         ),
//         const SizedBox(
//             height: 10), // Lägger till mellanrum mellan container och knappar
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             TextButton.icon(
//               icon: const Icon(Icons.location_on),
//               label: const Text('Get current location'),
//               onPressed: _getCurrentLocation,
//             ),
//             TextButton.icon(
//               icon: const Icon(Icons.map),
//               label: const Text('Select on map'),
//               onPressed: () {},
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// //Till webbversionen:

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class LocationInput extends StatefulWidget {
//   const LocationInput({super.key});

//   @override
//   State<LocationInput> createState() {
//     return _LocationInputState();
//   }
// }

// class _LocationInputState extends State<LocationInput> {
//   Position? _pickedLocation;
//   var _isGettingLocation = false;

//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Kolla om platstjänster är aktiverade
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Visa meddelande om att platstjänster behöver vara på
//       return;
//     }

//     // Kolla och begär platsbehörigheter
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Platsbehörigheter är permanent nekade, hantera detta på lämpligt sätt
//       return;
//     }

//     setState(() {
//       _isGettingLocation = true;
//     });

//     // Hämta platsen
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//     final lat = position.latitude;
//     final lng = position.longitude;

//     final url = Uri.parse(
//         'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyAURvTmbqxJjORFFxip40ar2E1Yo1l5aJc');
//     final response = await http.get(url);
//     final resData = json.decode(response.body);
//     final address = resData['results'][0]['formatted_address'];

//     setState(() {
//       _pickedLocation = position;
//       _isGettingLocation = false;
//     });

//     //print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget previewContent = Text(
//       'No location chosen',
//       textAlign: TextAlign.center,
//       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//             color: Theme.of(context).colorScheme.onSurface,
//           ),
//     );

//     if (_isGettingLocation) {
//       previewContent = const CircularProgressIndicator();
//     } else if (_pickedLocation != null) {
//       previewContent = Text(
//         'Location: \nLatitude: ${_pickedLocation!.latitude}, \nLongitude: ${_pickedLocation!.longitude}',
//         textAlign: TextAlign.center,
//         style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//               color: Theme.of(context).colorScheme.onSurface,
//             ),
//       );
//     }

//     return Column(
//       children: [
//         Container(
//           height: 170,
//           width: double.infinity,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             border: Border.all(
//               width: 1,
//               color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
//             ),
//           ),
//           child: previewContent,
//         ),
//         const SizedBox(
//             height: 10), // Lägger till mellanrum mellan container och knappar
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             TextButton.icon(
//               icon: const Icon(Icons.location_on),
//               label: const Text('Get current location'),
//               onPressed: _getCurrentLocation,
//             ),
//             TextButton.icon(
//               icon: const Icon(Icons.map),
//               label: const Text('Select on map'),
//               onPressed: () {},
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../models/place.dart'; // För PlaceLocation

// class LocationInput extends StatefulWidget {
//   final Function(PlaceLocation)
//       onSelectLocation; // Callback för att skicka platsdata

//   const LocationInput({super.key, required this.onSelectLocation});

//   @override
//   State<LocationInput> createState() {
//     return _LocationInputState();
//   }
// }

// class _LocationInputState extends State<LocationInput> {
//   PlaceLocation? _pickedLocation;
//   var _isGettingLocation = false;

//   String get locationImage {
//     if (_pickedLocation == null) {
//       return '';
//     }
//     final lat = _pickedLocation!.latitude;
//     final lng = _pickedLocation!.longitude;

//     return 'https://maps.googleapis.com/maps/api/staticmap?center$lat,$lng=&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyAURvTmbqxJjORFFxip40ar2E1Yo1l5aJc';
//   }

//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Kolla om platstjänster är aktiverade
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return;
//     }

//     // Kolla och begär platsbehörigheter
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return;
//     }

//     setState(() {
//       _isGettingLocation = true;
//     });

//     // Hämta platsen
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//     final lat = position.latitude;
//     final lng = position.longitude;

//     if (lat == null || lng == null) {
//       return;
//     }

//     final url = Uri.parse(
//         'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyAURvTmbqxJjORFFxip40ar2E1Yo1l5aJc');
//     final response = await http.get(url);
//     final resData = json.decode(response.body);
//     final address = resData['results'][0]['formatted_address'];

//     setState(() {
//       _pickedLocation = _pickedLocation =
//           PlaceLocation(latitude: lat, longitude: lng, address: address);

//       _isGettingLocation = false;
//     });

//     // Skicka tillbaka platsen till AddPlaceScreen
//     widget.onSelectLocation(
//       PlaceLocation(latitude: lat, longitude: lng, address: address),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget previewContent = Text(
//       'No location chosen',
//       textAlign: TextAlign.center,
//       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//             color: Theme.of(context).colorScheme.onSurface,
//           ),
//     );

//     if (_pickedLocation != null) {
//       previewContent = Image.network(locationImage,
//           fit: BoxFit.cover, width: double.infinity, height: double.infinity);
//     }

//     if (_isGettingLocation) {
//       previewContent = const CircularProgressIndicator();
//     } else if (_pickedLocation != null) {
//       previewContent = Text(
//         'Location: \nLatitude: ${_pickedLocation!.latitude}, \nLongitude: ${_pickedLocation!.longitude}',
//         textAlign: TextAlign.center,
//         style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//               color: Theme.of(context).colorScheme.onSurface,
//             ),
//       );
//     }

//     return Column(
//       children: [
//         Container(
//           height: 170,
//           width: double.infinity,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             border: Border.all(
//               width: 1,
//               color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
//             ),
//           ),
//           child: previewContent,
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             TextButton.icon(
//               icon: const Icon(Icons.location_on),
//               label: const Text('Get current location'),
//               onPressed: _getCurrentLocation,
//             ),
//             TextButton.icon(
//               icon: const Icon(Icons.map),
//               label: const Text('Select on map'),
//               onPressed: () {},
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import '../models/place.dart';
import '../models/place_location.dart'; // För PlaceLocation

class LocationInput extends StatefulWidget {
  final Function(PlaceLocation)
      onSelectLocation; // Callback för att skicka platsdata

  const LocationInput({super.key, required this.onSelectLocation});

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;

  String get locationImage {
    if (_pickedLocation == null) {
      return '';
    }
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;

    // Korrigerad URL med "=" efter "center"
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyAURvTmbqxJjORFFxip40ar2E1Yo1l5aJc';
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Kolla om platstjänster är aktiverade
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // Kolla och begär platsbehörigheter
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    setState(() {
      _isGettingLocation = true;
    });

    // Hämta platsen
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final lat = position.latitude;
    final lng = position.longitude;

    if (lat == null || lng == null) {
      return;
    }

    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyAURvTmbqxJjORFFxip40ar2E1Yo1l5aJc');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    final address = resData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation =
          PlaceLocation(latitude: lat, longitude: lng, address: address);
      _isGettingLocation = false;
    });

    // Skicka tillbaka platsen till AddPlaceScreen
    widget.onSelectLocation(
      PlaceLocation(latitude: lat, longitude: lng, address: address),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
    );

    if (_pickedLocation != null) {
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return const Text(
            'Could not load map.',
            textAlign: TextAlign.center,
          );
        },
      );
    }

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: previewContent,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Get current location'),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

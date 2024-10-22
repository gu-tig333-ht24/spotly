import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../features/place/place_detail/ui/pages/map_page.dart';
import '../constants/app_sizes.dart';
import '../models/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({
    super.key,
    required this.onLocationSelected,
    this.initialSelection,
  });

  final Function(Location) onLocationSelected;
  final Location? initialSelection;

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  Location? _pickedLocation;
  var _isGettingLocation = false;

  @override
  void initState() {
    super.initState();

    if (widget.initialSelection == null) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePicker(widget.initialSelection!);
    });
  }

  Future<void> _initializePicker(Location location) async {
    setState(() {
      _isGettingLocation = true;
    });

    final lat = location.latitude;
    final lng = location.longitude;

    if (lng == null) {
      return;
    }
    String address =
        "Unknown location"; // Standardvärde tills adressen hämtas via API

    _savePlace(lat, lng);
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyAURvTmbqxJjORFFxip40ar2E1Yo1l5aJc');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    address = resData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation = Location(
        id: location.id,
        latitude: lat,
        longitude: lng,
        address: address,
      );
      _isGettingLocation = false;
    });

    // Skicka tillbaka platsen till AddPlaceScreen
    widget.onLocationSelected(_pickedLocation!);

    _savePlace(lat, lng);
  }

  String get locationImage {
    if (_pickedLocation == null) {
      return '';
    }
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;

    // Korrigerad URL med "=" efter "center"
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyAURvTmbqxJjORFFxip40ar2E1Yo1l5aJc';
  }

  void _savePlace(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyAURvTmbqxJjORFFxip40ar2E1Yo1l5aJc');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    final address = resData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation = Location(
        id: -1,
        latitude: latitude,
        longitude: longitude,
        address: address,
      );
      _isGettingLocation = false;
    });
    widget.onLocationSelected(_pickedLocation!);
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

    if (lng == null) {
      return;
    }
    String address =
        "Unknown location"; // Standardvärde tills adressen hämtas via API

    _savePlace(lat, lng);
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyAURvTmbqxJjORFFxip40ar2E1Yo1l5aJc');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    address = resData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation = Location(
        id: -1,
        latitude: lat,
        longitude: lng,
        address: address,
      );
      _isGettingLocation = false;
    });

    // Skicka tillbaka platsen till AddPlaceScreen
    widget.onLocationSelected(_pickedLocation!);

    _savePlace(lat, lng);
  }

  void _selectOnMap() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => const MapPage(),
      ),
    );
    if (pickedLocation == null) {
      return;
    }
    _savePlace(pickedLocation.latitude, pickedLocation.longitude);
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
        const SizedBox(height: AppSizes.s10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Get current location'),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}

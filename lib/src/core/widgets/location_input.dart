import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../features/shared/ui/pages/map_page.dart';
import '../constants/app_sizes.dart';
import '../models/location.dart';

const String _staticMapBaseUrl =
    "https://maps.googleapis.com/maps/api/staticmap";
const String _addressBaseUrl =
    "https://maps.googleapis.com/maps/api/geocode/json";
const String _apiKey = "AIzaSyAURvTmbqxJjORFFxip40ar2E1Yo1l5aJc";

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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializePicker(widget.initialSelection!);
    });
  }

  Future<void> _initializePicker(Location location) async {
    setState(() => _isGettingLocation = true);
    await _selectLocation(location);
    setState(() => _isGettingLocation = false);
  }

  Future<void> _selectLocation(Location location) async {
    final address = await _getAddressFromApi(
          location.latitude,
          location.longitude,
        ) ??
        "Unknown location";

    _pickedLocation = location.copyWith(
      id: location.id,
      address: address,
    );

    // Notify anything listening about the picked location.
    widget.onLocationSelected(_pickedLocation!);
  }

  Future<String?> _getAddressFromApi(double latitude, double longitude) async {
    final url = Uri.parse(
      "$_addressBaseUrl?latlng=$latitude,$longitude&key=$_apiKey",
    );

    final response = await http.get(url);
    if (response.statusCode != HttpStatus.ok) {
      return null;
    }

    final data = json.decode(response.body);
    return data["results"][0]["formatted_address"];
  }

  String get locationImageUrl {
    if (_pickedLocation == null) {
      return "";
    }

    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;

    return "$_staticMapBaseUrl?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=$_apiKey";
  }

  Future<bool> hasPermissions() async {
    // Check if location services are enabled.
    if (!await Geolocator.isLocationServiceEnabled()) {
      return false;
    }

    // Check and request location permissions.
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<void> _getCurrentLocation() async {
    if (!await hasPermissions()) {
      return;
    }

    setState(() => _isGettingLocation = true);

    // Get current position.
    final Position position;
    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } on TimeoutException {
      setState(() => _isGettingLocation = false);
      return;
    }

    await _selectLocation(
      Location(
        id: -1,
        latitude: position.latitude,
        longitude: position.longitude,
        address: null,
      ),
    );

    setState(() => _isGettingLocation = false);
  }

  Future<void> _selectOnMap() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => MapPage(
          initialLocation: widget.initialSelection,
        ),
      ),
    );
    if (pickedLocation == null) {
      return;
    }

    setState(() => _isGettingLocation = true);

    await _selectLocation(
      Location(
        id: -1,
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: null,
      ),
    );

    setState(() => _isGettingLocation = false);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      "No location chosen",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
    );

    if (_pickedLocation != null) {
      previewContent = Image.network(
        locationImageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return const Text(
            "Could not load map.",
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
              label: const Text("Get current location"),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text("Select on map"),
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}

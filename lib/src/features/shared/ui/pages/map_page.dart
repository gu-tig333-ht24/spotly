import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/models/location.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_icon_button.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    super.key,
    this.initialLocation,
    this.isSelecting = true,
  });

  final Location? initialLocation;
  final bool isSelecting;

  @override
  State<MapPage> createState() {
    return _MapPageState();
  }
}

class _MapPageState extends State<MapPage> {
  LatLng? _pickedCoordinates;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  void _initializeMap(GoogleMapController controller) {
    _mapController = controller;
    _animateCameraToLocation();
  }

  Future<bool> _hasPermissions() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      // Manage if location services are not enabled.
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle if permission is permanently denied.
      return false;
    }

    return true;
  }

  void _animateCameraToLocation() async {
    if (!await _hasPermissions()) {
      return;
    }

    if (widget.initialLocation != null) {
      _pickedCoordinates = LatLng(
        widget.initialLocation!.latitude,
        widget.initialLocation!.longitude,
      );
    }

    final LatLng coordinates;
    if (_pickedCoordinates != null) {
      coordinates = _pickedCoordinates!;
    } else {
      coordinates = const LatLng(
        37.422,
        -122.084,
      );
    }

    // If permissions are okay, initialize the map.
    setState(() {
      _mapController?.animateCamera(CameraUpdate.newLatLng(coordinates));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle:
            widget.isSelecting ? "Pick your Location" : "Your Location",
        actions: [
          if (widget.isSelecting)
            Tooltip(
              message: "Save Location",
              preferBelow: true,
              child: CustomIconButton(
                icon: Icons.save_rounded,
                onPressed: _pickedCoordinates != null
                    ? () => Navigator.of(context).pop(_pickedCoordinates)
                    : null,
              ),
            ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _initializeMap,
        onTap: widget.isSelecting
            ? (LatLng position) => setState(() => _pickedCoordinates = position)
            : null,
        initialCameraPosition: CameraPosition(
          target: _pickedCoordinates != null
              ? _pickedCoordinates!
              : const LatLng(
                  37.422,
                  -122.084,
                ),
          zoom: 16,
        ),
        markers: (_pickedCoordinates != null)
            ? {
                Marker(
                  markerId: const MarkerId("m1"),
                  position: _pickedCoordinates!,
                ),
              }
            : {},
      ),
    );
  }
}

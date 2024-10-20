import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/models/place.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../widgets/image_placeholder.dart';
import '../widgets/location_details.dart';
import '../widgets/location_map_view.dart';
import '../widgets/place_details.dart';

class PlaceDetailPage extends StatelessWidget {
  const PlaceDetailPage({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: place.title,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white10,
              ),
              child: place.imagePath != null && place.imagePath!.isNotEmpty
                  ? Image.file(
                      File(place.imagePath!),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (BuildContext context, Object error, _) {
                        return const ImagePlaceholder();

                        // TODO: can be used for debugging, remove later.
                        // return Text(
                        //   error.toString(),
                        //   style: const TextStyle(
                        //     color: Colors.black,
                        //   ),
                        // );
                      },
                    )
                  : const ImagePlaceholder(),
            ),
            const SizedBox(height: AppSizes.s20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.s20),
              child: PlaceDetails(place: place),
            ),
            if (place.location != null) ...[
              const SizedBox(height: AppSizes.s20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s20),
                child: LocationDetails(location: place.location!),
              ),
              const SizedBox(height: AppSizes.s20),
              LocationMapView(location: place.location!),
            ],
          ],
        ),
      ),
    );
  }
}

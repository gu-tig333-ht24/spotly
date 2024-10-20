import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/models/place.dart';
import '../../../../../core/utils/datetime_extensions.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../widgets/image_placeholder.dart';
import '../widgets/location_details.dart';

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
              padding: const EdgeInsets.all(AppSizes.s20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    place.title,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.s10),
                  Text(
                    place.description != null ? place.description! : "",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.s10),
                  // TODO: a more friendly datetime format
                  Text(
                    "Created on: ${place.createdAt.toLocal().friendlyFormat}",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(height: AppSizes.s20),
                  if (place.location != null)
                    LocationDetails(location: place.location!)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

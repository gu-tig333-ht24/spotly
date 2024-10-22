import 'package:flutter/material.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/models/location.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../shared/ui/pages/map_page.dart';

class LocationMapView extends StatelessWidget {
  const LocationMapView({
    super.key,
    required this.location,
  });

  final Location location;

  String get locationImage {
    final lat = location.latitude;
    final lng = location.longitude;

    // Korrigerad URL med "=" efter "center"
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyAURvTmbqxJjORFFxip40ar2E1Yo1l5aJc';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(AppSizes.s20),
          decoration: BoxDecoration(
            color: kInteractiveColor.withOpacity(0.5),
          ),
          child: Text(
            location.address ?? "",
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        const SizedBox(height: AppSizes.s20),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => MapPage(
                  initialLocation: location,
                  isSelecting: false,
                ),
              ),
            );
          },
          child: Column(
            children: [
              CircleAvatar(
                radius: 75,
                backgroundColor: kInteractiveColor,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(locationImage),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

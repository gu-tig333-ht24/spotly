import 'dart:io';

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/models/location.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import 'location_rich_text.dart';

class LocationDetails extends StatelessWidget {
  const LocationDetails({
    super.key,
    required this.location,
  });

  final Location location;

  Future<void> _launchMap() async {
    final lat = location.latitude;
    final lon = location.longitude;
    final address = location.address ?? "Unknown address";

    final Uri url;
    if (Platform.isIOS) {
      url = Uri.parse("maps:$lat,$lon?q=$lat,$lon");
    } else if (Platform.isAndroid) {
      url = Uri.parse("geo:$lat,$lon?q=$lat,$lon($address)");
    } else {
      // Not supported.
      return;
    }

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              "Location",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(width: AppSizes.s20),
            Tooltip(
              message: "Launch in ${Platform.isIOS ? "Apple" : "Google"} Maps",
              preferBelow: true,
              child: Platform.isIOS || Platform.isAndroid
                  ? CustomIconButton(
                      icon: Icons.map_rounded,
                      onPressed: _launchMap,
                    )
                  : null,
            ),
          ],
        ),
        const SizedBox(height: AppSizes.s10),
        LocationRichText(
          label: "Latitude",
          text: location.latitude.toString(),
        ),
        const SizedBox(height: AppSizes.s4),
        LocationRichText(
          label: "Longitude",
          text: location.longitude.toString(),
        ),
      ],
    );
  }
}

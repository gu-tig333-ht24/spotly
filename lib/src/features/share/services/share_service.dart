import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/models/place.dart';

class ShareService {
  Future<void> sharePlace(Place place, Rect? sharePositionOrigin) async {
    final Map<String, dynamic> map = place.toMap();

    // Add base64-encoded image only if not null
    if (place.imagePath != null) {
      final imageFile = File(place.imagePath!);
      final imageBytes = await imageFile.readAsBytes();
      map["image"] = base64Encode(imageBytes);
    }

    final jsonString = jsonEncode(map);

    // Save JSON data to a temporary file
    final tempDir = await getTemporaryDirectory();
    final jsonFile = File("${tempDir.path}/${place.title}.json");
    await jsonFile.writeAsString(jsonString);

    final file = XFile(jsonFile.path);
    Share.shareXFiles(
      [file],
      subject: place.title,
      text: place.description ?? "Shared Place",
      sharePositionOrigin: sharePositionOrigin,
    );

    // TODO: clean up file?
  }

  Future<bool> isThisDeviceIpad() async {
    if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS)) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      IosDeviceInfo info = await deviceInfo.iosInfo;
      return info.model.toLowerCase().contains("ipad");
    }
    return false;
  }
}

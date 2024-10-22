import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../core/models/place.dart';
import 'database_service.dart';

class PlaceService {
  PlaceService({
    required DatabaseService databaseService,
  }) : _databaseService = databaseService;

  final DatabaseService _databaseService;

  Future<bool> deletePlace(Place place) async {
    final deleted = await _databaseService.deletePlaceById(place.id);
    if (!deleted) {
      return false;
    }

    if (place.imagePath != null) {
      await deleteFileFromStorage(place.imagePath!);
    }

    return true;
  }

  Future<void> deleteFileFromStorage(String filePath) async {
    final file = File(filePath);

    if (!await file.exists()) {
      if (kDebugMode) {
        print("ℹ️ -> File does not exist: $filePath");
      }
      return;
    }

    try {
      await file.delete();
      if (kDebugMode) {
        print("✅ -> File deleted: $filePath");
      }
    } catch (e) {
      if (kDebugMode) {
        print("⚠️ -> Failed to delete file. Error: $e");
      }
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/database_service.dart';
import '../services/place_service.dart';
import 'database_providers.dart';

final placeServiceProvider = Provider<PlaceService>((ref) {
  final DatabaseService service = ref.read(databaseServiceProvider);
  return PlaceService(databaseService: service);
});

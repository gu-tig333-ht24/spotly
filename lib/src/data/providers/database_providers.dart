import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../database/interfaces/database_repository.dart';
import '../database/repositories/sqlite_database_repository.dart';
import '../services/database_service.dart';

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  final DatabaseRepository repository = ref.read(databaseRepositoryProvider);
  return DatabaseService(repository: repository);
});

final databaseRepositoryProvider = Provider<DatabaseRepository>((ref) {
  return SqliteDatabaseRepository(databaseName: AppConstants.appTitle);
});

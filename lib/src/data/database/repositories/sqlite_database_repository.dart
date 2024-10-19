import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../entities/collection_entity.dart';
import '../entities/place_entity.dart';
import '../interfaces/database_repository.dart';

class SqliteDatabaseRepository implements DatabaseRepository {
  SqliteDatabaseRepository({
    required String databaseName,
  }) : _databaseName = databaseName;

  final String _databaseName;
  static const _collectionsTable = "collections";
  static const _placesTable = "places";

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initialize();
    return _database!;
  }

  // region Setup

  Future<Database> initialize() async {
    // !: Source: https://docs.flutter.dev/cookbook/persistence/sqlite

    final databasePath = await getDatabasesPath();
    final filePath = join(databasePath, "$_databaseName.db");
    final db = await openDatabase(
      filePath,
      onCreate: _createTables,
      version: 1,
    );
    return db;
  }

  Future<void> _createTables(Database db, int version) async {
    await _createCollectionsTable(db);
    await _createPlacesTable(db);
  }

  Future<void> _createCollectionsTable(Database db) async {
    await db.execute("""
        CREATE TABLE $_collectionsTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
      """);
  }

  Future<void> _createPlacesTable(Database db) async {
    await db.execute("""
        CREATE TABLE $_placesTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        collectionId INTEGER,
        title TEXT NOT NULL,
        description TEXT,
        imagePath TEXT,
        createdAt TEXT NOT NULL
      )
      """);
  }

  // endregion

  // region Collections

  @override
  Future<CollectionEntity> createCollection(CollectionEntity entity) async {
    final db = await database;
    final id = await db.insert(_collectionsTable, entity.toMap());
    entity = entity.copyWith(id: id);
    return entity;
  }

  @override
  Future<List<CollectionEntity>> retrieveCollections() async {
    final db = await database;
    final result = await db.query(_collectionsTable);
    return result.map((json) => CollectionEntity.fromMap(json)).toList();
  }

  @override
  Future<CollectionEntity?> retrieveCollectionById(int id) async {
    final db = await database;
    final List<Map<String, Object?>> results = await db.query(
      _collectionsTable,
      columns: [
        "id",
        "title",
        "description",
        "createdAt",
      ],
      where: "id = ?",
      whereArgs: [id],
    );

    return results.isNotEmpty ? CollectionEntity.fromMap(results.first) : null;
  }

  @override
  Future<bool> updateCollection(CollectionEntity entity) async {
    final db = await database;
    final rowsUpdated = await db.update(
      _collectionsTable,
      entity.toMap(),
      where: "id = ?",
      whereArgs: [entity.id],
    );
    return rowsUpdated > 0;
  }

  @override
  Future<bool> deleteCollectionById(int id) async {
    final db = await database;
    final rowsDeleted = await db.delete(
      _collectionsTable,
      where: "id = ?",
      whereArgs: [id],
    );
    final deleted = rowsDeleted > 0;

    if (deleted) {
      // Delete Place:s that were "related" to the deleted Collection
      await db.delete(
        _placesTable,
        where: "collectionId = ?",
        whereArgs: [id],
      );
    }

    return deleted;
  }

  // endregion

  // region Places

  @override
  Future<PlaceEntity> createPlace(PlaceEntity entity) async {
    final db = await database;
    final id = await db.insert(_placesTable, entity.toMap());
    entity = entity.copyWith(id: id);
    return entity;
  }

  @override
  Future<List<PlaceEntity>> retrievesPlacesByCollectionId(
      int collectionId) async {
    final db = await database;
    final result = await db.query(
      _placesTable,
      where: "collectionId = ?",
      whereArgs: [collectionId],
    );
    return result.map((json) => PlaceEntity.fromMap(json)).toList();
  }

  @override
  Future<PlaceEntity?> retrievePlaceById(int id) async {
    final db = await database;
    final List<Map<String, Object?>> results = await db.query(
      _placesTable,
      columns: [
        "id",
        "collectionId",
        "title",
        "imagePath",
        "description",
        "createdAt",
      ],
      where: "id = ?",
      whereArgs: [id],
    );

    return results.isNotEmpty ? PlaceEntity.fromMap(results.first) : null;
  }

  @override
  Future<bool> updatePlace(PlaceEntity entity) async {
    final db = await database;
    final rowsUpdated = await db.update(
      _placesTable,
      entity.toMap(),
      where: "id = ?",
      whereArgs: [entity.id],
    );
    return rowsUpdated > 0;
  }

  @override
  Future<bool> deletePlaceById(int id) async {
    final db = await database;
    final rowsDeleted = await db.delete(
      _placesTable,
      where: "id = ?",
      whereArgs: [id],
    );
    return rowsDeleted > 0;
  }

// endregion
}

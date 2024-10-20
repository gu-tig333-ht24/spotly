import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../entities/collection_entity.dart';
import '../entities/location_entity.dart';
import '../entities/place_entity.dart';
import '../interfaces/database_repository.dart';

class SqliteDatabaseRepository implements DatabaseRepository {
  SqliteDatabaseRepository({
    required String databaseName,
  }) : _databaseName = databaseName;

  final String _databaseName;
  static const _collectionsTable = "collections";
  static const _locationsTable = "locations";
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
    await _createLocationsTable(db);
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

  Future<void> _createLocationsTable(Database db) async {
    await db.execute("""
        CREATE TABLE $_locationsTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        address TEXT NOT NULL
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
        createdAt TEXT NOT NULL,
        locationId INTEGER,
        FOREIGN KEY (locationId) REFERENCES locations(id) ON DELETE CASCADE
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

    int? locationId;
    if (entity.location != null) {
      locationId = await db.insert(_locationsTable, entity.location!.toMap());
    }

    final placeMap = entity.toMap();
    placeMap["locationId"] = locationId;
    final id = await db.insert(_placesTable, placeMap);
    return entity.copyWith(id: id);
  }

  @override
  Future<List<PlaceEntity>> retrievesPlacesByCollectionId(
    int collectionId,
  ) async {
    final db = await database;

    final List<Map<String, Object?>> results = await db.rawQuery("""
    SELECT 
      $_placesTable.id AS id,
      $_placesTable.collectionId AS collectionId,
      $_placesTable.title AS title,
      $_placesTable.description AS description,
      $_placesTable.imagePath AS imagePath,
      $_placesTable.createdAt AS createdAt,
      $_locationsTable.id AS locationId,
      $_locationsTable.latitude AS latitude,
      $_locationsTable.longitude AS longitude,
      $_locationsTable.address AS address
    FROM $_placesTable
    LEFT JOIN $_locationsTable 
      ON $_placesTable.locationId = $_locationsTable.id
    WHERE $_placesTable.collectionId = ?
  """, [collectionId]);

    return results.map((Map<String, Object?> row) {
      LocationEntity? location;
      if (row["locationId"] != null) {
        location = LocationEntity(
          id: row["locationId"] as int?,
          latitude: row["latitude"] as double,
          longitude: row["longitude"] as double,
          address: row["address"] as String,
        );
      }

      return PlaceEntity(
        id: row["id"] as int?,
        collectionId: row["collectionId"] as int,
        title: row["title"] as String,
        description: row["description"] as String,
        imagePath: row["imagePath"] as String,
        createdAt: DateTime.parse(row["createdAt"] as String),
        location: location,
      );
    }).toList();
  }

  @override
  Future<PlaceEntity?> retrievePlaceById(int id) async {
    final db = await database;

    final List<Map<String, Object?>> results = await db.rawQuery("""
    SELECT 
      $_placesTable.id AS id,
      $_placesTable.title AS title,
      $_placesTable.description AS description,
      $_placesTable.imagePath AS imagePath,
      $_placesTable.createdAt AS createdAt,
      $_placesTable.locationId AS locationId,
      $_locationsTable.id AS locationId,
      $_locationsTable.latitude AS latitude,
      $_locationsTable.longitude AS longitude,
      $_locationsTable.address AS address
    FROM $_placesTable
    LEFT JOIN $_locationsTable 
      ON $_placesTable.locationId = $_locationsTable.id
    WHERE $_placesTable.id = ?
    LIMIT 1
  """, [id]);

    if (results.isEmpty) {
      return null;
    }

    final placeMap = results.first;

    LocationEntity? location;
    if (placeMap["locationId"] != null) {
      location = LocationEntity(
        id: placeMap["locationId"] as int?,
        latitude: placeMap["latitude"] as double,
        longitude: placeMap["longitude"] as double,
        address: placeMap["address"] as String,
      );
    }

    return PlaceEntity.fromMap(placeMap, location);
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

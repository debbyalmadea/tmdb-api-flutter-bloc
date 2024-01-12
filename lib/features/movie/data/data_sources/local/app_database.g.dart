// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `movie` (`id` INTEGER, `title` TEXT, `overview` TEXT, `posterPath` TEXT, `voteAverage` REAL, `voteCount` INTEGER, `releaseDate` TEXT, `genreIds` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDAO {
    return _movieDAOInstance ??= _$MovieDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movieModelInsertionAdapter = InsertionAdapter(
            database,
            'movie',
            (MovieModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'overview': item.overview,
                  'posterPath': item.posterPath,
                  'voteAverage': item.voteAverage,
                  'voteCount': item.voteCount,
                  'releaseDate': item.releaseDate,
                  'genreIds': _stringListConverter.encode(item.genreIds)
                }),
        _movieModelDeletionAdapter = DeletionAdapter(
            database,
            'movie',
            ['id'],
            (MovieModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'overview': item.overview,
                  'posterPath': item.posterPath,
                  'voteAverage': item.voteAverage,
                  'voteCount': item.voteCount,
                  'releaseDate': item.releaseDate,
                  'genreIds': _stringListConverter.encode(item.genreIds)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieModel> _movieModelInsertionAdapter;

  final DeletionAdapter<MovieModel> _movieModelDeletionAdapter;

  @override
  Future<List<MovieModel>> getMovies() async {
    return _queryAdapter.queryList('SELECT * FROM movie',
        mapper: (Map<String, Object?> row) => MovieModel(
            id: row['id'] as int?,
            title: row['title'] as String?,
            overview: row['overview'] as String?,
            posterPath: row['posterPath'] as String?,
            voteAverage: row['voteAverage'] as double?,
            voteCount: row['voteCount'] as int?,
            releaseDate: row['releaseDate'] as String?,
            genreIds: _stringListConverter.decode(row['genreIds'] as String)));
  }

  @override
  Future<MovieModel?> getMovie(int id) async {
    return _queryAdapter.query('SELECT * FROM movie WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MovieModel(
            id: row['id'] as int?,
            title: row['title'] as String?,
            overview: row['overview'] as String?,
            posterPath: row['posterPath'] as String?,
            voteAverage: row['voteAverage'] as double?,
            voteCount: row['voteCount'] as int?,
            releaseDate: row['releaseDate'] as String?,
            genreIds: _stringListConverter.decode(row['genreIds'] as String)),
        arguments: [id]);
  }

  @override
  Future<void> insertMovie(MovieModel movie) async {
    await _movieModelInsertionAdapter.insert(movie, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMovie(MovieModel movie) async {
    await _movieModelDeletionAdapter.delete(movie);
  }
}

// ignore_for_file: unused_element
final _stringListConverter = StringListConverter();

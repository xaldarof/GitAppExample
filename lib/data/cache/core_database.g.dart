// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorCoreDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$CoreDatabaseBuilder databaseBuilder(String name) =>
      _$CoreDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$CoreDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$CoreDatabaseBuilder(null);
}

class _$CoreDatabaseBuilder {
  _$CoreDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$CoreDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$CoreDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<CoreDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$CoreDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$CoreDatabase extends CoreDatabase {
  _$CoreDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CacheDao? _cacheDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            'CREATE TABLE IF NOT EXISTS `AccountCacheModel` (`id` INTEGER, `login` TEXT NOT NULL, `avatarUrl` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CacheDao get cacheDao {
    return _cacheDaoInstance ??= _$CacheDao(database, changeListener);
  }
}

class _$CacheDao extends CacheDao {
  _$CacheDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _accountCacheModelInsertionAdapter = InsertionAdapter(
            database,
            'AccountCacheModel',
            (AccountCacheModel item) => <String, Object?>{
                  'id': item.id,
                  'login': item.login,
                  'avatarUrl': item.avatarUrl
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AccountCacheModel> _accountCacheModelInsertionAdapter;

  @override
  Future<List<AccountCacheModel>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM AccountCacheModel',
        mapper: (Map<String, Object?> row) => AccountCacheModel(
            id: row['id'] as int?,
            login: row['login'] as String,
            avatarUrl: row['avatarUrl'] as String?));
  }

  @override
  Future<AccountCacheModel?> getById(int id) async {
    return _queryAdapter.query('SELECT * FROM AccountCacheModel WHERE id=?1',
        mapper: (Map<String, Object?> row) => AccountCacheModel(
            id: row['id'] as int?,
            login: row['login'] as String,
            avatarUrl: row['avatarUrl'] as String?),
        arguments: [id]);
  }

  @override
  Future<AccountCacheModel?> delete(int id) async {
    return _queryAdapter.query('DELETE FROM AccountCacheModel WHERE id = ?1',
        mapper: (Map<String, Object?> row) => AccountCacheModel(
            id: row['id'] as int?,
            login: row['login'] as String,
            avatarUrl: row['avatarUrl'] as String?),
        arguments: [id]);
  }

  @override
  Future<AccountCacheModel?> updateName(String name, int id) async {
    return _queryAdapter.query(
        'UPDATE AccountCacheModel SET name = ?1 WHERE id =?2',
        mapper: (Map<String, Object?> row) => AccountCacheModel(
            id: row['id'] as int?,
            login: row['login'] as String,
            avatarUrl: row['avatarUrl'] as String?),
        arguments: [name, id]);
  }

  @override
  Future<int> insertUser(AccountCacheModel user) {
    return _accountCacheModelInsertionAdapter.insertAndReturnId(
        user, OnConflictStrategy.abort);
  }
}

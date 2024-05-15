// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FourFilesDB.dart';

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

  SurveyModelDao? _surveyModelDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
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
            'CREATE TABLE IF NOT EXISTS `survey` (`id` INTEGER, `title` TEXT, `description` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  SurveyModelDao get surveyModelDao {
    return _surveyModelDaoInstance ??=
        _$SurveyModelDao(database, changeListener);
  }
}

class _$SurveyModelDao extends SurveyModelDao {
  _$SurveyModelDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _surveyModelInsertionAdapter = InsertionAdapter(
            database,
            'survey',
            (SurveyModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description
                },
            changeListener),
        _surveyModelUpdateAdapter = UpdateAdapter(
            database,
            'survey',
            ['id'],
            (SurveyModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description
                },
            changeListener),
        _surveyModelDeletionAdapter = DeletionAdapter(
            database,
            'survey',
            ['id'],
            (SurveyModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SurveyModel> _surveyModelInsertionAdapter;

  final UpdateAdapter<SurveyModel> _surveyModelUpdateAdapter;

  final DeletionAdapter<SurveyModel> _surveyModelDeletionAdapter;

  @override
  Future<SurveyModel?> findById(int id) async {
    return _queryAdapter.query('SELECT * FROM survey WHERE id = ?1',
        mapper: (Map<String, Object?> row) => SurveyModel(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?),
        arguments: [id]);
  }

  @override
  Future<int?> getCount() async {
    return _queryAdapter.query('SELECT COUNT(id) FROM survey',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<List<SurveyModel>?> searchPattern(String search) async {
    return _queryAdapter.queryList('SELECT * FROM survey WHERE name = ?1',
        mapper: (Map<String, Object?> row) => SurveyModel(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?),
        arguments: [search]);
  }

  @override
  Future<List<SurveyModel>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM survey',
        mapper: (Map<String, Object?> row) => SurveyModel(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?));
  }

  @override
  Stream<List<SurveyModel>> findAllStream() {
    return _queryAdapter.queryListStream('SELECT * FROM survey',
        mapper: (Map<String, Object?> row) => SurveyModel(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?),
        queryableName: 'survey',
        isView: false);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM survey');
  }

  @override
  Future<int> insertTransaction(SurveyModel transaction) {
    return _surveyModelInsertionAdapter.insertAndReturnId(
        transaction, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertTransactions(List<SurveyModel> transactions) {
    return _surveyModelInsertionAdapter.insertListAndReturnIds(
        transactions, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateTransaction(SurveyModel transaction) {
    return _surveyModelUpdateAdapter.updateAndReturnChangedRows(
        transaction, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateTransactions(List<SurveyModel> transactions) {
    return _surveyModelUpdateAdapter.updateListAndReturnChangedRows(
        transactions, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteTransaction(SurveyModel transaction) async {
    await _surveyModelDeletionAdapter.delete(transaction);
  }

  @override
  Future<int> deleteTransactions(List<SurveyModel> transactions) {
    return _surveyModelDeletionAdapter
        .deleteListAndReturnChangedRows(transactions);
  }
}

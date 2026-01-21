part of LukOjeApp;

class Database {
  StoreRef? store;
  dynamic database;

  Database._();
  static final Database _instance = Database._();

  factory Database() => _instance;

  bool _initialized = false;

  Future<void> init() => _initOnce();

  Future<void> _initOnce() async {
    if (_initialized) return;
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    var path = join(dir.path, 'sleepData.db');
    database = await databaseFactoryIo.openDatabase(path);
    store = intMapStoreFactory.store('sleep_data_store');
    _initialized = true;
  }

  /// Async getter that returns the singleton and ensures the DB is initialized.
  static Future<Database> getInstance() async {
    await _instance._initOnce();
    return _instance;
  }
}
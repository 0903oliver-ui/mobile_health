part of LukOjeApp;

class Database {
  StoreRef? store;
  dynamic database;

  Database._();
  static final Database _instance = Database._();

  factory Database(){
    return _instance;
  }

  bool _initialized = false;



  Future<void> init() async {
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
    await _instance.init();
    return _instance;
  }
}
// caller:
// final db = await Database.getInstance();
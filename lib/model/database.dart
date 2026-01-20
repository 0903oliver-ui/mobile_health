part of LukOjeApp;

class Database{
  StoreRef? store;
  var database;

  Database._();
  static final Database _instance = Database._();

  factory Database(){
    return _instance;
  }

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    var path = join(dir.path, 'sleepData.db');
    database = await databaseFactoryIo.openDatabase(path);
    store = intMapStoreFactory.store('sleep_data_store');
  }
}
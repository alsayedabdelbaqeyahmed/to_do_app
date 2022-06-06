import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/model/constants/constants.dart';
import 'package:to_do_app/model/database/tasks_model.dart';

class LocalDataBase {
  LocalDataBase._();

  static LocalDataBase db = LocalDataBase._();

  static Database? _database;

  Future<Database>? get dataBase async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'userPhoneNumber.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE $tableName(id INTEGER PRIMARY KEY, $name TEXT, $desc TEXT, $categ TEXT , $condate TEXT , $contime TEXT)');
      },
    );
  }

  Future<int> insertData(TaskModel data) async {
    try {
      var _db = await dataBase;

      return await _db!.insert(tableName, data.toJason());
    } catch (e) {
      // print(e.toString());
      throw (e);
    }
  }

  Future<int> updateData(TaskModel user) async {
    var _db = await dataBase;
    return _db!.update(tableName, user.toJason(),
        where: 'id = ?', whereArgs: [user.id]);
  }

  // Future<int> updateele(UserDataModel user) async {
  //   var _db = await dataBase;
  //   return _db!.rawUpdate(sql);
  // }

  Future<List<TaskModel>> getUserData() async {
    var _db = await dataBase;
    try {
      List<Map<String, dynamic>> userMap = await _db!.query(tableName);

      List<TaskModel> userData = [];
      userMap.isNotEmpty
          ? userData = userMap.map((e) => TaskModel.fromJason(e)).toList()
          : [];

      return userData;
    } catch (e) {
      throw (e);
    }
  }

  Future<int> deleteAllData() async {
    var _db = await dataBase;
    try {
      return _db!.delete(tableName);
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:xoo/models/users.dart';

class DatabaseHelper {

  static DatabaseHelper _dbhelper; //Singleton DatabaseHelper
  static Database _database; //Sigleton database

  String userTable='user_table';
  String colId='id';
  String colName='name';
  String colUsername='username';
  String colPassword='password';

  //Create instance of the databaseHelper
  DatabaseHelper._createInstance();

  factory DatabaseHelper(){
    if(_dbhelper == null){
      _dbhelper = DatabaseHelper._createInstance(); //this will be execute once
    }
    return _dbhelper;
  }

  Future<Database> initializeDatabase() async {
    //get the directory path for android and ios
    Directory directory=await getApplicationDocumentsDirectory();
    String path = directory.path + 'xoo.db';

    //Open or create the database at a given  path
    var xooDatabase= await openDatabase(path, version :1, onCreate: _createDb);

    return xooDatabase;
  }

   Future<Database> get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }
  //onCreate method
  void _createDb(Database db, int newVersion) async {
		await db.execute('CREATE TABLE $userTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, '
				'$colUsername TEXT, $colPassword INTEGER)');
	}

  //Fetch operation to get all user object in database
  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db=await this.database;

    var result = await db.query(userTable, orderBy : '$colName ASC');
    return result;
  }

  //Insert operation for User : Insert a User Object to database
  Future<int> insertUser(Users user) async {
      Database db=await this.database;
      var result = await db.insert(userTable, user.toMap());
      return result;
  }

  Future<int> updateUser(Users user) async{
    var db =await this.database;
    int result= await db.update(userTable, user.toMap(), where : '$colId=?',whereArgs: [user.id]);
    return result;
  }

  Future<int> deleteUser(int id) async {
      var db=await this.database;
      int result=await db.rawDelete('DELETE FROM $userTable WHERE $colId = $id');
      return result;
  }

// Get number of Note objects in database
  Future<int> getCount() async {
    Database db=await this.database;
    List<Map<String, dynamic>> x =await db.rawQuery('SELECT COUNT(*) from $userTable');
    int result=Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Users List' [ List<Users> ]
Future<List<Users>> getUsersList() async {
  var userMapList = await getUserMapList(); //Get 'Map List' from database
  int count=userMapList.length;  //count the number of map entries in db table

  List<Users> usersList = List<Users>();
  //forloop to create a note list from a map List
  for(int i = 0; i<count; i++){
    usersList.add(Users.fromMapObject(userMapList[i]));
  }
  return usersList;
}

}
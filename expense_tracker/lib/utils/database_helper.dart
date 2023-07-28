import 'package:budget_boss/models/account.dart';
import 'package:budget_boss/models/catagory_list.dart';
import 'package:budget_boss/models/transaction.dart';
import 'package:budget_boss/models/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static Database? _database;
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
   _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'last');
     return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
        '''
CREATE TABLE users(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_name TEXT NOT NULL,
  email TEXT NOT NULL,
  image BLOB,
  password TEXT NOT NULL,
  isLoggedIn INTEGER NOT NULL
)
'''
      );
      await db.execute('''
            CREATE TABLE account(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT NOT NULL,
              amount REAL NOT NULL,
              user_id INTEGER, 
              currency_id INTEGER,
              FOREIGN KEY(user_id) REFERENCES users(id)

            )
''');
      await db.execute('''
CREATE TABLE category(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  icon INTEGER NOT NULL,
  color INTEGER NOT NULL
)
''');
      await db.execute('''
CREATE TABLE transactiontype(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  label TEXT NOT NULL,
  icon INTEGER NOT NULL,
  color INTEGER NOT NULL
)
''');
      await db.execute('''
CREATE TABLE transactions(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  payee TEXT NOT NULL,
  date TEXT NOT NULL,
  amount REAL NOT NULL,
  typeId INTEGER NOT NULL,
  categoryId INTEGER NOT NULL,
  accountId INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY(typeId) REFERENCES transactiontype(id),
  FOREIGN KEY(categoryId) REFERENCES category(id),
  FOREIGN KEY(accountId)  REFERENCES account(id),
  FOREIGN KEY(user_id) REFERENCES users(id)

)
''');
    });
  }

  Future<List<Map<String, dynamic>>> queryAll(String tableName) async{
    Database db = await instance.database;
     print("kk");
    return await db.query(tableName);
  }
 
  Future<int> insertItem(String tableName,Map<String,dynamic> createdObject)async{
    Database db = await instance.database;
    return await db.insert(tableName, createdObject,conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<List<Map<String,dynamic>>> getItem(String tableName, where, whereArg) async{
    Database db = await instance.database;
    var map  = await db.query(
      tableName,
      where:"$where = ?",
      whereArgs: [whereArg]
    );
    return map;

  }

//   Future<int> updateItem(String tableName, values,where,whereArg) async{
//     Database db = await instance.database;
//     return  db.update('my_table',
//   {'isLoggedIn': 'values'}, where: where, whereArgs:[whereArg],
// );
//   }// Open the database


// Update the value of the column where id is 1


  // Future<void> testdb() async {
  //   print("hello");
  //   Database db = await instance.database;
  //   db.
  //  await db.insertItem("account",Account(amount: 200).toMap());
  //  await db.insertItem("category", Category(name: "home", icon:Icons.home, color: Colors.white).toMap());
  //  await db.insertItem("transactiontype",TransactionType(label: "Expense", icon: Icons.arrow_back_ios, color: Colors.teal).toMap());
  //  await db.insertItem("transactions",CreatedTransaction(payee: "food", typeId: 1, date: DateTime.now(), amount: 200, categoryId: 1, accountId: 1).toMap());
  // var lists = await db.queryAll();
  // print(lists[0].toString());
  // }


}

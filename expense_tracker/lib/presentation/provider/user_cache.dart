import 'package:budget_boss/models/user.dart';
import 'package:budget_boss/utils/database_helper.dart';
import 'package:flutter/material.dart';

class UserCache extends ChangeNotifier{
  DatabaseHelper helper = DatabaseHelper.instance;
  User? user;
  bool? isUser;
  bool? isLoggedIn;
  void registerUser(userName,email,password) async{
      await helper.insertItem("users", User(user_name: userName, password: password, email: email).toMap());
  }


  Future<bool> getUser(userName,password) async{
    
    var result = await helper.database;
    List filteredUser = await result.query("users",where: "user_name = ? AND password = ?" ,whereArgs: ["$userName","$password"]);
    if(filteredUser.isNotEmpty){
       
       user = User.fromMap(filteredUser[0]);
      
     await result.update("users", {"isLoggedIn" : 1},where: "id = ?",whereArgs: [user?.id]);
     var u = await result.query("users",where: "id = ?",whereArgs: [user?.id]);
      print(User.fromMap(u[0]).isLoggedIn);
       return true; 
    }else{
      return false;
    }

  
  
  }
   Future getLoggedIn() async{
    var db = await helper.database;
    var v = await db.query("users",where: "isLoggedIn = ?", whereArgs: [1]);
    user = User.fromMap(v[0]);
    return user;
   }
   logOUt() async{
     var db = await helper.database;
     await db.update("users", {"isLoggedIn" : 0},where: "id = ?",whereArgs: [user?.id]);

   }
  
}
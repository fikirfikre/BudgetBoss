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
   Future getLoggedIn(userId) async{
    // var db = await helper.database;
    int id =await userId;
    var use = await helper.getItem("users", "id", id);
    // var v = await db.query("users",where: "isLoggedIn = ?", whereArgs: [1]);
    user = User.fromMap(use[0]);
    
    return [user,id];
   }
   logOUt() async{
     var db = await helper.database;
     await db.update("users", {"isLoggedIn" : 0},where: "id = ?",whereArgs: [user?.id]);

   }
  
}
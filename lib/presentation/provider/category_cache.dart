
import 'package:budget_boss/utils/database_helper.dart';
import 'package:flutter/material.dart';

import '../../models/catagory_list.dart';

class CatagoryCache extends ChangeNotifier{
  DatabaseHelper helper = DatabaseHelper.instance;
  var listOfCategory = [];
  Category? selectedCategory;
  List<Category> catagory =[
    Category(id:1,name: "Bank", icon: Icons.house, color: Colors.blue),
    Category(id:2,name: "Cash", icon: Icons.money_sharp , color: Colors.green),
    Category(id:3,name: "Automobile", icon: Icons.car_repair, color: Colors.green)
  ];

  Future insertCatagory() async{
    await helper.insertItem("category",  Category(name: "Bank", icon: Icons.house, color: Colors.blue).toMap());
    await helper.insertItem("category", Category(name: "Cash", icon: Icons.money_sharp , color: Colors.green).toMap());
    await helper.insertItem("category", Category(name: "Automobile", icon: Icons.car_repair, color: Colors.green).toMap());
  }
  Future getCatagory() async{
    //  / await insertCatagory();
    var lists = await helper.queryAll("category");
    listOfCategory = lists;
    notifyListeners();
    return lists;
  }

  Future<Category> getItem(id) async{
    var itemList = await helper.getItem("category", "id", id);
    var item = Category.empty().fromMap(itemList[0]);
    selectedCategory = item;

    notifyListeners();
    return item;
  }
}
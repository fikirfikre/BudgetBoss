import 'package:budget_boss/models/transaction_type.dart';
import 'package:budget_boss/utils/database_helper.dart';
import 'package:flutter/material.dart';

class TypeCache extends ChangeNotifier{
  DatabaseHelper helper = DatabaseHelper.instance;
  // final List _types =[
  //   TransactionType(id: 1,label: "Income",icon: Icons.home,color: Colors.cyan,),
  //   TransactionType(id:2,label: "Expense",icon:Icons.arrow_forward_ios,color:Colors.teal)
  // ];
  Future<void> insetType() async{
      await helper.insertItem("transactionType", TransactionType(label: "Income",icon: Icons.arrow_back_ios,color: Colors.cyan,).toMap());
      await helper.insertItem("transactionType",TransactionType(label: "Expense",icon:Icons.arrow_forward_ios,color:Colors.teal).toMap());

  }
  int selectedPage = 0;
  int index = 0;
  // get types => _types;
  TransactionType? selected;
  List values = [10,5,3,2,1.5,1];
  
   Future<TransactionType> getSelected(int id) async{
  var map = await helper.getItem("transactionType", "id", id);
  return TransactionType.empty().fromMap(map[0]);
  }

  Future<void> isSelected(index) async{
    // selected = _types[index];
    selected = await getSelected(index);
    print("00000");
    print(selected?.label);
    notifyListeners();
  }

  void setPage(){
    selectedPage++;
    index++;
    notifyListeners();
  }

  Future getType() async{
      //  await  insetType();
    var type = helper.queryAll("transactionType");
   
    print(type.toString());
    return await type;
  }
}
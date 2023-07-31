import 'package:budget_boss/models/account.dart';
import 'package:budget_boss/presentation/provider/user_cache.dart';
import 'package:budget_boss/utils/database_helper.dart';
import 'package:flutter/widgets.dart';

class AccountCache extends ChangeNotifier{
 late Account _accountValue;
 late Account selectedAccount = listOfAccount.first;

 late double amount;
 bool? isEnough;
int id = 0;
 var listOfAccount= Set<Account>();
 DatabaseHelper helper = DatabaseHelper.instance;

 void account(String value, id){
  amount = double.parse(value);
  id  = id;
  // createAccount();
  
 }
 Future<void> selectAccount(account) async{
  print(account);
  selectedAccount =account;
  // var accounts_list = await helper.queryAll("accounts");
  // accounts_list.forEach((item){
  //   listOfAccount.add(Account.empty().fromMap(item));
  // });
  // selectedAccount = Account.empty().fromMap(accounts.first);
  notifyListeners();
  
 }
 Future<void> createAccount(amount,userId,currencyId) async{
  var value = await helper.insertItem("account", Account(amount:double.parse(amount),userId: userId,currencyId:currencyId ).toMap());
   var accountsList = await helper.queryAll("account");
  accountsList.forEach((item){
    listOfAccount.add(Account.empty().fromMap(item));
  });

  // listOfAccount.add(accountValue);
 }
 Future<void> getAccounts(userId) async{
   var  result = await helper.database;
    var accountsList = await result.query("account",where: "user_id = ?",whereArgs: [userId]);

    accountsList.forEach((item){
      print(item);
    listOfAccount.add(Account.empty().fromMap(item));
  });

 }
 Future<void> updateAccount(am,typeId) async{
  print(am);
  var db = await helper.database;
    //  double input = int.parse(am);
    double amount = selectedAccount.amount;
     if(typeId == 1){
      amount = amount + am ;
     }else{
      amount = amount - am;

     }
     print(amount);
     
      await helper.updateItem("account", "amount", amount, "id", selectedAccount.id);
      listOfAccount.remove(selectedAccount);
      selectedAccount.amount = amount;
      listOfAccount.add(selectedAccount);
     

      // await db.update("account", {"amount" : amount},where: )
 }

  Future getAccount(userId) async{
  var value = await helper.getItem("account", "user_id", userId);
  if (value.isEmpty){
    return false;
  }
  else{
   var values = Account.empty().fromMap(value[0]);
    return true;
  }

 }
 
 get accountValue => _accountValue;
}
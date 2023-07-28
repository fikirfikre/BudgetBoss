import 'package:budget_boss/models/account.dart';
import 'package:budget_boss/presentation/provider/user_cache.dart';
import 'package:budget_boss/utils/database_helper.dart';
import 'package:flutter/widgets.dart';

class AccountCache extends ChangeNotifier{
 late Account _accountValue;
 late Account selectedAccount = listOfAccount.first;

 late double amount;
int id = 0;
 List<Account> listOfAccount=[];
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
 
 get accountValue => _accountValue;
}
import 'package:budget_boss/models/account.dart';
import 'package:budget_boss/models/transaction_type.dart';
import 'package:budget_boss/presentation/provider/type_cache.dart';
import 'package:budget_boss/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/catagory_list.dart';
import '../../models/transaction.dart';

class TransactionCache extends ChangeNotifier {
  DatabaseHelper helper = DatabaseHelper.instance;
  TypeCache typecache = TypeCache();
  List<CreatedTransaction>? transactions;
  Category? selectedCategory;
  String? payee;
  DateTime date = DateTime.now();
  double? amount;
  int? userId;
  Category? catagory;
  Account? account;
  DateTime _selectedDay = DateTime.now();
  late TransactionType transactionType;

  void addType(value) {
    print(value);
    transactionType = value;
    notifyListeners();
  }

  void selectDate(date) {
    _selectedDay = date;
    notifyListeners();
  }
  get selectedDate => _selectedDay;

  void addName(value) {
    payee = value;
    print(payee);
    notifyListeners();
  }

  // get payee => _payee;
  void addDate(value) {
    final formatter = DateFormat('yyyy-MM-dd');
    date = DateTime(value.year, value.month, value.day);
    print(date);
    notifyListeners();
  }

  void addAmount(value) {
    amount = double.parse(value);
    notifyListeners();
  }

  void addCatagory(value) {
    catagory = value;
    notifyListeners();
  }

  void addAccount(value) {
    account = value;
    notifyListeners();
  }

  get typeId => transactionType?.id;
  get accountId => account?.id;
  get catagoryId => catagory?.id;
  void addTransaction(userId) async {
    final formatter = DateFormat('yyyy-MM-dd');
    date = DateTime(date.year, date.month, date.day);
    
      await helper.insertItem(
          "transactions",
          CreatedTransaction(
                  payee: payee!,
                  typeId: typeId,
                  date: date,
                  amount: amount!,
                  categoryId: catagoryId,
                  accountId: accountId,
                  userId: userId)
              .toMap());
              // selectDate(date);
              userId = userId;
   notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getTransaction(date,userId) async {
    final formatter = DateFormat('yyyy-MM-dd');
    date = formatter.format(date);
    var  result = await helper.database;
    var transactions = await result.query("transactions",where: "user_id = ? AND date = ?",whereArgs: [userId,date]);
    var transaction = await helper.getItem("transactions", "date", "$date");
    
    return transactions;
  }

  get listOfTransaction => transactions;
}

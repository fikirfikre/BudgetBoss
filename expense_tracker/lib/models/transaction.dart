import 'package:budget_boss/models/account.dart';
import 'package:budget_boss/models/catagory_list.dart';
import 'package:budget_boss/models/transaction_type.dart';
import 'package:intl/intl.dart';

class CreatedTransaction {
  int? id;
  String payee;
  DateTime date;
  double amount;
  int typeId;
  int categoryId;
  int accountId;
  int userId;
  CreatedTransaction.empty()
      : id = 1,
        payee = "",
        typeId = 1,
        date = DateTime.now(),
        amount = 1,
        categoryId = 1,
        accountId = 1,
        userId = 1;
  CreatedTransaction(
      {this.id,
      required this.payee,
      required this.typeId,
      required this.date,
      required this.amount,
      required this.categoryId,
      required this.accountId,
      required this.userId});

  Map<String, dynamic> toMap() {

    return {
      'id': id,
      'payee': payee,
      'date': DateFormat('yyyy-MM-dd').format(date),
      'amount': amount,
      'typeId': typeId,
      'categoryId': categoryId,
      'accountId': accountId,
      'user_id': userId
    };
  }

  CreatedTransaction fromMap(Map<String, dynamic> map) {
    return CreatedTransaction(
        id: map['id'],
        payee: map['payee'],
        typeId: map['typeId'],
        date: DateTime.parse(map['date']),
        amount: map['amount'],
        categoryId: map['categoryId'],
        accountId: map['accountId'],
        userId: map['user_id']);
  }
}

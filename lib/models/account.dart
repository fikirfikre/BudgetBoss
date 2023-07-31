import 'package:budget_boss/models/currency.dart';

class Account {
   int? id;
   String title;
   double amount;
   int userId; 
   int currencyId;
   Account.empty(): id=2, title="", amount = 200,userId=1,currencyId=9;
  Account({ this.id, this.title = "cash", required this.amount,required this.userId,required this.currencyId});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'title': title,
      'amount': amount,
      'user_id':userId,
      'currency_id':currencyId
    };
  }

  Account fromMap(Map<String, dynamic> map) {
    return Account(id: map['id'], amount: map['amount'], title: map['title'], userId: map['user_id'],currencyId: map['currency_id']);
  }
}

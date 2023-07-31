// import 'package:budget_boss/presentation/provider/calender_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:table_calendar/table_calendar.dart';

// class DailyTransaction extends StatefulWidget {
//    DailyTransaction({super.key});

//   set payee(String? payee) {}

//   @override
//   State<DailyTransaction> createState() => _DailyTransactionState();
// }

// class _DailyTransactionState extends State<DailyTransaction> {
//   // CalendarController _controller = CalendarController();
//    CalendarFormat _calendarFormat = CalendarFormat.week;
//    DateTime _selectedDay = DateTime.now();
//    DateTime _focusedDay = DateTime.now();
//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<CalendarProvider>(context);
//     return Column(
//       children: [
//         Container(
         
//         //s  height: provider.isWeek? MediaQuery.of(context).size.height/2:MediaQuery.of(context).size.height/4,
//           decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.vertical(bottom: Radius.circular(50))),
                    
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const[
//                   Text("Daily transaction"),
//                   Icon(Icons.search)
//                 ],
        
//               ),
//               SingleChildScrollView(
//                 child: Column(
//                   children: [
//                    Padding(
                  
                   
//                     padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    
//                      child: TableCalendar(
//                       onDaySelected: (selectedDay,focusedDay){
//                         print(_focusedDay);
//                         setState(() {
//                            _selectedDay = selectedDay;
//                            _focusedDay = focusedDay;
//                         });
//                       },
//                       onPageChanged: (focusedDay){
//                         setState(() {
//                           _focusedDay = focusedDay;
//                         });
                        
//                       },
//                       onFormatChanged: (format) {
//                            provider.changeWeek();
//                            setState(() {
//                             format = _calendarFormat;
//                             if(_calendarFormat != CalendarFormat.week)
//                             {
//                              _calendarFormat = CalendarFormat.week;
//                             }else{
//                               _calendarFormat = CalendarFormat.month;
//                             }
                            
//                            });
//                       },
//                       calendarFormat: _calendarFormat,
//                       headerStyle:const HeaderStyle(
//                         formatButtonShowsNext: false
//                       ),
                     
//                       firstDay: DateTime.utc(2010, 10, 16),
//                        lastDay: DateTime.utc(2030, 3, 14),

//                        calendarBuilders: CalendarBuilders(
                      
//                         selectedBuilder:(context,date,event){
//                           print("ok");
//                           return Container(
//                             margin : EdgeInsets.all(4),
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10)
//                             ),
//                             child: Text("$date.day"),
                            
//                           );
//                         }
//                        ), focusedDay: _focusedDay,
//                      )
//                         // focusedDay: _focusedDay,),
                        
//                    )
        
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//         Expanded(child: ListView.builder(
//           itemCount: 10,
//           itemBuilder: (context,index){
//             return Container(
//               padding: const EdgeInsets.all(8.0),
//               child: Text("$index"),
//             );
//           }))
//       ],
//     );
// }
// }


import 'package:budget_boss/models/transaction.dart';
import 'package:budget_boss/presentation/provider/account_cache.dart';
import 'package:budget_boss/presentation/provider/currency_provider.dart';
import 'package:budget_boss/presentation/provider/transaction_cache.dart';
import 'package:budget_boss/presentation/provider/user_cache.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/account.dart';
import '../../models/catagory_list.dart';
import '../provider/category_cache.dart';

class DailyTransaction extends StatefulWidget {
  @override
  _DailyTransactionState createState() => _DailyTransactionState();
}

class _DailyTransactionState extends State<DailyTransaction> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  // DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Future <List<Map<String,dynamic>>>? _transaction;
  TransactionCache cache = TransactionCache();
  @override
  void initState() {
 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   var transactionCache = Provider.of<TransactionCache>(context);
   var selectedDay = transactionCache.selectedDate;
    var catagoryCache = Provider.of<CatagoryCache>(context,listen: false);
    var currencies = Provider.of<CurrencyProvider>(context,listen: false);
    var account = Provider.of<AccountCache>(context,listen: false);
    var user = Provider.of<UserCache>(context,listen: false);
    
    return Scaffold(
      body: Column(
        children: [
                        const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Daily transaction"),
                  Icon(Icons.search)
                ],
        
              ),
          TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(selectedDay, day);
            },
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, date, events) => Container(
                margin: const EdgeInsets.all(7.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Text(
                  '${date.day}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            onDaySelected: (selectedDay, focusedDay) async{
               transactionCache.selectDate(selectedDay);
              setState(() {
                // selectedDay = selectedDay;
                _focusedDay = focusedDay;
                
              });
              
            
              
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            }, focusedDay: _focusedDay, 
          ),
          Expanded(child:
        
              
               
             FutureBuilder(
               future: transactionCache.getTransaction(selectedDay,user.user?.id),
               builder: (context, snapshot){
                 if(snapshot.connectionState == ConnectionState.done){
                        var  lists = snapshot.data;
                 return ListView.builder(
                      itemCount: lists?.length,
                      itemBuilder: (context,index){
                        
                        var transaction = CreatedTransaction.empty().fromMap(lists![index]);
                        var date = DateFormat('yyyy-MM-dd').format(transaction.date);
                        print(account.listOfAccount);
                        Account selected =   account.listOfAccount.firstWhere((element) => element.id == transaction.accountId);
                        int id = selected.id ?? 0;
                         id = id -1;
                        var currency = currencies.allCurrency[id].symbol;
                        var amount = transaction.amount;
                        return FutureBuilder<Category>(
                          future: catagoryCache.getItem(transaction.categoryId),
                          builder: (context, snapshot) {
                            if(snapshot.connectionState == ConnectionState.done){
                              Category? category = snapshot.data;
                              return ListTile(
                                  title: Text(transaction.payee),
                                  leading: Icon(category?.icon,color:category?.color),
                                  subtitle: Text(date),
                                  trailing:Text("$currency $amount") ,
                              );

                            }else{
                              return Container();
                            }
                          }
                        );
                      });
               }else{
                return CircularProgressIndicator();
               }
               }
             )
              
            
          
           )
           ]
           )
    );
            }
          
          

  }

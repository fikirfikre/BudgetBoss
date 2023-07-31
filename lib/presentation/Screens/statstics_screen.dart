import 'package:budget_boss/models/transaction.dart';
import 'package:budget_boss/presentation/provider/account_cache.dart';
import 'package:budget_boss/presentation/provider/currency_provider.dart';
import 'package:budget_boss/presentation/provider/transaction_cache.dart';
import 'package:budget_boss/presentation/provider/user_cache.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'add_transaction_screen.dart';

class Statstics extends StatelessWidget {
  const Statstics({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Container(
          padding: EdgeInsets.only(bottom: 20),
          // color: Colors.white,
          child: DateListWidget()),
      ],
    );
  }
}



class DateListWidget extends StatefulWidget {
  const DateListWidget({Key? key}) : super(key: key);

  @override
  _DateListWidgetState createState() => _DateListWidgetState();
}

class _DateListWidgetState extends State<DateListWidget> {
final  int _selectedYear = DateTime.now().year;

  int selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;
  bool isExpense = true;
  bool isIncome = false;
  double value = 0.0;
  List<bool> isSelected = List.generate(12, (index) => true);
 
  @override
  Widget build(BuildContext context) {
   var transactionCache = Provider.of<TransactionCache>(context,listen: false);
   var userCache = Provider.of<UserCache>(context,listen: false);
   var accountCache = Provider.of<AccountCache>(context,listen: false);
   var currencies =CurrencyProvider();
 print(isSelected);
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
               Container(
                color: isExpense ? Color.fromARGB(103, 21, 120, 97) : Color.fromARGB(0, 255, 255, 255),
                 child: TextButton(onPressed: (){
                     setState(() {
                    isExpense =true;
                    isIncome = false;
                  });
                  print(isExpense);
                 },
                 
                  child:Container(
                    
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width/2.5,
                    child:  Text("Expense",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                             ),),
                  )),
               ),
              Container(
                color: isIncome ? Color.fromARGB(103, 21, 120, 97) : Color.fromARGB(0, 255, 255, 255),
                child: TextButton(onPressed: (){
                  setState(() {
                    isExpense =false;
                    isIncome = true;
                  });
                  print(isExpense);
                },
                
                  child:Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width/2.5,
                    child: const Text("Income",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                             ),),
                  )),
              ),
              ],),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(

                children: [
                  for(int year = _selectedYear ; year <= _selectedYear+3; year++)
                  for (int i = 0; i < 12; i++)
                    Container(
                      width: 50, // adjust the width as per your requirement
                       margin: EdgeInsets.all(8), // add some margin between each date container
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Text(
                            year.toString(),
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ), 
                          TextButton(
                            onPressed: (){
                             
                              
                              setState(() {
                                selectedYear = year;
                                _selectedMonth = i+1;
                                for(int i = 0; i <isSelected.length;i++){
                                           isSelected[i] = true;
                                }
                                 isSelected[i] = !isSelected[i];
                              });
                              print(isSelected[i]);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 10),
                              // padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              width: 80,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:isSelected[i] == true? Colors.grey.shade200:Colors.teal,
                              ),
                              child: Text(
                                DateFormat('MMM').format(DateTime(_selectedYear, i + 1)),
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,
                                 color:isSelected[i] == true? Colors.teal:Colors.white,),
                              ),
                            ),
                          ), // This will display the day name (e.g. Mon, Tue, Wed) for each date
                        // This will display the date (e.g. 01/08/2023) for each date
                        ],
                      ),
                    ),
                ],
              ),
            ),
           
        
          ],
        ),
            Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          
          width: double.infinity,
         
          child: FutureBuilder(
            future:transactionCache.getMonthTransaction(selectedYear,_selectedMonth, userCache.user?.id,isExpense? 2 : 1) ,
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.data!.isNotEmpty){
                  print(snapshot.data);
                  int length = snapshot.data!.length;
                  double total = 0;
                   List<PieChartSectionData> pieChartSectionData = [];
                     String symbol = "";
                   
                  for (var i  = 0; i<length;i++){
                    var data =  CreatedTransaction.empty().fromMap(snapshot.data![i]).amount;
                     total = total + data;
                  }
              
                  for(var i = 0; i<length;i++){
                    var data =  CreatedTransaction.empty().fromMap(snapshot.data![i]);
                     var value = (data.amount / total) * 100;
                      if(accountCache.listOfAccount.first.id == data.accountId){
                      print("ok");
                       symbol = currencies.allCurrency[accountCache.listOfAccount.first.currencyId - 1].symbol;
                    }
                    //  accountCache.getAccount(userId)
                  
                     String title = "";
                     
                     if(value > 8){
                      if(data.payee.length > 4){
                        title = '${data.payee.substring(0,4)}..';
                        print(title);
                      }else{
                        title = data.payee;
                      }
                     }
                    pieChartSectionData.add(
                      PieChartSectionData(
                        // showTitle: false,
                        value: value,
                        title: title,
                      
                        titleStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                        ),
                        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0) 
                      )
                    );
                  }

                  return   Column(
                      children: [
                        Container(
                        
                           height: 200,
                           decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadius.circular(20)
                           ),
                          //  padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          child: PieChart(
                            PieChartData(
                              sections: pieChartSectionData,
                              sectionsSpace: 0,
                              centerSpaceRadius: 30,
                           
                            ),
                          
                                         ),
                        ),
                        SizedBox(height: 30,),
                  
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Box(
                          label:"Income",
                          icon: Icons.arrow_back_ios,
                          color: Colors.cyan,
                          value: isIncome? "$symbol $total" : "$symbol 0.0",
                    ),
                    
                            Box(
                          label:"Expense",
                          icon: Icons.arrow_forward_ios,
                          color: Colors.teal,
                          value: isExpense? "$symbol $total" : "$symbol 0.0",
                    )
                            ],
                          )
                      ],
                    
                  );
                }else{
                  return const Center(
                    child: Text(
                      "You do not have any Transaction",
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        
                      ),
                    ),
                  );
                }
              }else{
                return CircularProgressIndicator();
              }
          })
        ),
     
      ],
    );
  }
}

class Box extends StatelessWidget {
  Box(
      {super.key,
      required this.label,
      required this.icon,
      required this.color,
      required this.value});
  String label;
  IconData icon;
  Color color;
  String value;
  
  @override
  Widget build(BuildContext context) {
    print(icon);
    return Container(
      padding: const EdgeInsets.all(10),
      height: 120,
      width: MediaQuery.of(context).size.width / 2.5,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // padding: EdgeInsets.only(left: 10),
                alignment: Alignment.center,
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: color),

                child: Icon(icon,color: Colors.white,),
              ),
              Text(value,style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal
              ),)
            ],
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}



import 'dart:math';

import 'package:budget_boss/models/transaction_type.dart';
import 'package:budget_boss/presentation/provider/account_cache.dart';
import 'package:budget_boss/presentation/provider/category_cache.dart';
import 'package:budget_boss/presentation/provider/currency_provider.dart';
import 'package:budget_boss/presentation/provider/transaction_cache.dart';
import 'package:budget_boss/presentation/provider/type_cache.dart';
import 'package:budget_boss/presentation/provider/user_cache.dart';
import 'package:budget_boss/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/account.dart';
import '../../models/catagory_list.dart';

class AddTransaction extends StatelessWidget {
  const AddTransaction({super.key});
  
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TypeCache>(context);
  
    List pages = [   
      const ChoosePage(),
      EnterPayee(),
     const SelectCatagory(),
      const EnterAmount(),
      SelectDate(),
     const LastPage()
    ];
    print(10 - provider.selectedPage*2);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: PreferredSize(
          
            preferredSize:const Size.fromHeight(5),
            child: Row(
              children: [
                Container(
                  color: Colors.white,
                  height: 3,
                  width: MediaQuery.of(context).size.width/provider.values[provider.index],
                ),
              ],
            )),
        //bottomOpacity: 0,
       // shadowColor: Colors.grey.shade100,
        backgroundColor: Theme.of(context).primaryColor,
        leading:  IconButton(
          onPressed: (){
            Navigator.pop(context);
            provider.selectedPage = 0;
            provider.index = 0;
          },
        icon:const Icon( Icons.close),
          color: Colors.white,
        ),
        title: provider.selectedPage == pages.length-1? const Text(""):const Text(
          "Add transaction",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: pages[provider.selectedPage],
    );
  }
}

class ChoosePage extends StatelessWidget {
  const ChoosePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TypeCache>(context);
    var transactionCache = Provider.of<TransactionCache>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 30, 0),
            child: Image.asset("assets/on33.png", height: 250,),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 30),
              width: MediaQuery.of(context).size.width / 2.5,
              child: const Text(
                "What kind of transaction it is?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          FutureBuilder(
            future: provider.getType(),
            builder: (context, AsyncSnapshot snapshot) {
              print("hhhh");
              print(snapshot.hasData);
              if(snapshot.hasData){
               var data = snapshot.data;
                var income = TransactionType.empty().fromMap(data[0]);
                var expense = TransactionType.empty().fromMap(data[1]);
                  
                // print(expense.icon.toString());
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      // print(income.id.toString());
                      provider.isSelected(income.id);
                      // print(provider.selected?.label);
                      print(provider.selected);
                      transactionCache.addType(income);
                      provider.setPage();
                    },
                    child: TypeBox(
                      label:income.label ,
                      icon: income.icon,
                      color:income.color,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      print(expense.id.toString());
                      provider.isSelected(expense.id);
                      transactionCache.addType(expense);
                      provider.setPage();
                    },
                    child: TypeBox(
                        label:expense.label,
                        icon: expense.icon,
                        color: expense.color
                  )
                  )
                ],
              );
              
            }else{
              // print(snapshot.data);
              return CircularProgressIndicator();
            }
            }
          )
        ],
      ),
    );
  }
}


class EnterPayee extends StatelessWidget {
   EnterPayee({super.key});
  final TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var transactionCache = Provider.of<TransactionCache>(context);
    var provider = Provider.of<TypeCache>(context);
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TransactionWidget(provider: provider),
      const SizedBox(height: 100),

      Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Payee name"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/1.5,
                    height: 50,
                    child:  TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Enter payee name"
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
           
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 31, 19, 70)
              ),
                  child: IconButton(
                    onPressed: (){
                      if(_controller.text == ""){
                                showDialog(context:context , 
                          builder: (BuildContext context){
                            return const AlertDialog(
                              title: Text("Payee Field can not be empty"),
                              content:  Text("please input payee name"),
                    
                            );          
                          }
                          );
                      }else{
                      provider.setPage();
                      transactionCache.addName(_controller.text);
                      }
                    },
                   icon: const Icon(Icons.arrow_forward_ios,color: Colors.white,),),
                )
          ],
         ),
      ),
     
    ],
      ),
    );
  }
}



class SelectCatagory extends StatelessWidget {
  const SelectCatagory({super.key});

  @override
  Widget build(BuildContext context) {
     var catagory = CatagoryCache();
     var transactionCache = Provider.of<TransactionCache>(context);
     var provider = Provider.of<TypeCache>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TransactionWidget(provider: provider),
          const SizedBox(
            height: 40,
          ),
          PayeeWidget(transactionCache: transactionCache),
  
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const  Padding(
                      padding:  EdgeInsets.only(bottom: 10),
                      child:   Text("Choose category",style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800
                      ),),
                    ),
                          FutureBuilder(
                            future: catagory.getCatagory(),
                            builder: (context, AsyncSnapshot snapshot) {

                              if (snapshot.hasData){
                                var data = snapshot.data;
                       
                              return SizedBox(
                                            height: 200,
                                            child: 
                                           ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: data.length,
                                            itemBuilder: (_,index){
                                              var specific = Category.empty().fromMap(data[index]);
                                              return GestureDetector(
                                                onTap:(){
                                                  
                                                  transactionCache.addCatagory(specific);
                                                  provider.setPage();
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(15.0),
                                                  child: CategoryWidget(label: specific.name, icon: specific.icon, color: specific.color),
                                                ),
                                              );
                                            }));
                              }
                              else{
                                return CircularProgressIndicator();
                              }
                            }
                          )
                       
                ],
              ),
            ),

         

        ],
      ),
    );
  }
}

class PayeeWidget extends StatelessWidget {
  const PayeeWidget({
    super.key,
    required this.transactionCache,
  });

  final TransactionCache transactionCache;

  @override
  Widget build(BuildContext context) {
    return Row(
    children: [
    Container(
      // padding: EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey.shade300),
    
      child: const Icon(null, color: Colors.white,),
    ),
    const SizedBox(
      width: 10,
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       const Text("Payee",style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold
        ),),
        Text(transactionCache.payee!,style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20
        ),),
       
      
      ],
    )
    ],
    );
  }
}


class PayeeAfterCatagory extends StatelessWidget {
  const PayeeAfterCatagory({
    super.key,
    required this.transactionCache,
  });

  final TransactionCache transactionCache;

  @override
  Widget build(BuildContext context) {
    String? payee = transactionCache.payee;
    return Row(
    children: [
    Container(
      // padding: EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey.shade300),
    
      child:  Icon(transactionCache.catagory?.icon, color: transactionCache.catagory?.color,),
    ),
    const SizedBox(
      width: 10,
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       const Text("Payee",style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold
        ),), 
        Text(payee ?? "",style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20
        ),),
       
      
      ],
    )
    ],
    );
  }
}
class EnterAmount extends StatelessWidget {
  const EnterAmount({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TypeCache>(context);
    var transactionCache = Provider.of<TransactionCache>(context);
    var accountCache = Provider.of<AccountCache>(context);
    TextEditingController controller = TextEditingController();
    
    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TransactionWidget(provider: provider),
          const SizedBox(height: 30,),
          PayeeAfterCatagory(transactionCache: transactionCache),
          // const SizedBox(height: 80,),
          Expanded(
            child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
          
                  children: [
          
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Choose an Account",style: 
                        TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),),
                      const  SizedBox(height: 20,),
                        SizedBox(
                          
                          width: 150,
                          child: DropdownButton<Account>(
                            underline: Container(
                              width: 150,
                              height: 3,
                              color: Theme.of(context).primaryColor,
                            ),
                            focusNode: FocusNode(descendantsAreFocusable: false),
                            autofocus: false,
                            value:accountCache.selectedAccount,
                            onChanged: (Account? value){
                              print(value?.id);
                                      accountCache.selectAccount(value);
                              print(accountCache.listOfAccount.toString());
                            },
                            items: accountCache.listOfAccount.map<DropdownMenuItem<Account>>((Account account){
                              return DropdownMenuItem(
                                
                                value:account,
                                child: Container(
                                   padding: const EdgeInsets.only(left: 40),
                                  child: Text("${account.currencyId}",style:const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  ),),
                                ));
                        
                            },
                            ).toList(),
                            ),
                        )
          
                      ],
                    ),
          
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         const Text("Enter Amount",style: 
                        TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        )),
                      const    SizedBox(height: 10,),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: controller,
                          ))
                      ],
                    )
                  ],
                ),
                 Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).primaryColor,
              ),
              // margin:const EdgeInsets.only(top: 100),
              
              child: TextButton(
                onPressed: (){
                  //print(int.parse(_controller.text).runtimeType );
                  if(controller.text == ""){
                    
                         showDialog(context:context , 
                        builder: (BuildContext context){
                          return const AlertDialog(
                            title: Text("Amount Field can not be empty"),
                            content:  Text("please input amount"),
                  
                          );          
                        }
                  
                        );
                  }
                  // else if(int.parse(_controller.text).runtimeType == int){
                  //             print(int.parse(_controller.text).runtimeType );
                  // }
                  else{
                    try{
                     transactionCache.addAmount(controller.text);
                     transactionCache.addAccount(accountCache.selectedAccount);
                     provider.setPage();
                    }catch(e){
                              showDialog(context:context , 
                        builder: (BuildContext context){
                          return const AlertDialog(
                            title: Text("Amount Field can not be empty"),
                            content:  Text("please input amount"),
                  
                          );          
                        }
                  
                        );
                    }
                     
                  }
                },
                child:const Text("Next",style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),)),
            )
              ],
              
            ),
          ),

         
        ],
      ),
    );
  }
}
class SelectDate extends StatelessWidget {
   SelectDate({super.key});
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserCache>(context,listen: false);
    var provider = Provider.of<TypeCache>(context);
    var transactionCache = Provider.of<TransactionCache>(context);
    var currencyCache = Provider.of<CurrencyProvider>(context);
    var accountCache = Provider.of<AccountCache>(context);
    int? id = accountCache.selectedAccount.id;
    var symbol = currencyCache.allCurrency[id ?? 1];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 50, 40, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TransactionWidget(provider: provider),
                     Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const Text("Amount",style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold
                ),),
                Text("${symbol.symbol}${transactionCache.amount}",style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),)
              ],
            )
              ],
            ),
            const SizedBox(height: 20,),
            PayeeAfterCatagory(transactionCache: transactionCache),
             const SizedBox(height: 100,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Date"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          
                          child: IconButton(onPressed: (){
                              showDatePicker(context: context, 
                              initialDate:DateTime.now() , 
                              firstDate: DateTime(2000), 
                              lastDate: DateTime(2030)).then((value){
                                   _dateTime =value!;
                                   transactionCache.addDate(value);     
                              });
                          }, 
                          icon:Icon(Icons.date_range,color: Theme.of(context).primaryColor,)),
                        ),
                        Text(DateFormat('EEEE,d MMM, yyyy',).format(transactionCache.date))
                      ]
                    ),
                    GestureDetector(
                      onTap: () async{
                        provider.setPage();
                        transactionCache.addTransaction(user.user?.id);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20)
                        ),
                       child: const Text("Finish",style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    
                                  ),
                                  textAlign: TextAlign.center,)),
                    ),
                    
                    
                  ],
                )
              ],
            
            )
          ],
        ),
      ),
    );
  }
}
class LastPage extends StatelessWidget {
  const LastPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    var transactionCache = Provider.of<TransactionCache>(context);
    var transactionType =Provider.of<TypeCache>(context);
    var currencyCache = Provider.of<CurrencyProvider>(context);
    return 
    Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
       // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/congra.png",width: 200,height: 120,),
        const  SizedBox(height: 30,),
        const  Text("Congratulation!",style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900
          ),),
          const SizedBox(height: 15,),
          SizedBox(
        
            width: 250,
            child: Text(" Your transaction is added successfully to the app",textAlign: TextAlign.center,style: TextStyle(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.bold
            ),)),
            const SizedBox(height: 40,),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40)
              ),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 30),
                       child: SimpleCard(title: "Payee",label: transactionCache.payee,),
                     ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SimpleCard(title:"Transaction type" , label: transactionType.selected?.label),
                        Container(
                           width: 3,
                           height: 30,
                           color: Colors.grey.shade300,
                        ),
                        SimpleCard(title: "Date", label: transactionCache.date.year)
                      ],
                     ),
                     Container(
                      margin: const EdgeInsets.fromLTRB(30, 0, 20, 0),
                      width: double.infinity,
                      height: 2,
                      color: Colors.grey.shade400,
                     ),

                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(left: 30),
                           child: SimpleCard(title: "Amount", label: 
                           "${currencyCache.currency.symbol}${transactionCache.amount}"),
                         ),

                         Container(
                          alignment: Alignment.center,
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                            border:Border.all(
                              color: Theme.of(context).primaryColor
                            ),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: TextButton(
                            onPressed: (){
                              // Navigator.pushNamed(context, RouteGenerator.editTransaction);
                            },
                            child: Text("Edit",style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                         )
                       ],
                     )

    ],
              )
                
              ),
         ]   )
        ,
      );
    
  }
}

class SimpleCard extends StatelessWidget {
   SimpleCard({
    super.key,
    required this.title,
   required this.label
  });
  String title;
  var label;

  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold
              ),),
              Text("$label",style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),)
            ],
          );
  }
}

class CategoryWidget extends StatelessWidget {
   CategoryWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.color
  });
  String label;
  Color color;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: 180,
      width: MediaQuery.of(context).size.width / 2.5,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // padding: EdgeInsets.only(left: 10),
            alignment: Alignment.center,
            height: 50,
            width: 50,
            decoration: BoxDecoration(
     borderRadius: BorderRadius.circular(20), color: Colors.grey.shade200),

            child: Icon(icon,color:color,size: 30,),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
    required this.provider,
  });

  final TypeCache provider;

  @override
  Widget build(BuildContext context) {
    String? label = provider.selected?.label;
    return Row(
    children: [
          Container(
            // padding: EdgeInsets.only(left: 10),
            alignment: Alignment.center,
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: provider.selected?.color),
    
            child: Icon(provider.selected?.icon, color: Colors.white,),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Text("Transaction type",style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold
              ),),
              Text(label ?? "",style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),)
            ],
          )
    ],
    );
  }
}

class TypeBox extends StatelessWidget {
  TypeBox(
      {super.key,
      required this.label,
      required this.icon,
      required this.color});
  String label;
  IconData icon;
  Color color;
  
  @override
  Widget build(BuildContext context) {
    print(icon);
    return Container(
      padding: const EdgeInsets.all(30),
      height: 150,
      width: MediaQuery.of(context).size.width / 2.5,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

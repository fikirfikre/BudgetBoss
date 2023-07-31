
import 'package:budget_boss/presentation/provider/currency_provider.dart';
import 'package:budget_boss/presentation/provider/user_cache.dart';
import 'package:budget_boss/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/account_cache.dart';

class AddAcount extends StatefulWidget {
  const AddAcount({super.key});

  @override
  State<AddAcount> createState() => _AddAcountState();
}

class _AddAcountState extends State<AddAcount> {
  @override
  Widget build(BuildContext context) {

    var cache = Provider.of<AccountCache>(context,listen: false);
    var user = Provider.of<UserCache>(context,listen:  false);
    var currency = Provider.of<CurrencyProvider>(context);
    TextEditingController valueController = TextEditingController();
    var provider = Provider.of<CurrencyProvider>(context,listen: false);
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
                 Container(
                  padding: const EdgeInsets.all(10),
                   child:  Text("Enter main account balance",
                   
                   style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w400
                   ),
                   textAlign: TextAlign.center,),
                 ),
              
              
              
                const Text("You can add more accounts in the Accounts section",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey
                ),
                 textAlign: TextAlign.center,
                   ),
                   Padding(
                     padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         SizedBox(
                          width: 150,
                          child: TextField(
                            controller: valueController,
                          )
                          ),
                          Text(provider.currency.currency,style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),)
                       ],
                     ),

                   ),
                  const Expanded(child: SizedBox()),

                     Container(
          width: 150,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20)
          ),
          
          margin:const EdgeInsets.all(20),
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: (){
              if(valueController.text == "" ){
                                    ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("please choose currency")));
              }else{
            cache.createAccount(valueController.text,user.user?.id,currency.currency.id);
            Navigator.pushNamed(context, RouteGenerator.home);
              }
             
            }, 
            child:const Text("Next",style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),)),
        ) 

        
        
            ],
          ),
        ),
      ),
    );
  }
}
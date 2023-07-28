
import 'package:budget_boss/presentation/provider/currency_provider.dart';
import 'package:budget_boss/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/currency.dart';

class AddCurrency extends StatefulWidget {
  const AddCurrency({super.key});

  @override
  State<AddCurrency> createState() => _AddCurrencyState();
}

class _AddCurrencyState extends State<AddCurrency> {
  
    @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CurrencyProvider>(context);
    
 var style = const TextStyle(
  fontSize: 18,
 // fontWeight: FontWeight.w400
 );
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: Column(
        children: [
          Text("Choose Your Default Currency",style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).primaryColor,
        

          ),
          textAlign: TextAlign.center,
          ),
      
       Padding(
         padding: const EdgeInsets.all(10.0),
         child: TextField(
          onChanged: (value) =>provider.runFilter(value),
        //  controller: searchController,
         decoration: const InputDecoration(
             labelText: "Search",
             hintText: "Search",
             suffixIcon: Icon(Icons.search),
            
            ),
       ),
       ),
          Expanded(
            child: 
          provider.founded.isNotEmpty?
          ListView.builder(
        itemCount: provider.founded.length,
        itemBuilder: (_,index){
          return GestureDetector(
             onTap: (){
                  provider.select(index);
                  provider.selectedCurrency(provider.founded[index]);
                  },
            child: Container(
              color:  provider.founded[index].isSelected? Colors.black12:null,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                                
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                     Text(provider.founded[index].country,style: style,),
                     Text(provider.founded[index].currency, style: style,)
                    ],),
               
              ),
            ),
          );
        })
        :
        Padding(
          padding: const EdgeInsets.all(30.0),
          child:  Text(" No Result Found", style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 24,
          color: Theme.of(context).primaryColor),),
        )
        
        ),
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

              // Navigator.of(context).pushNamed(RouteGenerator.addAccount);
            }, 
            child: TextButton(
              onPressed: (){
         
                if (provider.currency == null){
                    ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("please choose currency"))   
                 );
                }else{
                    Navigator.pushNamed(context, RouteGenerator.addAccountScreen);
                }
              },
              child: Text("Next",style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),),
            )),
        ) 

          
        ],
        ),
      ),
    );
  }
}
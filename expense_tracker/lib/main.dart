
import 'dart:io';

import 'package:budget_boss/presentation/Screens/signup_screen.dart';
import 'package:budget_boss/presentation/provider/account_cache.dart';
import 'package:budget_boss/presentation/provider/calender_provider.dart';
import 'package:budget_boss/presentation/provider/category_cache.dart';
import 'package:budget_boss/presentation/provider/currency_provider.dart';
import 'package:budget_boss/presentation/provider/transaction_cache.dart';
import 'package:budget_boss/presentation/provider/type_cache.dart';
import 'package:budget_boss/presentation/provider/user_cache.dart';
import 'package:budget_boss/presentation/routes/routes.dart';

import 'package:budget_boss/presentation/provider/navigation_provider.dart';
import 'package:budget_boss/presentation/provider/on_boarding_provider.dart';
import 'package:budget_boss/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'models/user.dart';


Future<void> main() async {
  if(Platform.isWindows || Platform.isLinux){
    sqfliteFfiInit();
  }

  databaseFactory = databaseFactoryFfi;
  final isLoggedIn =  await isLogged();
  
  
  runApp( MultiProvider (
    
    providers: [
      ChangeNotifierProvider(create: (_)=>AccountCache()),
      ChangeNotifierProvider(create: (_)=> TransactionCache()),
      ChangeNotifierProvider(create: (_) => OnboardingProvider()),
      ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ChangeNotifierProvider(create: (_)=> CalendarProvider()),
      ChangeNotifierProvider(create: (_)=> TypeCache()),
      ChangeNotifierProvider(create: (_)=>CurrencyProvider()),
      ChangeNotifierProvider(create: (_)=>UserCache()),
      ChangeNotifierProvider(create: (_)=>CatagoryCache())

    ],
    child: MyApp(isLoggedIn: isLoggedIn!,)));
}

Future<bool?> isLogged() async{
  var helper = DatabaseHelper.instance;
  final data = helper.queryAll("users");
  
 var log =  data.then((list){
     for(final value in list){

    if(User.fromMap(value).isLoggedIn == true) {
      return true;
    }else{
      return false;
    }
     }
  });
   return log;
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
   MyApp({super.key,required this.isLoggedIn});

  var helper = DatabaseHelper.instance;


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if(isLoggedIn){
    var user = Provider.of<UserCache>(context,listen: false);
    user.getLoggedIn();
    }

  

    //  databaseFactory = databaseFactoryFfi;
    // helper.testdb();
    
    
         MaterialColor mycolor = MaterialColor(Color.fromRGBO(0, 128, 128, 1 ).value, const <int, Color>{
      50: Color.fromRGBO(0, 137, 123, 0.1),
      100: Color.fromRGBO(0, 137, 123, 0.2),
      200: Color.fromRGBO(0, 137, 123, 0.3),
      300: Color.fromRGBO(0, 137, 123, 0.4),
      400: Color.fromRGBO(0, 137, 123, 0.5), 
      500: Color.fromRGBO(0, 137, 123, 0.6),
      600: Color.fromRGBO(0, 137, 123, 0.7),
      700: Color.fromRGBO(0, 137, 123, 0.8),
      800: Color.fromRGBO(0, 137, 123, 0.9),
      900: Color.fromRGBO(0, 137, 123, 1),
    },
  );

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: mycolor,
      ),
      initialRoute: isLoggedIn ? '/': '/boot',
      onGenerateRoute: RouteGenerator.generateRoute,
      //  home: SignUpPage(),
  
  );}
}

import 'package:budget_boss/presentation/Screens/account_fill_screen.dart';
import 'package:budget_boss/presentation/Screens/add_transaction_screen.dart';
import 'package:budget_boss/presentation/Screens/boot_screen.dart';
import 'package:budget_boss/presentation/Screens/currency_screen.dart';
import 'package:budget_boss/presentation/Screens/login_screen.dart';
import 'package:budget_boss/presentation/Screens/onbording_screen.dart';
import 'package:budget_boss/presentation/Screens/setting_screen.dart';
import 'package:budget_boss/presentation/Screens/signup_screen.dart';
import 'package:budget_boss/presentation/widget/bottom_navigation.dart';
import 'package:flutter/material.dart';

class RouteGenerator{
  static const String bootScreen ='/boot';
  static const String onboardScreen = '/onboard';
  static const String currencyScreen = '/currency';
  static const String addAccountScreen = '/account';
  static const String addTransaction = '/transaciton';
  static const String home ="/";
  static const String login ="/login";
  static const String signup = "/signup";
  static const String setting = "/setting";

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case bootScreen:
          return MaterialPageRoute(
            builder: (_)=>const BootScreen());
      case onboardScreen:
          return MaterialPageRoute(
            builder:(_)=> const Onboarding() );
      case currencyScreen:
          return MaterialPageRoute(builder: 
          (_)=>const AddCurrency());
      case addAccountScreen:
      return MaterialPageRoute(builder: 
      (_)=>AddAcount());

      case addTransaction:
      return MaterialPageRoute(builder: (_)=>
      AddTransaction());
      case home:
      return MaterialPageRoute(builder: (_)=>
      BottomNavigation());
      case login:
      return MaterialPageRoute(builder: (_)=>LoginPage());
      case signup:
      return MaterialPageRoute(builder: (_)=>SignUpPage());
      case setting:
      return MaterialPageRoute(builder: (_)=>Setting());
      default:
          throw const FormatException("Route not found");
    }
  }
}

import 'package:budget_boss/models/currency.dart';
import 'package:flutter/material.dart';

class CurrencyProvider extends ChangeNotifier{

List<Currency> _founded = Currency.currencies;
List<Currency> allCurrency = Currency.currencies;
bool isSelected = false;
Currency? _selectedCurrency;


//to search the currency using country name
void runFilter(String word){
 List<Currency> results = [];

 if(word.isEmpty){
  results = Currency.currencies;
 }else{
  results = Currency.currencies
  .where((currency) => 
  
  currency.country.toLowerCase().contains(word.toLowerCase()))
  .toList();
 }
 _founded = results;
 notifyListeners();
} 

//to change the color when the user select the currency the prefered
void select(index){
  // isSelected = isSelected.map<bool>((v)=>false).toList();
  // isSelected[index] = !isSelected[index];
 for (var element in _founded) {
    if (element.isSelected == true){
              element.isSelected =!element.isSelected ;
    }
 }
   _founded[index].isSelected = !_founded[index].isSelected;
   selectedCurrency(_founded[index]);
   
  notifyListeners();
}

//to store the selected currency
void selectedCurrency(Currency currency){
  _selectedCurrency = currency;

  notifyListeners();
}
 
List<Currency> get  founded => _founded;

get currency => _selectedCurrency;

}

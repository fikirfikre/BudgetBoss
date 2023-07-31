import 'package:flutter/material.dart';

class CalendarProvider extends ChangeNotifier{
  bool _isWeek = false;
  get isWeek => _isWeek;
  void changeWeek(){
    _isWeek = !_isWeek;
    notifyListeners();
  }
}
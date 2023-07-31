import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier{
  int _currentIndex = 0;
  get currentIndex => _currentIndex;
  void setCurrentIndex(value){
    _currentIndex = value;
    notifyListeners();
  }
}
import 'package:flutter/widgets.dart';

class NavigationProvider extends ChangeNotifier {
  int _pageIndex = 0;
  get pageIndex => _pageIndex;
  void changeIndex(value) {
    _pageIndex = value;
    notifyListeners();
  }
}

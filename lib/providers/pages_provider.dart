import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';

class PagesProvider with ChangeNotifier {
  int pageIndex = 0;

  late String currentPageTitle = appTitles[pageIndex];

  void updatePageIndex(int newPageIndex) {
    pageIndex = newPageIndex;
    updatePageTitle(
      appTitles[newPageIndex],
    );
    notifyListeners();
  }

  void updatePageTitle(String newPageTitle) {
    currentPageTitle = newPageTitle;
    notifyListeners();
  }
}

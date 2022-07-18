import 'package:flutter/foundation.dart';

class NavTabProvider with ChangeNotifier {
  int tabIndex;
  List<int> loadedPages = [
    0,
  ];

  NavTabProvider({required this.tabIndex});

  void setTab(int idx) {
    tabIndex = idx;
    notifyListeners();
  }

  void setLoadedPages(List<int> lp) {
    loadedPages = lp;
    notifyListeners();
  }
}

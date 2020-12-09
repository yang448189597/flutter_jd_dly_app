import 'package:flutter/foundation.dart';

import 'package:flutter/foundation.dart';

class BottomNaviProvider with ChangeNotifier {
  int bottomNaviIndex = 0;

  void changeBottomNaviInder(int index) {
    if (this.bottomNaviIndex != index) {
      this.bottomNaviIndex = index;
      notifyListeners();
    }
  }
}

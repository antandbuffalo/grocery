import 'package:flutter/material.dart';

import 'Item.dart';

class ItemsVM extends ChangeNotifier {
  String title = "from view model";
  List<ItemModel> allItems = [];

  void createItems() {
    allItems
        .add(ItemModel("Thor Dhal Thor Dhal Thor Dhal Thor Dhal Thor Dhal", 0));
    allItems.add(ItemModel("Surf Excel Bar Rs 35", 0));
    allItems.add(ItemModel("Urid Dhal", 0));
    notifyListeners();
  }

  void changeTitle(String newTitle) {
    title = newTitle;
    notifyListeners();
  }

  void add(int index) {
    allItems[index].count += 1;
    print(index);
    notifyListeners();
  }
  void remove(int index) {
    if(allItems[index].count == 0) {
      return;
    }
    allItems[index].count -= 1;
    print(index);
    notifyListeners();
  }
}

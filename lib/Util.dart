import 'dart:convert';

import 'items/ItemModel.dart';

class Util {
  static List<ItemModel> getItemsFromJson(jsonItems) {
    List<ItemModel> items = [];
    for(int i =0; i < jsonItems.length; i++) {
      items.add(ItemModel.fromJson(jsonItems[i]));
    }
    return items;
  }

  static List<ItemModel> getSelectedItems(List<ItemModel> items) {
    List<ItemModel> selected = [];
    for(int i=0; i < items.length; i++) {
      if(items[i].count > 0) {
        selected.add(items[i]);
      }
    }
    return selected;
  }
}
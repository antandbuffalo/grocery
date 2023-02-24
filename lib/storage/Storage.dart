import 'dart:convert';

import 'package:grocery/Util.dart';
import 'package:grocery/items/ItemModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<List<ItemModel>> getItems(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic value =  pref.get(key);
    if(value != null) {
      return Util.getItemsFromJson(jsonDecode(value));
    } else {
      return [];
    }
  }

  static Future<bool> setItems(String key, List<ItemModel> items) async {
    String value = jsonEncode(items);
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(key, value);
  }

  static Future<bool> removeItems(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.remove(key);
  }
}
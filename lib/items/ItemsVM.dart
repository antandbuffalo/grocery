import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:grocery/Constants.dart';
import 'package:grocery/Util.dart';
import 'package:grocery/storage/Storage.dart';
import 'ItemModel.dart';

class ItemsVM extends ChangeNotifier {
  String title = "from view model";
  List<ItemModel> allItems = [];

  Future<List<ItemModel>> readJson() async {
    final String response = await rootBundle.loadString('assets/items.en.json');
    final data = await json.decode(response);
    final jsonItems = data["items"];
    List<ItemModel> items = [];
    for(int i =0; i < jsonItems.length; i++) {
      items.add(ItemModel.fromJson(jsonItems[i]));
    }
    return items;
  }

  void createItems() async {
    allItems = await readJson();
    List<ItemModel> selectedItems = await Storage.getItems(Constants.prefItemsKey);
    Map<int, int> countMap = {};
    for(int i=0; i< selectedItems.length; i++) {
      countMap[selectedItems[i].id] = selectedItems[i].count;
    }
    for(int i =0; i < allItems.length; i++) {
      allItems[i].count = countMap[allItems[i].id] ?? 0;
    }
    notifyListeners();
  }

  void changeTitle(String newTitle) {
    title = newTitle;
    notifyListeners();
  }

  void add(int index) async {
    allItems[index].count += 1;
    notifyListeners();
    await Storage.setItems(Constants.prefItemsKey, Util.getSelectedItems(allItems));
    print(await Storage.getItems(Constants.prefItemsKey));
  }
  void remove(int index) {
    if(allItems[index].count == 0) {
      return;
    }
    allItems[index].count -= 1;
    print(index);
    notifyListeners();
  }

  void share() async {
    var bodyBuffer = StringBuffer();
    for(ItemModel item in allItems) {
      if(item.count > 0) {
        bodyBuffer.writeln("${item.title} - ${item.count}");
      }
    }



    await FlutterShare.share(
        title: 'Example share',
        text: bodyBuffer.toString(),
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title'
    );
  }
}

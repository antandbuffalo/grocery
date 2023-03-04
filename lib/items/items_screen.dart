import 'package:flutter/material.dart';
import 'package:grocery/items/ItemModel.dart';
import 'package:provider/provider.dart';

import 'ItemsVM.dart';

class Items extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Items();
}

class _Items extends State<Items> {
  ItemsVM viewModel = ItemsVM();

  @override
  void initState() {
    super.initState();
    viewModel.createItems();
  }

  List<Widget> getItemsUI() {
    List<Widget> items = [];
    for (int i = 0; i < viewModel.allItems.length; i++) {
      if(!viewModel.allItems[i].visible) {
        continue;
      }
      items.add(
        ListTile(
          contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          shape:
              const Border(bottom: BorderSide(color: Colors.black26, width: 1)),
          title: Text(viewModel.allItems[i].title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => viewModel.remove(i),
                icon: const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
                tooltip: 'remove',
              ),
              Text(viewModel.allItems[i].count.toString()),
              IconButton(
                onPressed: () => viewModel.add(i),
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
                tooltip: 'add',
              ),
            ],
          ),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("மணி மாறன் ஸ்டோர்"),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => viewModel.share(),
                child: const Icon(
                  Icons.share,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: ChangeNotifierProvider<ItemsVM>(
        create: (context) => viewModel,
        child: Consumer<ItemsVM>(
          builder: (_, viewModel, __) {
            return Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Invoke "debug painting" (press "p" in the console, choose the
                // "Toggle Debug Paint" action from the Flutter Inspector in Android
                // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                // to see the wireframe for each widget.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'தேடு',
                      suffixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.all(10.0)
                    ),
                    onChanged: (text) => viewModel.filterItems(text),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [...getItemsUI()],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

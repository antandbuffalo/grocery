import 'package:flutter/material.dart';
import 'package:grocery/items/Item.dart';
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
      items.add(
        ListTile(
          title: Text(viewModel.allItems[i].title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => viewModel.remove(i),
                icon: const Icon(Icons.remove_circle),
                tooltip: 'add',
              ),
              Text(viewModel.allItems[i].count.toString()),
              IconButton(
                onPressed: () => viewModel.add(i),
                icon: const Icon(Icons.add_circle),
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
        title: const Text("Select Items"),
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
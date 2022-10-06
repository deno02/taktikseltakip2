import 'package:flutter/material.dart';

import 'add_layer.dart';
//import 'deneme_add.dart';
import 'layer_list_widget.dart';

class LayerPage extends StatefulWidget {
  const LayerPage({Key? key}) : super(key: key);

  @override
  _LayerPageState createState() => _LayerPageState();
}

class _LayerPageState extends State<LayerPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      LayerListWidget(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Layer Page"),
        centerTitle: true,
      ),
      //Herifin Yaptığı
      /*bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'Areas',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.done,
                size: 28,
              ),
              label: 'Completed'),
        ],
      ),*/
      body: tabs[0],
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: () => showDialog(
            context: context,
            builder: (context) => yeniAddLayer(),
            barrierDismissible: false),
        child: Icon(Icons.add),
      ),
      //Benim yaptığım yerr!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      /*Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: EdgeInsets.all(20),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(Icons.add),
            onPressed: () => showDialog(
              builder: (context) => AddArea(),
              context: context,
              barrierDismissible: false,
            ),
          ),
        ),
      ),*/
    );
  }
}

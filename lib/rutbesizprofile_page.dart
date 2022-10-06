import 'package:flutter/material.dart';
import 'package:taktikseltakip/rutbesizprofilelistwidget.dart';

class rutbesizProfilePage extends StatefulWidget {
  const rutbesizProfilePage({Key? key}) : super(key: key);

  @override
  _rutbesizProfilePageState createState() => _rutbesizProfilePageState();
}

class _rutbesizProfilePageState extends State<rutbesizProfilePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      rutbesizProfileListWidget(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
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

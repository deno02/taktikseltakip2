import 'package:flutter/material.dart';

import 'add_profile.dart';
import 'profile_list_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      ProfileListWidget(),
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
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: () => showDialog(
            context: context,
            builder: (context) => AddProfile(),
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

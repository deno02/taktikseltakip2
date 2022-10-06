import 'package:flutter/material.dart';

import './add_profile.dart';
import './edit_profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profiles',
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool value = false;
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        elevation: 0.8,
        title: Text(
          '                   Profiles',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              //AddProfile sayfasına geçiş için
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddProfile(),
              ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Card(
                child: Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Checkbox(
                              activeColor: Colors.green[800],
                              value: this.value,
                              onChanged: (bool? value) {
                                setState(() {
                                  this.value = value!;
                                });
                              },
                            ),
                          ), //Checkbox) //Checkbox
                          Flexible(
                            child: Text(
                              'Baslık',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Flexible(
                            child: FlatButton(
                              child: Text('Edit'),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditProfile(),
                                ));
                              },
                            ),
                          ),
                          Flexible(
                            child: FlatButton(
                              child: Text('Delete'),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      FlatButton(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(isVisible
                            ? 'Hide Coordinates'
                            : 'Show Coordinates'),
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        //padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            if (isVisible)
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text('1'),
                              ),
                            if (isVisible)
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text('2'),
                              ),
                            if (isVisible)
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text('3'),
                              ),
                            if (isVisible)
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text('4'),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                elevation: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

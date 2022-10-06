import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profiles',
      home: ProfileRutbesiz(),
    );
  }
}

class ProfileRutbesiz extends StatefulWidget {
  @override
  _ProfileRutbesizState createState() => _ProfileRutbesizState();
}

class _ProfileRutbesizState extends State<ProfileRutbesiz> {
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
        actions: <Widget>[],
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

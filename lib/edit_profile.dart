import 'package:flutter/material.dart';

import 'models/profile.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final List<Profile> _profileList = [
    Profile(
      profileName: 'Y-11',
      latitude: 39.2345,
      longitude: 41.6543,
    ),
    Profile(
      profileName: 'Y-11',
      latitude: 34.2345,
      longitude: 29.6543,
    ),
    Profile(
      profileName: 'Y-11',
      latitude: 40.2345,
      longitude: 45.6543,
    ),
    Profile(
      profileName: 'Y-11',
      latitude: 31.2345,
      longitude: 33.6543,
    ),
    Profile(
      profileName: 'Y-12',
      latitude: 35.4532,
      longitude: 29.9834,
    ),
    Profile(
      profileName: 'Y-12',
      latitude: 35.4532,
      longitude: 29.9834,
    ),
    Profile(
      profileName: 'Y-12',
      latitude: 35.4532,
      longitude: 29.9834,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        elevation: 0.8,
        title: Text(
          '                   Edit Profile',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Profile Name:'),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        width: 100,
                        child: TextField(
                          decoration: InputDecoration(labelText: 'Latitude'),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        width: 100,
                        child: TextField(
                          decoration: InputDecoration(labelText: 'Longitude'),
                        ),
                      ),
                    ),
                    Container(
                        width: 70,
                        child: RaisedButton(
                            color: Colors.green[800],
                            child: Text('Add'),
                            textColor: Colors.white,
                            onPressed: () {})),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 60),
                alignment: Alignment.center,
                child: RaisedButton(
                    color: Colors.green[800],
                    child: Text('Save Profile'),
                    textColor: Colors.white,
                    onPressed: () {}),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    itemCount: _profileList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return SingleChildScrollView(
                        child: Card(
                          elevation: 50,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey, width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    '${index + 1}       ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 150),
                                  child: Text(
                                    '${_profileList[index].latitude.toStringAsFixed(4)}, ${_profileList[index].longitude.toStringAsFixed(4)}',
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () {},
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

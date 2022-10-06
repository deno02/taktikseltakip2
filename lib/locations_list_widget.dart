import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'locations.dart';
import 'locationwidget.dart';

class LocationListWidget extends StatefulWidget {
  var id;
  LocationListWidget({Key? key, required this.id}) : super(key: key);
  @override
  _LocationListWidgetState createState() => _LocationListWidgetState();
}

class _LocationListWidgetState extends State<LocationListWidget> {
  final url = "http://172.20.10.2/veritabani/profileread.php"; //URL DEĞİŞTİR
  var _postsJson = [];
  List<locations> locationListt = [];
  void fetchPosts() async {
    try {
      final response = await http.post(Uri.parse(url), body: {
        'id': yeniid,
      });
      final jsonData = jsonDecode(response.body) as List;
      locationListt.clear();
      for (int i = 0; i < jsonData.length; i++) {
        locations Locations = locations.fromJson(jsonData[i]);
        locationListt.add(Locations);
      }
      setState(() {
        _postsJson = jsonData;
      });
    } catch (err) {
      print("error from location db");
    }
  }

  late String yeniid;
  @override
  void initState() {
    yeniid = widget.id;
    fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fetchPosts();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Container(
              child: FlatButton.icon(
                color: Colors.red[400],
                label: Text(
                  "Close",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
                padding: EdgeInsets.all(16),
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index) => Container(height: 10),
                itemCount: _postsJson.length,
                itemBuilder: (context, i) {
                  final location = locationListt[i];
                  return LocationWidget(location: location);
                }),
          ),
        ],
      ),
    );
  }
}

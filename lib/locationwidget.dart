//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'locations.dart';

class LocationWidget extends StatefulWidget {
  final locations location;
  const LocationWidget({
    required this.location,
    Key? key,
  }) : super(key: key);

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final url = "http://172.20.10.2/veritabani/locationsdelete.php";
  bool checkBoxValue = false;
  @override
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          // borderRadius: BorderRadius.circular(16),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Lat: ${widget.location.latitude}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Lon: ${widget.location.longitude}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete_sharp,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        http.post(Uri.parse(url), body: {
                          'id': widget.location.id,
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './area.dart';
import './edit_area_page.dart';

class rutbesizAreaWidget extends StatefulWidget {
  final Area area;
  const rutbesizAreaWidget({
    required this.area,
    Key? key,
  }) : super(key: key);

  @override
  State<rutbesizAreaWidget> createState() => _rutbesizAreaWidgetState();
}

class _rutbesizAreaWidgetState extends State<rutbesizAreaWidget> {
  final url = "http://172.20.10.2/veritabani/areadelete.php";
  final urll = "http://172.20.10.2/veritabani/check.php";
  bool checkBoxValue = false;
  @override
  @override
  void initState() {
    http.post(Uri.parse(urll), body: {
      'id': widget.area.id,
      'value': 'false',
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(150),
        ),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Checkbox(
                    activeColor: Theme.of(context)
                        .primaryColor, //Tıkladığındaki checkboxın kutucuğunun rengi
                    checkColor:
                        Colors.white, // Tıklandığındaki tik işaretinin rengi
                    value: checkBoxValue,
                    onChanged: (bool? value) {
                      checkBoxValue = value!;
                      if (checkBoxValue) {
                        http.post(Uri.parse(urll), body: {
                          'id': widget.area.id,
                          'value': 'true',
                        });
                      } else {
                        http.post(Uri.parse(urll), body: {
                          'id': widget.area.id,
                          'value': 'false',
                        });
                      }
                    }, //Anasayfaya gönderme işlemini burada yapmaya çalışacağız
                  ),
                  Flexible(
                    child: Text(
                      widget.area.areaName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 35, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (widget.area.latitude1.isNotEmpty &&
                        widget.area.longitude1.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          '1-    ${widget.area.latitude1} , ${widget.area.longitude1} ',
                        ),
                      ),
                    if (widget.area.latitude2.isNotEmpty &&
                        widget.area.longitude2.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          '2-    ${widget.area.latitude2} , ${widget.area.longitude2} ',
                        ),
                      ),
                    if (widget.area.latitude3.isNotEmpty &&
                        widget.area.longitude3.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          '3-    ${widget.area.latitude3} , ${widget.area.longitude3} ',
                        ),
                      ),
                    if (widget.area.latitude4.isNotEmpty &&
                        widget.area.longitude4.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          '4-    ${widget.area.latitude4} , ${widget.area.longitude4} ',
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void editArea(BuildContext context, Area area) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => EditAreaPage(area: area)));
}

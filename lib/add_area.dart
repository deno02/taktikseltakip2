import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './area_form.dart';

class yeniAddArea extends StatefulWidget {
  @override
  _yeniAddAreaState createState() => _yeniAddAreaState();
}

class _yeniAddAreaState extends State<yeniAddArea> {
  final _formKey = GlobalKey<FormState>();
  String areaName = '';
  String latitude1 = '';
  String longitude1 = '';
  String latitude2 = '';
  String longitude2 = '';
  String latitude3 = '';
  String longitude3 = '';
  String latitude4 = '';
  String longitude4 = '';
  String status = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Add Area',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              AddForm(
                onChangedTitle: (areaName) =>
                    setState(() => this.areaName = areaName),
                onChangedLatitude1: (latitude1) =>
                    setState(() => this.latitude1 = latitude1),
                onChangedLongitude1: (longitude1) =>
                    setState(() => this.longitude1 = longitude1),
                onChangedLatitude2: (latitude2) =>
                    setState(() => this.latitude2 = latitude2),
                onChangedLongitude2: (longitude2) =>
                    setState(() => this.longitude2 = longitude2),
                onChangedLatitude3: (latitude3) =>
                    setState(() => this.latitude3 = latitude3),
                onChangedLongitude3: (longitude3) =>
                    setState(() => this.longitude3 = longitude3),
                onChangedLatitude4: (latitude4) =>
                    setState(() => this.latitude4 = latitude4),
                onChangedLongitude4: (longitude4) =>
                    setState(() => this.longitude4 = longitude4),
                onChangedStatus: (status) =>
                    setState(() => this.status = status),
                onSavedArea: adddArea,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void adddArea() async {
    final isValid = _formKey.currentState!.validate();

    final response = await http.post(
        Uri.parse("http://192.168.1.34/veritabani/areainsert.php"),
        body: {
          'areaName': areaName,
          'latitude1': latitude1,
          'longitude1': longitude1,
          'latitude2': latitude2,
          'longitude2': longitude2,
          'latitude3': latitude3,
          'longitude3': longitude3,
          'latitude4': latitude4,
          'longitude4': longitude4,
          'status': status,
          'val': 'false',
        });
    setState(() {
      json.decode(response.body);
    });
    Navigator.of(context).pop();
    //_areas listesini almak için aşağısı
  }
}

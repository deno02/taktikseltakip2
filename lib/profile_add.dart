import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'global_profile.dart';
import 'print_profile.dart';
import 'profile_form.dart';

class denemeAddProfile extends StatefulWidget {
  @override
  _denemeAddProfileState createState() => _denemeAddProfileState();
}

class _denemeAddProfileState extends State<denemeAddProfile> {
  final _formKey = GlobalKey<FormState>();
  List<PrintProfile> profileList = [];
  //List<String> profileList = [];
  String profileName = '';
  String latitude = '';
  String longitude = '';
  String value = 'false';
  final profileNameController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              AddForm(
                onChangedTitle: (profileName) =>
                    setState(() => this.profileName = profileName),
                onAddedProfileName: addName,
                onChangedLatitude: (latitude) =>
                    setState(() => this.latitude = latitude),
                onChangedLongitude: (longitude) =>
                    setState(() => this.longitude = longitude),
                onAddedProfilePoint: addPoint,
                onSavedProfile: adddProfile,
              ),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(15),
                  itemCount: Global.profileList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: 20,
                        child: Row(
                          children: [
                            Text(Global.profileList[index].latitude.toString()),
                            SizedBox(width: 20),
                            Text(Global.profileList[index].longitude.toString())
                          ],
                        ));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void addPoint() async {
    final isValid = _formKey.currentState!.validate();

    final response = await http.post(
        Uri.parse("http://172.20.10.2/veritabani/locationsinsert.php"),
        body: {
          //URL DEĞİŞTİR
          'profileName': profileName,
          'latitude': latitude,
          'longitude': longitude,
        });
    setState(() {
      print("burası çalışıyor mu");
      PrintProfile points =
          PrintProfile(latitude: latitude, longitude: longitude);
      Global.profileList.add(points);
    });
    json.decode(response.body);
    //NAVIGATOR POP OLMALI MI????
  }

  void addName() async {
    final isValid = _formKey.currentState!.validate();

    final response = await http.post(
        Uri.parse("http://172.20.10.2/veritabani/profileinsert.php"),
        body: {
          //URL DEĞİŞTİR
          'profileName': profileName,
        });
    setState(() {
      json.decode(response.body);
    });
    //NAVIGATOR POP OLMALI MI????
  }

  void adddProfile() {
    Global.profileList.clear();
    Navigator.of(context).pop();
  }
}

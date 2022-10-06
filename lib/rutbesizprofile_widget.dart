//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'edit_profile_page.dart';
import 'profile.dart';

class rutbesizProfileWidget extends StatefulWidget {
  final Profile profile;
  const rutbesizProfileWidget({
    required this.profile,
    Key? key,
  }) : super(key: key);

  @override
  State<rutbesizProfileWidget> createState() => _rutbesizProfileWidgetState();
}

class _rutbesizProfileWidgetState extends State<rutbesizProfileWidget> {
  final url = "http://172.20.10.2/veritabani/profiledelete.php";
  final urll = "http://172.20.10.2/veritabani/checkprofile.php";
  bool checkBoxValue = false;
  @override
  @override
  void initState() {
    http.post(Uri.parse(urll), body: {
      'id': widget.profile.id,
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
        shadowColor: Colors.grey,
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
                          'id': widget.profile.id,
                          'value': 'true',
                        });
                      } else {
                        http.post(Uri.parse(urll), body: {
                          'id': widget.profile.id,
                          'value': 'false',
                        });
                      }
                    }, //Anasayfaya gönderme işlemini burada yapmaya çalışacağız
                  ),
                  Flexible(
                    child: Text(
                      widget.profile.profileName,
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
                    if (widget.profile.latitude.isNotEmpty &&
                        widget.profile.longitude.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          'Point-    ${widget.profile.latitude} , ${widget.profile.longitude} ',
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

  void editProfile(BuildContext context, Profile profile) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditProfilePage(profile: profile)));
}

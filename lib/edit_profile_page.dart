import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'locations_list_widget.dart';
import 'profile.dart';
import 'profile_form.dart';

class EditProfilePage extends StatefulWidget {
  final Profile profile;

  const EditProfilePage({Key? key, required this.profile}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late String profileName;
  late String latitude;
  late String longitude;

  @override
  void initState() {
    super.initState();

    profileName = widget.profile.profileName;
    latitude = widget.profile.latitude;
    longitude = widget.profile.longitude;
  }

  final url =
      "http://172.20.10.2/veritabani/profileupdate.php"; //UERL DEĞİŞTİR
  final urll = "http://172.20.10.2/veritabani/locationsinsert.php";
  final urlll = "http://172.20.10.2/veritabani/profiledelete.php";
  Widget build(BuildContext context) {
    final tabs = [
      LocationListWidget(id: widget.profile.id),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              http.post(Uri.parse(url), body: {
                'id': widget.profile.id,
              });

              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AddForm(
                profileName: profileName,
                latitude: latitude,
                longitude: longitude,
                onChangedTitle: (profileName) =>
                    setState(() => this.profileName = profileName),
                onAddedProfileName: addProfileName,
                onChangedLatitude: (latitude) =>
                    setState(() => this.latitude = latitude),
                onChangedLongitude: (longitude) =>
                    setState(() => this.longitude = longitude),
                onAddedProfilePoint: addProfilePoint,
                onSavedProfile: saveProfile,
              ),
              SizedBox(height: 20),
              Container(
                width: 110,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            (LocationListWidget(id: widget.profile.id)),
                        barrierDismissible: false);
                  },
                  child: Text('Points'),
                ),
              ),
            ]),
      ),

      // LocationListWidget(
      //child: LocationListWidget(),
      /* child: Form(

          child: Column(
            children: <Widget>[
              AddForm(
                profileName: profileName,
                latitude: latitude,
                longitude: longitude,
                onChangedTitle: (profileName) =>
                    setState(() => this.profileName = profileName),
                onAddedProfileName: addProfileName,
                onChangedLatitude: (latitude) =>
                    setState(() => this.latitude = latitude),
                onChangedLongitude: (longitude) =>
                    setState(() => this.longitude = longitude),
                onAddedProfilePoint: addProfilePoint,
                onSavedProfile: saveProfile,
              ),

            ],
          ),
        ),*/
      //),
      //    padding: const EdgeInsets.all(20),
      //   child: LocationListWidget(),
      /* child: Form(
          key: _formKey, //Bunun sayesinde değişiklikleri yapabiliyor
          child: AddForm(
            profileName: profileName,
            latitude: latitude,
            longitude: longitude,
            onChangedTitle: (profileName) =>
                setState(() => this.profileName = profileName),
            onAddedProfileName: addProfileName,
            onChangedLatitude: (latitude) =>
                setState(() => this.latitude = latitude),
            onChangedLongitude: (longitude) =>
                setState(() => this.longitude = longitude),
            onAddedProfilePoint: addProfilePoint,
            onSavedProfile: saveProfile,
          )

        ),,*/
    );
  }

  void saveProfile() {
    //bu direkt ismi yollasa yeterli

    Navigator.of(context).pop();
  }

  void addProfileName() {
    http.post(Uri.parse(url), body: {
      'id': widget.profile.id,
      'profileName': profileName,
    });
    //NAVIGATOR POP OLMALI MI???
  }

  void addProfilePoint() {
    //burası sadece pointlerle ilgilenecek isim vs değil
    http.post(Uri.parse(urll), body: {
      'profileName': profileName,
      'latitude': latitude,
      'longitude': longitude,
    });
    //NAVIGATOR POP OLMALI MI???
  }
}

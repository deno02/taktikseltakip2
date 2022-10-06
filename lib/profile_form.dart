import 'package:flutter/material.dart';

import 'global_profile.dart';
import 'print_profile.dart';

class AddForm extends StatefulWidget {
  /*
  final String areaName;
  final String latitude1;
  final String longitude1;
  final String latitude2;
  final String longitude2;
  final String latitude3;
  final String longitude3;
  final String latitude4;
  final String longitude4;

  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedLatitude1;
  final ValueChanged<String> onChangedLongitude1;
  final ValueChanged<String> onChangedLatitude2;
  final ValueChanged<String> onChangedLongitude2;
  final ValueChanged<String> onChangedLatitude3;
  final ValueChanged<String> onChangedLongitude3;
  final ValueChanged<String> onChangedLatitude4;
  final ValueChanged<String> onChangedLongitude4;
*/
  final String profileName;
  final String latitude;
  final String longitude;

  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedLatitude;
  final ValueChanged<String> onChangedLongitude;

  final VoidCallback onSavedProfile;
  final VoidCallback onAddedProfileName;
  final VoidCallback onAddedProfilePoint;

  const AddForm({
    Key? key,
    this.profileName = '',
    this.latitude = '',
    this.longitude = '',
    required this.onChangedTitle,
    required this.onChangedLatitude,
    required this.onChangedLongitude,
    required this.onAddedProfileName,
    required this.onAddedProfilePoint,
    required this.onSavedProfile,
  }) : super(key: key);

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  void printPoints(String lat, String lon) {
    PrintProfile points = PrintProfile(latitude: lat, longitude: lon);
    Global.profileList.add(points);
  }

  @override
  //Area Name' i build etme yeri
  Widget buildTitle() => Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: TextFormField(
          maxLines: 1,
          initialValue: widget.profileName,
          onChanged: widget.onChangedTitle,
          validator: (profileName) {
            if (profileName!.isEmpty) {
              return 'The profile name cannot be empty';
            }
            return null;
          }, //doldurulduğundan emin olmak için
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Profile Name',
          ),
        ),
      );

  Widget buildProfileNameButton() => Container(
        margin: EdgeInsets.only(top: 20),
        child: ElevatedButton(
          onPressed: widget.onAddedProfileName,
          child: Text('Add Profile'),
        ),
      );

  Widget buildLatLon() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 110,
            child: TextFormField(
              initialValue: widget.latitude,
              onChanged: widget.onChangedLatitude,
              //controller: latitudeController,
              decoration: InputDecoration(
                labelText: 'Latitude',
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          Container(
            width: 110,
            child: TextFormField(
              initialValue: widget.longitude,
              onChanged: widget.onChangedLongitude,
              //controller: longitudeController,
              decoration: InputDecoration(
                labelText: 'Longitude',
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: //(){
                  //printPoints(latitudeController.text.toString(), longitudeController.text.toString());
                  widget.onAddedProfilePoint,

              //print(widget.onChangedLatitude);

              //},
              child: Text('Add'),
            ),
          ),
        ],
      ),
    );
  }

  /*Widget buildLocaitonButton() => ElevatedButton(
        onPressed: widget.onSavedProfile,
        child: Text('Add'),
      );*/

  Widget buildButton() => ElevatedButton(
        onPressed: widget.onSavedProfile,
        child: Text('Save Profile'),
      );

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            buildTitle(),
            buildProfileNameButton(),
            SizedBox(
              height: 8,
            ),
            buildLatLon(),
            //buildLocaitonButton(),
            SizedBox(height: 30),
            buildButton(),
          ],
        ),
      ),
    );
  }
}

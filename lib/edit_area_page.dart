import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './area.dart';
import './area_form.dart';

class EditAreaPage extends StatefulWidget {
  final Area area;

  const EditAreaPage({Key? key, required this.area}) : super(key: key);

  @override
  _EditAreaPageState createState() => _EditAreaPageState();
}

class _EditAreaPageState extends State<EditAreaPage> {
  final _formKey = GlobalKey<FormState>();

  late String areaName;
  late String latitude1;
  late String longitude1;
  late String latitude2;
  late String longitude2;
  late String latitude3;
  late String longitude3;
  late String latitude4;
  late String longitude4;
  late String status;

  /*Future getStatus() async {
    var resp = await http.post(
        Uri.parse("http://172.20.10.2/veritabani/getstatus.php"),
        body: {
          'areaName': areaName,
        });
    print(json.decode(resp.body));
    return json.decode(resp.body);
  }*/

  @override
  void initState() {
    super.initState();

    areaName = widget.area.areaName;
    latitude1 = widget.area.latitude1;
    longitude1 = widget.area.longitude1;
    latitude2 = widget.area.latitude2;
    longitude2 = widget.area.longitude2;
    latitude3 = widget.area.latitude3;
    longitude3 = widget.area.longitude3;
    latitude4 = widget.area.latitude4;
    longitude4 = widget.area.longitude4;
    status = widget
        .area.status; //BURADA VERİTABANINDAN ÇEKEREK STATUSU YAZABİLİ MİYİZ??
    // status = getStatus().toString();
  }

  final url = "http://172.20.10.2/veritabani/areaupdate.php";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('                  Edit Area'),
        actions: [
          /*   IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              http.post(Uri.parse(url), body: {
                'id': widget.area.id,
              });

              Navigator.of(context).pop();
            },
          )*/
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey, //Bunun sayesinde değişiklikleri yapabiliyor
          child: AddForm(
            areaName: areaName,
            latitude1: latitude1,
            longitude1: longitude1,
            latitude2: latitude2,
            longitude2: longitude2,
            latitude3: latitude3,
            longitude3: longitude3,
            latitude4: latitude4,
            longitude4: longitude4,
            status: status,
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
            onChangedStatus: (status) => setState(() => this.status = status),
            onSavedArea: saveArea,
          ),
        ),
      ),
    );
  }

  void saveArea() {
    http.post(Uri.parse(url), body: {
      'id': widget.area.id,
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
    });

    Navigator.of(context).pop();
  }
}

import 'dart:convert';
//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'global_layer.dart';
import 'layer_form.dart';
import 'print_layer.dart';

class yeniAddLayer extends StatefulWidget {
  @override
  _yeniAddLayerState createState() => _yeniAddLayerState();
}

class _yeniAddLayerState extends State<yeniAddLayer> {
  final _formKey = GlobalKey<FormState>();

  File? _image;
  final picker = ImagePicker();

  List<PrintLayer> layerList = [];
  String layerName = '';
  String latitudeLB = '';
  String latitudeRB = '';
  String latitudeLT = '';
  String latitudeRT = '';
  String longitudeLB = '';
  String longitudeRB = '';
  String longitudeLT = '';
  String longitudeRT = '';

  final layerNameController = TextEditingController();
  final latitudeLBController = TextEditingController();
  final latitudeRBController = TextEditingController();
  final latitudeLTController = TextEditingController();
  final latitudeRTController = TextEditingController();
  final longitudeLBController = TextEditingController();
  final longitudeRBController = TextEditingController();
  final longitudeLTController = TextEditingController();
  final longitudeRTController = TextEditingController();

  Future chooseImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  Future uploadImage() async {
    var url = "http://172.20.10.4/veritabani/layerinsert.php";
    try {
      List<int> imageBytes = _image!.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      //convert file image to Base64 encoding
      var response = await http.post(Uri.parse(url), body: {
        'layerName': layerName,
        'latitudeLB': latitudeLB,
        'longitudeLB': longitudeLB,
        'latitudeRB': latitudeRB,
        'longitudeRB': longitudeRB,
        'latitudeLT': latitudeLT,
        'longitudeLT': longitudeLT,
        'latitudeRT': latitudeRT,
        'longitudeRT': longitudeRT,
        'image': baseimage,
      });
      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body); //decode json data
        if (jsondata["error"]) {
          //check error sent from server
          print(jsondata["msg"]);
          //if error return from server, show message from server
        } else {
          print("Upload successful");
        }
      } else {
        print("Error during connection to server");
        //there is error during connecting to server,
        //status code might be 404 = url not found
      }
    } catch (e) {
      print("Error during converting to Base64");
      print(e.toString());
      //there is error during converting file image to base64 encoding.
    }
    Navigator.of(context).pop(); //BAK BAKALIM OLDU MU
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Layer"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              //height: ,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    AddForm(
                      onChangedTitle: (layerName) =>
                          setState(() => this.layerName = layerName),
                      //onAddedLayerName: addName,
                      onChangedLatitudeLB: (latitudeLB) =>
                          setState(() => this.latitudeLB = latitudeLB),
                      onChangedLatitudeRB: (latitudeRB) =>
                          setState(() => this.latitudeRB = latitudeRB),
                      onChangedLatitudeLT: (latitudeLT) =>
                          setState(() => this.latitudeLT = latitudeLT),
                      onChangedLatitudeRT: (latitudeRT) =>
                          setState(() => this.latitudeRT = latitudeRT),
                      onChangedLongitudeLB: (longitudeLB) =>
                          setState(() => this.longitudeLB = longitudeLB),
                      onChangedLongitudeRB: (longitudeRB) =>
                          setState(() => this.longitudeRB = longitudeRB),
                      onChangedLongitudeLT: (longitudeLT) =>
                          setState(() => this.longitudeLT = longitudeLT),
                      onChangedLongitudeRT: (longitudeRT) =>
                          setState(() => this.longitudeRT = longitudeRT),
                      //onAddedProfilePoint: addPoint,
                      onTakeImage: _getFromCamera,
                      onPickImage: chooseImage,
                      onSavedLayer: uploadImage,
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(15),
                      itemCount: Global.layerList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            height: 20,
                            child: Row(
                              children: [
                                Text(Global.layerList[index].latitudeLB
                                    .toString()),
                                Text(Global.layerList[index].latitudeRB
                                    .toString()),
                                Text(Global.layerList[index].latitudeLT
                                    .toString()),
                                Text(Global.layerList[index].latitudeRT
                                    .toString()),
                                Text(Global.layerList[index].longitudeLB
                                    .toString()),
                                Text(Global.layerList[index].longitudeRB
                                    .toString()),
                                Text(Global.layerList[index].longitudeLT
                                    .toString()),
                                Text(Global.layerList[index].longitudeRT
                                    .toString()),
                              ],
                            ));
                      },
                    ),
                    Container(
                      child: _image == null
                          ? Text('No Image Selected')
                          : Image.file(_image!),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
/*
  void addPoint() async{
    final isValid = _formKey.currentState!.validate();

    final response = await http
        .post(Uri.parse("http://172.20.10.4/veritabani/areainsert.php"), body: {//URL DEĞİŞTİR
      'latitude': latitude,
      'longitude': longitude,
    });
    setState(() {
      json.decode(response.body);
    });
    //NAVIGATOR POP OLMALI MI????
  }*/

  /*void addName() async{
    final isValid = _formKey.currentState!.validate();

    final response = await http
        .post(Uri.parse("http://172.20.10.4/veritabani/areainsert.php"), body: {//URL DEĞİŞTİR
      'layerName': layerName,
    });
    setState(() {
      json.decode(response.body);
    });
    //NAVIGATOR POP OLMALI MI????
    }*/

  void adddLayer() async {
    final isValid = _formKey.currentState!.validate();

    final response = await http.post(
        Uri.parse("http://172.20.10.2/veritabani/areainsert.php"),
        body: {
          //URL DEĞİŞTİR
          'layerName': layerName,
          'latitudeLT': latitudeLT,
          'latitudeRT': latitudeRT,
          'latitudeLB': latitudeLB,
          'latitudeRB': latitudeRB,
          'longitudeLT': latitudeLT,
          'longitudeRT': latitudeRT,
          'longitudeLB': latitudeLB,
          'longitudeRB': latitudeRB,
          //burada da photo olacak
        });
    setState(() {
      json.decode(response.body);
    });

    //_profiles listesini almak için aşağısı

    Navigator.of(context).pop();
  }
}

//kameraya ulaşmak için:
_getFromCamera() async {
  final pickedFile = await ImagePicker().pickImage(
    source: ImageSource.camera,
    //maxWidth: 1800,
    //maxHeight: 1800,
  );
  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);
  }
}

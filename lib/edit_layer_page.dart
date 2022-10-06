import 'dart:async' show Future;
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'layer.dart';
import 'layer_form.dart';
import 'layers.dart';

class EditLayerPage extends StatefulWidget {
  final Layer layer;

  const EditLayerPage({Key? key, required this.layer}) : super(key: key);

  @override
  _EditLayerPageState createState() => _EditLayerPageState();
}

class _EditLayerPageState extends State<EditLayerPage> {
  final _formKey = GlobalKey<FormState>();

  File? _image;
  final picker = ImagePicker();
  File? _imagee;

  var filePath = 'http://172.20.10.2/veritabani/';

  late String layerName;
  late String latitudeLB;
  late String latitudeRB;
  late String latitudeLT;
  late String latitudeRT;
  late String longitudeLB;
  late String longitudeRB;
  late String longitudeLT;
  late String longitudeRT;
  late String image;

  @override
  void initState() {
    super.initState();

    layerName = widget.layer.layerName;
    latitudeLB = widget.layer.latitudeLB;
    latitudeRB = widget.layer.latitudeRB;
    latitudeLT = widget.layer.latitudeLT;
    latitudeRT = widget.layer.latitudeRT;
    longitudeLB = widget.layer.longitudeLB;
    longitudeRB = widget.layer.longitudeRB;
    longitudeLT = widget.layer.longitudeLT;
    longitudeRT = widget.layer.longitudeRT;

    loadImage();
  }

  Future loadImage() async {
    var url = "http://172.20.10.2/veritabani/getimage.php";

    var result = await http.post(Uri.parse(url), body: {
      'layerId': widget.layer.id,
    });
    final jsonData = jsonDecode(result.body);
    var path = jsonData[0]["image"];
    image = filePath + path;
    return image;
  }

  Future chooseImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  _getFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  final url = "http://172.20.10.2/veritabani/areaupdate.php";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('                  Edit Layer'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              final provider =
                  Provider.of<LayersProvider>(context, listen: false);
              provider.removeLayer(widget.layer);

              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                AddForm(
                  layerName: layerName,
                  latitudeLB: latitudeLB,
                  latitudeRB: latitudeRB,
                  latitudeLT: latitudeLT,
                  latitudeRT: latitudeRT,
                  longitudeLB: longitudeLB,
                  longitudeRB: longitudeRB,
                  longitudeLT: longitudeLT,
                  longitudeRT: longitudeRT,
                  onChangedTitle: (layerName) =>
                      setState(() => this.layerName = layerName),
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
                  onTakeImage: _getFromCamera,
                  onPickImage: chooseImage,
                  onSavedLayer: saveLayer,
                ),
                Container(
                  child: _image == null
                      ? FutureBuilder(
                          future: loadImage(),
                          builder: (context, snapshot) {
                            return Container(
                              child: Image.network(image),
                            );
                          })
                      : Image.file(_image!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveLayer() async {
    var url = "http://172.20.10.2/veritabani/updatelayer.php";

    List<int> imageBytes;
    String baseimage;
    if (_image != null) {
      imageBytes = _image!.readAsBytesSync();
      baseimage = base64Encode(imageBytes);
      debugPrint("photo changed");
    } else {
      baseimage = image;
      debugPrint("photo hasn't changed");
    }

    var deneme = http.post(Uri.parse(url), body: {
      'layerId': widget.layer.id,
      'layerName': layerName,
      'latitudeLB': latitudeLB,
      'latitudeRB': latitudeRB,
      'latitudeLT': latitudeLT,
      'latitudeRT': latitudeRT,
      'longitudeLB': longitudeLB,
      'longitudeRB': longitudeRB,
      'longitudeLT': longitudeLT,
      'longitudeRT': longitudeRT,
      'image': baseimage,
    });

    Navigator.of(context).pop();
  }
}

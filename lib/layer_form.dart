import 'package:flutter/material.dart';

import 'global_layer.dart';
import 'print_layer.dart';

class AddForm extends StatefulWidget {
  final String layerName;
  final String latitudeLB;
  final String latitudeRB;
  final String latitudeLT;
  final String latitudeRT;
  final String longitudeLB;
  final String longitudeRB;
  final String longitudeLT;
  final String longitudeRT;

  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedLatitudeLB;
  final ValueChanged<String> onChangedLatitudeRB;
  final ValueChanged<String> onChangedLatitudeLT;
  final ValueChanged<String> onChangedLatitudeRT;
  final ValueChanged<String> onChangedLongitudeLB;
  final ValueChanged<String> onChangedLongitudeRB;
  final ValueChanged<String> onChangedLongitudeLT;
  final ValueChanged<String> onChangedLongitudeRT;

  final VoidCallback onSavedLayer;
  final VoidCallback onTakeImage;
  final VoidCallback onPickImage;

  //var onChangedLongitudeLT;
  //final VoidCallback onAddedProfileName;
  //final VoidCallback onAddedProfilePoint;

  const AddForm({
    Key? key,
    this.layerName = '',
    this.latitudeLB = '',
    this.latitudeRB = '',
    this.latitudeLT = '',
    this.latitudeRT = '',
    this.longitudeLB = '',
    this.longitudeRB = '',
    this.longitudeLT = '',
    this.longitudeRT = '',
    required this.onChangedTitle,
    required this.onChangedLatitudeLB,
    required this.onChangedLatitudeRB,
    required this.onChangedLatitudeLT,
    required this.onChangedLatitudeRT,
    required this.onChangedLongitudeLB,
    required this.onChangedLongitudeRB,
    required this.onChangedLongitudeLT,
    required this.onChangedLongitudeRT,
    //required this.onAddedProfileName,
    //required this.onAddedProfilePoint,
    required this.onTakeImage,
    required this.onPickImage,
    required this.onSavedLayer,
  }) : super(key: key);

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final latitudeLBController = TextEditingController();
  final latitudeRBController = TextEditingController();
  final latitudeLTController = TextEditingController();
  final latitudeRTController = TextEditingController();
  final longitudeLBController = TextEditingController();
  final longitudeRBController = TextEditingController();
  final longitudeLTController = TextEditingController();
  final longitudeRTController = TextEditingController();

  void printLayers(String latLB, String latRB, String latLT, String latRT,
      String lonLB, String lonRB, String lonLT, String lonRT) {
    PrintLayer points = PrintLayer(
        latitudeLB: latLB,
        latitudeRB: latRB,
        latitudeLT: latLT,
        latitudeRT: latRT,
        longitudeLB: lonLB,
        longitudeRB: lonRB,
        longitudeLT: lonLT,
        longitudeRT: lonRT);
    Global.layerList.add(points);
  }

  @override
  //Area Name' i build etme yeri
  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: widget.layerName,
        onChanged: widget.onChangedTitle,
        validator: (layerName) {
          if (layerName!.isEmpty) {
            return 'The layer name cannot be empty';
          }
          return null;
        }, //doldurulduğundan emin olmak için
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Layer Name',
        ),
      );

  /*Widget buildLayerNameButton() => ElevatedButton(
        onPressed: widget.onAddedLayerName,
        child: Text('Add Layer'),
      );*/

  Widget buildLatLon1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.30,
          child: TextFormField(
            initialValue: widget.latitudeLB,
            onChanged: widget.onChangedLatitudeLB,
            //controller: latitudeController,
            decoration: InputDecoration(
              labelText: 'Latitude Left Bottom',
              border: UnderlineInputBorder(),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.32,
          child: TextFormField(
            initialValue: widget.longitudeLB,
            onChanged: widget.onChangedLongitudeLB,
            //controller: latitudeController,
            decoration: InputDecoration(
              labelText: 'Longitude Left Bottom',
              border: UnderlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLatLon2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.30,
          child: TextFormField(
            initialValue: widget.latitudeRB,
            onChanged: widget.onChangedLatitudeRB,
            //controller: latitudeController,
            decoration: InputDecoration(
              labelText: 'Latitude Right Bottom',
              border: UnderlineInputBorder(),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.33,
          child: TextFormField(
            initialValue: widget.longitudeRB,
            onChanged: widget.onChangedLongitudeRB,
            //controller: latitudeController,
            decoration: InputDecoration(
              labelText: 'Longitude Right Bottom',
              border: UnderlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLatLon3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.30,
          child: TextFormField(
            initialValue: widget.latitudeLT,
            onChanged: widget.onChangedLatitudeLT,
            //controller: latitudeController,
            decoration: InputDecoration(
              labelText: 'Latitude Left Top',
              border: UnderlineInputBorder(),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.32,
          child: TextFormField(
            initialValue: widget.longitudeLT,
            onChanged: widget.onChangedLongitudeLT,
            //controller: latitudeController,
            decoration: InputDecoration(
              labelText: 'Longitude Left Top',
              border: UnderlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLatLon4() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.30,
          child: TextFormField(
            initialValue: widget.latitudeRT,
            onChanged: widget.onChangedLatitudeRT,
            //controller: latitudeController,
            decoration: InputDecoration(
              labelText: 'Latitude Right Top',
              border: UnderlineInputBorder(),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.32,
          child: TextFormField(
            initialValue: widget.longitudeRT,
            onChanged: widget.onChangedLongitudeRT,
            //controller: latitudeController,
            decoration: InputDecoration(
              labelText: 'Longitude Left Top',
              border: UnderlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTakeImageButton() => ElevatedButton(
        onPressed: widget.onTakeImage,
        child: Text('Take Image'),
      );

  Widget buildPickImageButton() => ElevatedButton(
        onPressed: widget.onPickImage,
        child: Text('Pick Image'),
      );

  Widget buildImageSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            width: 110,
            child: ElevatedButton(
              child: Text('Take Image'),
              onPressed: widget.onTakeImage,
            )),
        Container(
            width: 110,
            child: ElevatedButton(
              child: Text('Pick Image'),
              onPressed: widget.onPickImage,
            )),
      ],
    );
  }

  /*Widget buildLocaitonButton() => ElevatedButton(
        onPressed: widget.onSavedProfile,
        child: Text('Add'),
      );*/

  Widget buildButton() => ElevatedButton(
        onPressed: widget.onSavedLayer,
        child: Text('Save Layer'),
      );

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          buildTitle(),
          //buildLayerNameButton(),
          /*SizedBox(
            height: 8,
          ),*/
          buildLatLon1(),
          buildLatLon2(),
          buildLatLon3(),
          buildLatLon4(),
          //buildLocaitonButton(),
          SizedBox(height: 30),
          buildImageSelection(),
          buildButton(),
        ],
      ),
    );
  }
}
//kameraya ulaşmak için:
/*_getFromCamera() async {
  final pickedFile = await ImagePicker().pickImage(
    source: ImageSource.camera,
    //maxWidth: 1800,
    //maxHeight: 1800,
  );
  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);
  }
}*/
/*
Future chooseImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }*/

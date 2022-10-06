//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taktikseltakip/global_layer.dart';

import 'edit_layer_page.dart';
import 'layer.dart';

class rutbesizLayerWidget extends StatefulWidget {
  final Layer layer;
  const rutbesizLayerWidget({
    required this.layer,
    Key? key,
  }) : super(key: key);

  @override
  State<rutbesizLayerWidget> createState() => _rutbesizLayerWidgetState();
}

class _rutbesizLayerWidgetState extends State<rutbesizLayerWidget> {
  final urll = "http://172.20.10.2/veritabani/checklayer.php";
  bool checkBoxValue = false;
  @override
  @override
  void initState() {
    Global.addLayerCheck = 'false';
    http.post(Uri.parse(urll), body: {
      'layerId': widget.layer.id,
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
                        Global.addLayerCheck = 'true';
                        http.post(Uri.parse(urll), body: {
                          'layerId': widget.layer.id,
                          'value': 'true',
                        });
                      } else {
                        Global.addLayerCheck = 'false';
                        http.post(Uri.parse(urll), body: {
                          'layerId': widget.layer.id,
                          'value': 'false',
                        });
                      }
                    }, //Anasayfaya gönderme işlemini burada yapmaya çalışacağız
                  ),
                  Flexible(
                    child: Text(
                      widget.layer.layerName,
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
                    if (widget.layer.latitudeLB.isNotEmpty &&
                        widget.layer.longitudeLB.isNotEmpty &&
                        widget.layer.latitudeRB.isNotEmpty &&
                        widget.layer.longitudeRB.isNotEmpty &&
                        widget.layer.latitudeLT.isNotEmpty &&
                        widget.layer.longitudeLT.isNotEmpty &&
                        widget.layer.latitudeRT.isNotEmpty &&
                        widget.layer.longitudeRT.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          'Point-    ${widget.layer.latitudeLB} , ${widget.layer.longitudeLB} \n'
                          'Point-    ${widget.layer.latitudeRB} , ${widget.layer.longitudeRB} \n'
                          'Point-    ${widget.layer.latitudeLT} , ${widget.layer.longitudeLT} \n'
                          'Point-    ${widget.layer.latitudeRT} , ${widget.layer.longitudeRT} \n',
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

  void editLayer(BuildContext context, Layer layer) =>
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EditLayerPage(layer: layer)));
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:taktikseltakip/rutbesiz_layer_widget.dart';

import 'layer.dart';

class rutbesizLayerListWidget extends StatefulWidget {
  @override
  State<rutbesizLayerListWidget> createState() =>
      _rutbesizLayerListWidgetState();
}

class _rutbesizLayerListWidgetState extends State<rutbesizLayerListWidget> {
  final url = "http://172.20.10.2/veritabani/getlayers.php"; //URL DEĞİŞTİR
  var _postsJson = [];
  List<Layer> layerListt = [];
  void fetchPosts() async {
    try {
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;
      layerListt.clear();

      for (int i = 0; i < jsonData.length; i++) {
        Layer layer = Layer.fromJson(jsonData[i]);
        layerListt.add(layer);
      }
      setState(() {
        _postsJson = jsonData;
      });
    } catch (err) {
      print("error from db");
      print(err.toString());
    }
  }

  @override
  void initState() {
    fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fetchPosts();
    return ListView.separated(
        padding: EdgeInsets.all(16),
        physics: BouncingScrollPhysics(),
        separatorBuilder: (context, index) => Container(height: 16),
        itemCount: _postsJson.length,
        itemBuilder: (context, i) {
          final layer = layerListt[i];
          return rutbesizLayerWidget(layer: layer);
        });
  }
}

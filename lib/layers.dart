import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import 'layer.dart';

class LayersProvider extends ChangeNotifier {
  final url = "http://172.20.10.2/veritabani/getlayers.php"; //URL DEĞİŞTİR
  var _postsJson = [];
  void fetchPosts() async {
    try {
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;
      _postsJson = jsonData;
    } catch (err) {}
  }

  final List<Layer> _layers = [];
  List<Layer> get layers => _layers.toList();

//add_area daki addArea methodunu burayada ekledik.
  void adddLayer(Layer layer) {}

  //Area silmek için:
  void removeLayer(Layer layer) {
    _layers.remove(layer);
    notifyListeners();
  }

  void updateLayer(
    Layer layer,
    String layerName,
    String latitudeLB,
    String latitudeRB,
    String latitudeLT,
    String latitudeRT,
    String longitudeLB,
    String longitudeRB,
    String longitudeLT,
    String longitudeRT,
    String image,
  ) {
    layer.layerName = layerName;
    layer.latitudeLB = latitudeLB;
    layer.longitudeLB = longitudeLB;
    layer.latitudeRB = latitudeRB;
    layer.longitudeRB = longitudeRB;
    layer.latitudeLT = latitudeLT;
    layer.longitudeLT = longitudeLT;
    layer.latitudeRT = latitudeRT;
    layer.longitudeRT = longitudeRT;
    layer.image = image;

    notifyListeners();
  }
}

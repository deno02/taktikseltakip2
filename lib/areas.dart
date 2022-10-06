import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import './area.dart';

class AreasProvider extends ChangeNotifier {
  final url = "http://172.20.10.2/veritabani/arearead.php";
  var _postsJson = [];
  void fetchPosts() async {
    try {
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;
      _postsJson = jsonData;
    } catch (err) {}
  }

  final List<Area> _areas = [];
  List<Area> get areas => _areas.toList();

//add_area daki addArea methodunu burayada ekledik.
  void adddArea(Area area) {}

  //Area silmek için:
  void removeArea(Area area) {
    _areas.remove(area);
    notifyListeners();
  }

  void updateArea(
      Area area,
      String areaName,
      String latitude1,
      String longitude1,
      String latitude2,
      String longitude2,
      String latitude3,
      String longitude3,
      String latitude4,
      String longitude4) {
    area.areaName = areaName;
    area.latitude1 = latitude1;
    area.longitude1 = longitude1;
    area.latitude2 = latitude2;
    area.longitude2 = longitude2;
    area.latitude3 = latitude3;
    area.longitude3 = longitude3;
    area.latitude4 = latitude4;
    area.longitude4 = longitude4;

    notifyListeners();
  }
}

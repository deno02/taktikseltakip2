import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'area.dart';
import 'area_widget.dart';

class AreaListWidget extends StatefulWidget {
  @override
  State<AreaListWidget> createState() => _AreaListWidgetState();
}

class _AreaListWidgetState extends State<AreaListWidget> {
  final url = "http://172.20.10.2/veritabani/arearead.php";
  var _postsJson = [];
  List<Area> areaListt = [];
  void fetchPosts() async {
    try {
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;
      areaListt.clear();
      for (int i = 0; i < jsonData.length; i++) {
        Area area = Area.fromJson(jsonData[i]);
        areaListt.add(area);
      }
      setState(() {
        _postsJson = jsonData;
      });
    } catch (err) {
      print("error from db");
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
          final area = areaListt[i];
          return AreaWidget(area: area);
        });
  }
}

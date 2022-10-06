import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'profile.dart';
import 'profile_widget.dart';

class ProfileListWidget extends StatefulWidget {
  @override
  State<ProfileListWidget> createState() => _ProfileListWidgetState();
}

class _ProfileListWidgetState extends State<ProfileListWidget> {
  final url = "http://172.20.10.2/veritabani/locationread.php"; //URL DEĞİŞTİR
  var _postsJson = [];
  List<Profile> profileListt = [];
  void fetchPosts() async {
    try {
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;
      profileListt.clear();
      for (int i = 0; i < jsonData.length; i++) {
        Profile profile = Profile.fromJson(jsonData[i]);
        profileListt.add(profile);
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
          final profile = profileListt[i];
          return ProfileWidget(profile: profile);
        });
  }
}

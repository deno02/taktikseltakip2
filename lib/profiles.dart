import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import 'profile.dart';

class ProfilesProvider extends ChangeNotifier {
  final url = "http://172.20.10.2/veritabani/locationread.php"; //URL DEĞİŞTİR
  var _postsJson = [];
  void fetchPosts() async {
    try {
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;
      _postsJson = jsonData;
    } catch (err) {}
  }

  final List<Profile> _profiles = [];
  List<Profile> get profiles => _profiles.toList();

//add_area daki addArea methodunu burayada ekledik.
  void adddProfile(Profile profile) {}

  //Area silmek için:
  void removeProfile(Profile profile) {
    _profiles.remove(profile);
    notifyListeners();
  }

  void updateArea(
      Profile profile, String profileName, String latitude, String longitude) {
    profile.profileName = profileName;
    profile.latitude = latitude;
    profile.longitude = longitude;

    notifyListeners();
  }
}

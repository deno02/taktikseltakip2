class ProfileField {
  static const createdTime = 'createdTime';
}

class Profile {
  //DateTime createdTime;
  String profileName;
  String latitude;
  String longitude;
  String id;

  String isChecked; // Bunu sonra ana haritaya atmak için deneyeceğiz

  Profile({
    //required this.createdTime,
    required this.profileName,
    this.latitude = '',
    this.longitude = '',
    this.id = '', //Duruma göre buna bak this.id çalışmadı
    this.isChecked = 'false',
  });

  factory Profile.fromJson(dynamic json) {
    return Profile(
      //createdTime: DateTime.now(),
      profileName: json['profileName'] as String,
      id: json['profileId'] as String,
      // isChecked: json['check'] as String,
      //  isChecked: json['value'] as String,
    );
  }
}

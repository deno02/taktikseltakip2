class locationsField {
  static const createdTime = 'createdTime';
}

class locations {
  String latitude;
  String longitude;
  String id;
  locations({
    //required this.createdTime,
    this.latitude = '',
    this.longitude = '',
    this.id = '', //Duruma göre buna bak this.id çalışmadı
  });
  factory locations.fromJson(dynamic json) {
    return locations(
      //createdTime: DateTime.now(),
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      id: json['locationsId'] as String,
      //  isChecked: json['value'] as String,
    );
  }
}

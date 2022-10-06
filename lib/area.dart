class AreaField {
  static const createdTime = 'createdTime';
}

class Area {
  DateTime createdTime;
  String areaName;
  String latitude1;
  String longitude1;
  String latitude2;
  String longitude2;
  String latitude3;
  String longitude3;
  String latitude4;
  String longitude4;
  String id;
  String status;
  String isChecked; // Bunu sonra ana haritaya atmak için deneyeceğiz

  Area({
    required this.createdTime,
    required this.areaName,
    this.latitude1 = '',
    this.longitude1 = '',
    this.latitude2 = '',
    this.longitude2 = '',
    this.latitude3 = '',
    this.longitude3 = '',
    this.latitude4 = '',
    this.longitude4 = '',
    this.id = '', //Duruma göre buna bak this.id çalışmadı
    this.isChecked = '',
    this.status = '',
  });

  factory Area.fromJson(dynamic json) {
    return Area(
      createdTime: DateTime.now(),
      areaName: json['areaName'] as String,
      latitude1: json['latitude1'] as String,
      longitude1: json['longitude1'] as String,
      latitude2: json['latitude2'] as String,
      longitude2: json['longitude2'] as String,
      latitude3: json['latitude3'] as String,
      longitude3: json['longitude3'] as String,
      latitude4: json['latitude4'] as String,
      longitude4: json['longitude4'] as String,
      id: json['areaId'] as String,
      isChecked: json['checked'] as String,
      status: json['status'] as String,
    );
  }
}

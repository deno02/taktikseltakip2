class LayerField {
  static const createdTime = 'createdTime';
}

class Layer {
  //DateTime createdTime;
  String layerName;
  String latitudeLB;
  String latitudeRB;
  String latitudeLT;
  String latitudeRT;
  String longitudeLB;
  String longitudeRB;
  String longitudeLT;
  String longitudeRT;
  String id;
  String image;

  //String isChecked; // Bunu sonra ana haritaya atmak için deneyeceğiz

  Layer({
    //required this.createdTime,
    required this.layerName,
    this.latitudeLB = '',
    this.longitudeLB = '',
    this.latitudeRB = '',
    this.longitudeRB = '',
    this.latitudeLT = '',
    this.longitudeLT = '',
    this.latitudeRT = '',
    this.longitudeRT = '',
    this.id = '', //Duruma göre buna bak this.id çalışmadı
    this.image = '',
    //this.isChecked = 'false',
  });

  factory Layer.fromJson(dynamic json) {
    return Layer(
      //createdTime: DateTime.now(),
      layerName: json['layerName'] as String,
      latitudeLB: json['latLB'] as String,
      longitudeLB: json['longLB'] as String,
      latitudeRB: json['latRB'] as String,
      longitudeRB: json['longRB'] as String,
      latitudeLT: json['latLT'] as String,
      longitudeLT: json['longLT'] as String,
      latitudeRT: json['latRT'] as String,
      longitudeRT: json['longRT'] as String,
      id: json['layerId'] as String,
      image: json['image'] as String,
      //isChecked: json['value'] as String,
    );
  }
}

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:bitmap/bitmap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_compass/flutter_compass.dart';
//import 'package:flutter_application_6/area_main.dart';
//import 'package:flutter_application_6/deneme/mapvertex.dart';
//import 'package:flutter_application_6/main_layer.dart';
//import 'package:flutter_application_6/profile_main.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:taktikseltakip/global_layer.dart';
import 'package:taktikseltakip/rutbesizarea_page.dart';
import 'package:taktikseltakip/rutbesizlayer_page.dart';
import 'package:taktikseltakip/rutbesizprofile_page.dart';

//import 'asilmain.dart';
//import './edit_area.dart';
//import './models/area.dart';
final url = "http://172.20.10.2/veritabani/mainarearead.php";
final urll = "http://172.20.10.2/veritabani/mainprofileread.php";
final urlll = "http://172.20.10.2/veritabani/mainlayerread.php";
var _postsJson = [];
int i = 0;
var t, x, k;
bool makeZoom = true;
var zoomlevel = 18.2;
var initLat, initLong;
var tempLong, tempLat;
var metin;
var fark1, fark2;
var distanceInMeters;
var now;
var now2;
var hiz;
var newLat, newLong;
var ang;
var count = 0;
var lat1 = 0;
var lon1 = 0;
var lat2 = 0;
var lon2 = 0;
var zoomAyar = 2; //ilkten takip sekilde olsun yani zoom yapilmasin.
var sayac = 0;
var zoomLabel = 'Zoom In Zoom Out Disable';

void main() {
  runApp(Rutbesiz());
}

var g;

class Rutbesiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //---------------------------
  final bool debug;
  const MyHomePage({Key? key, this.debug = false}) : super(key: key);
  //---------------------------
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MapType _currentMapType = MapType.normal;

  LatLng _initialcameraposition = const LatLng(20.5937, 18.9629);
  late GoogleMapController _controller;
  final Location _location = Location();
//
  List<Polyline> myPolyline = [];
//

  Set<Marker> markers = {}; //markers for google map
  var latLB, lonLB, latRB, lonRB, latLT, lonLT, latRT, lonRT;

//orta
  LatLng startLocation = const LatLng(39.88867, 32.7189);
//sag alt
  LatLng carLocation = const LatLng(39.88847, 32.7267);
//sol alt
  LatLng endLocation = const LatLng(39.8886, 32.7113);

//sol alt
  LatLng endLocation2 = const LatLng(39.8644, 32.5828);
//sag alt
  LatLng carLocation2 = const LatLng(39.8559, 32.8542);
//orta
  //LatLng endLocation2 = LatLng(sonucLat,sonucLon);

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    x = 12742 * asin(sqrt(a));
    print(x);
    return x;
  }

  addMarkers() async {
    print('Buraya girdi mi');
    final response = await get(Uri.parse(urlll));
    final jsonData = jsonDecode(response.body) as List;
    _postsJson = jsonData;
    String filePath = _postsJson[0]["image"].toString();
    print(filePath);
    latLB = double.parse(_postsJson[0]["latLB"]);
    lonLB = double.parse(_postsJson[0]["longLB"]);
    latRB = double.parse(_postsJson[0]["latRB"]);
    lonRB = double.parse(_postsJson[0]["longRB"]);
    latLT = double.parse(_postsJson[0]["latLT"]);
    lonLT = double.parse(_postsJson[0]["longLT"]);
    latRT = double.parse(_postsJson[0]["latRT"]);
    lonRT = double.parse(_postsJson[0]["longRT"]);

    var altLat = (latLB + latRB) / 2; //alt lat
    var altLon = (lonLB + lonRB) / 2; //alt lon

    var ustLat = (latLT + latRT) / 2; //ust lat
    var ustLon = (lonLT + lonRT) / 2; //ust lon

    var sonucLat = (altLat + ustLat) / 2;
    var sonucLon = (ustLon + altLon) / 2;
    LatLng photoCoordinate = LatLng(sonucLat, sonucLon);

    zoomlevel = 14;
    if (filePath == null) {
      makeZoom = true;
    }
    makeZoom = false;

    t = calculateDistance(latLB, lonLB, latRB, lonRB);

    if (t <= 1 && t >= 0) {
      zoomlevel = 18; //dogru
    } else if (t <= 2 && t > 1) {
      zoomlevel = 15.6; //dogru
    } else if (t <= 3 && t > 2) {
      zoomlevel = 15.1; //dogru
    } else if (t <= 4 && t > 3) {
      zoomlevel = 13.6; //dogru
    } else if (t <= 5 && t > 4) {
      zoomlevel = 13.7; //dogru
    } else if (t <= 6 && t > 5) {
      zoomlevel = 13.3; //dogru
    } else if (t <= 7 && t > 6) {
      zoomlevel = 13.1; //dogru
    } else if (t <= 8 && t > 7) {
      zoomlevel = 12.7; //dogru
    } else if (t <= 9 && t > 8) {
      zoomlevel = 12.4; //dogru
    } else if (t <= 10 && t > 9) {
      zoomlevel = 12.1; //dogru
    } else if (t <= 11 && t > 10) {
      zoomlevel = 11.9; //dogru
    } else if (t <= 12 && t > 11) {
      zoomlevel = 11.9;
    } else if (t <= 13 && t > 12) {
      zoomlevel = 11.9;
    } else if (t <= 14 && t > 13) {
      zoomlevel = 11.9;
    } else {
      //yaklasik 100 kilometreden fazla alan gorunuyor.
      zoomlevel = 9.1;
    }
//1
    /*BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(30, 00)),
      "lib/assets/images/lol.png",
    );*/

//2
    //String imgurl = "http://172.20.10.2/veritabani/" + filePath.toString();

    /* Uint8List bytes = (await NetworkAssetBundle(
      Uri.parse(imgurl),
    ).load(imgurl))
        .buffer
        .asUint8List();*/
    Bitmap bitmap = await Bitmap.fromProvider(
        NetworkImage("http://172.20.10.2/veritabani/" + filePath.toString()));
    Bitmap resizedBitmap =
        bitmap.apply(BitmapResize.to(width: 1280, height: 1000));
    Uint8List bytes = resizedBitmap.buildHeaded();
    markers.add(Marker(
      //add start location marker
      zIndex: 1,
      draggable: false,
      anchor: const Offset(0.5, 0.5),
      markerId: MarkerId('Add_Photo_1'),
      position: photoCoordinate, //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Photo1',
      ),

      icon: BitmapDescriptor.fromBytes(
        bytes,
      ),
    ));

    setState(() {
      markers.add(
        Marker(
            //add start location marker
            zIndex: 100,
            draggable: false,
            markerId: const MarkerId('2'),
            position: LatLng(initLat, initLong), //position of marker
            infoWindow: const InfoWindow(
              //popup info
              title: 'Current Location',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure)),
      );
    });
  }

//App bar'a basinca yandan menu acilmasi.
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  get polylinePoints => null;
  @override

//Circle olusturmaaaaaaaaaaaaaa
  /*Set<Circle> circles = Set.from([
  Circle(
     circleId: CircleId('1'),
     center:LatLng(initLat,initLong),
     radius: 1,
     strokeWidth: 10,


   ),
 ]);*/
///////////////////////////////
  ///

  bool First = true;
  bool isStop = false;
  bool pb = false;
  List<LatLng> data = [];
//Veri guncellendikce fonksiyonda degisiklik icin setState kullan.
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    _setPolygons();
    createPloyLineRotaEkle();
    if (Global.addLayerCheck == 'true') {
      if (zoomLabel == "Zoom In Zoom Out Enable") {
        zoomLabel = "Zoom In Zoom Out Disable";
        sayac++;
      }
      zoomAyar = 3;
    } else if (Global.addLayerCheck == 'false') {
      zoomLabel = "Zoom In Zoom Out Enable";
      if (sayac % 2 == 0) {
        sayac++;
      }
      zoomAyar = 1;
      Marker marker1 = markers.firstWhere(
        (marker) => marker.markerId.value == 'Add_Photo_1',
      );
      Marker marker2 = markers.firstWhere(
        (marker) => marker.markerId.value == '2',
      );

      setState(() {
        markers.remove(marker1);
        markers.remove(marker2);
        makeZoom = true;
        zoomlevel = 18.2;
      });
    }
    //Rota takibiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
    if (pb == true) {
      if (First) {
        First = false;
        LatLng _new = LatLng(newLat, newLong);
        data.add(_new);
      }
      LatLng _news = LatLng(initLat, initLong);
      data.add(_news);
      createPloyLineKonumTakip();
    } else if (isStop == true) {
      myPolyline.clear();
    }

    ///////////////////////////////////////////////////
  }

  //Bir kez calican fonksiyonlar initStatede.
  void iniState() {
    super.initState();
    _setPolygons();
    createPloyLineKonumTakip();
  }

  //Hiz almaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
  late StreamSubscription<Position> _positionStream;
  double _speed = 0.1;

  @override
  void initState() {
    if (zoomlevel == 18.2) {
      //addMarkers();
    }

    _positionStream = Geolocator.getPositionStream().listen((position) {
      _onSpeedChange(position == null
          ? 0.0
          : (position.speed * 18) / 5); // m/s den km/hr ye cevirme.
    });
    super.initState();
  }

  void _onSpeedChange(double newSpeed) {
    setState(() {
      _speed = newSpeed;
    });
  }

  @override
  //State nesnesi kaldırılırken kalıcı olan nesneler kaldırılır
  void dispose() {
    _positionStream.cancel();
    super.dispose();
  }

  ///////////////////////////////////////////////////
  var color = Colors.blue;
  //Rota Takibiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
  createPloyLineKonumTakip() {
    myPolyline.add(
      Polyline(
        polylineId: PolylineId("2"),
        color: color,
        width: 5,
        points: data,
      ),
    );
  }
  //////////////////////////////////////////

  // Profil EKLEMEEEEEEEEEEEEEEEEEEEEEEEEEEEe
  //polyline id'yi 2 verme sebebim createPloyLine'da yani rota takibinde id 1 karismasin diye buna 2 verdim.
  List<LatLng> polylineLatLongs = <LatLng>[];
  createPloyLineRotaEkle() async {
    final response = await get(Uri.parse(urll));
    final jsonData = jsonDecode(response.body) as List;
    polylineLatLongs.clear();
    for (i = 0; i < jsonData.length; i++) {
      polylineLatLongs.add(LatLng(double.parse(jsonData[i]["latitude"]),
          double.parse(jsonData[i]["longitude"])));
      myPolyline.add(
        Polyline(
          polylineId: PolylineId(jsonData[i]["profileIdd"].toString()),
          color: Colors.red,
          width: 3,
          points: polylineLatLongs,
        ),
      );
    }
    print(polylineLatLongs.length);
  }

  Widget _image(int sides) {
    return ClipPolygon(
      child: Image.network(
          "https://cdn.pixabay.com/photo/2018/01/05/00/20/test-image-3061864_960_720.png"),
      boxShadows: [
        PolygonBoxShadow(color: Colors.black, elevation: 2.0),
        PolygonBoxShadow(color: Colors.yellow, elevation: 4.0),
        PolygonBoxShadow(color: Colors.red, elevation: 6.0),
      ],
      sides: sides,
      borderRadius: 10,
    );
  }
  ////////////////////////////////////////////

  // AREA EKLEMEEEEEEEEEEEEEEEEEEEEEEEEEEEe
  Set<Polygon> _polygons = HashSet<Polygon>();
  void _setPolygons() async {
    final response = await get(Uri.parse(url));
    final jsonData = jsonDecode(response.body) as List;
    //setState(() {
    _postsJson = jsonData;
    for (i = 0; i < _postsJson.length; i++) {
      print(_postsJson.length);
      List<LatLng> polygonLatLongs = <LatLng>[];
      polygonLatLongs.add(LatLng(double.parse(_postsJson[i]["latitude1"]),
          double.parse(_postsJson[i]["longitude1"])));
      polygonLatLongs.add(LatLng(double.parse(_postsJson[i]["latitude2"]),
          double.parse(_postsJson[i]["longitude2"])));
      polygonLatLongs.add(LatLng(double.parse(_postsJson[i]["latitude3"]),
          double.parse(_postsJson[i]["longitude3"])));
      polygonLatLongs.add(LatLng(double.parse(_postsJson[i]["latitude4"]),
          double.parse(_postsJson[i]["longitude4"])));
      if (_postsJson[i]["status"] == "Working Zone") {
        _polygons.add(
          Polygon(
            polygonId: PolygonId(_postsJson[i]["areaId"]),
            points: polygonLatLongs,
            //arealarin colorlarini selected index ile degistirebiliriz.
            // fillColor: selectedIndex == index ? Colors.pink: Colors.blue,
            fillColor: Colors.white70,
            strokeWidth: 2,
            strokeColor: Colors.blue,
          ),
        );
      }
      if (_postsJson[i]["status"] == "" ||
          _postsJson[i]["status"] == "None Selected") {
        _polygons.add(
          Polygon(
            polygonId: PolygonId(_postsJson[i]["areaId"]),
            points: polygonLatLongs,
            //arealarin colorlarini selected index ile degistirebiliriz.
            // fillColor: selectedIndex == index ? Colors.pink: Colors.blue,
            fillColor: Colors.white70,
            strokeWidth: 2,
            strokeColor: Colors.black,
          ),
        );
      }
      if (_postsJson[i]["status"] == "Fuel Field") {
        _polygons.add(
          Polygon(
            polygonId: PolygonId(_postsJson[i]["areaId"]),
            points: polygonLatLongs,
            //arealarin colorlarini selected index ile degistirebiliriz.
            // fillColor: selectedIndex == index ? Colors.pink: Colors.blue,
            fillColor: Colors.white70,
            strokeWidth: 2,

            strokeColor: Colors.green,
          ),
        );
      }
      if (_postsJson[i]["status"] == "No Entry Zone") {
        _polygons.add(
          Polygon(
            polygonId: PolygonId(_postsJson[i]["areaId"]),
            points: polygonLatLongs,
            //arealarin colorlarini selected index ile degistirebiliriz.
            // fillColor: selectedIndex == index ? Colors.pink: Colors.blue,
            fillColor: Colors.white70,
            strokeWidth: 2,
            strokeColor: Colors.red,
          ),
        );
      }
    }
  }

  /////////////////////////////////////////

  //Icona Basinca Renginin Degismesi.
  Color _iconColor1 = Colors.white;
  Color _iconColor2 = Colors.white;
  Color _iconColor3 = Colors.white;

  /////////////////////////////////////////

  Widget build(BuildContext context) {
    //Denizcanin ekledigi
    final Size size = MediaQuery.of(context).size;
    /////////////////////

    return Scaffold(
      bottomNavigationBar: new BottomAppBar(
        notchMargin: 5.0,
        shape: const CircularNotchedRectangle(),
        color: Colors.green[800],
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: [
                IconButton(
                    padding: new EdgeInsets.only(bottom: 4),
                    onPressed: () {
                      setState(() {
                        if (_iconColor3 == Colors.white) {
                          _iconColor3 = Colors.black;
                          if (_iconColor1 == Colors.black) {
                            _iconColor1 = Colors.white;
                          }
                          if (_iconColor2 == Colors.black) {
                            _iconColor2 = Colors.white;
                          }
                        } else {
                          _iconColor3 = Colors.white;
                        }
                        pb = true;
                      });
                    },
                    icon: const Icon(Icons.play_circle_fill_sharp),
                    color: _iconColor3),
                const Text(
                  'Start',
                  style: const TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                    padding: new EdgeInsets.only(
                      bottom: 4,
                    ),
                    onPressed: () {
                      if (_iconColor2 == Colors.white) {
                        _iconColor2 = Colors.black;
                        if (_iconColor1 == Colors.black) {
                          _iconColor1 = Colors.white;
                        }
                        if (_iconColor3 == Colors.black) {
                          _iconColor3 = Colors.white;
                        }
                      } else {
                        _iconColor2 = Colors.white;
                      }
                      pb = false;
                    },
                    icon: const Icon(Icons.pause),
                    color: _iconColor2),
                const Text(
                  'Pause',
                  style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                    padding: new EdgeInsets.only(bottom: 4),
                    onPressed: () {
                      if (_iconColor1 == Colors.white) {
                        _iconColor1 = Colors.black;
                        if (_iconColor2 == Colors.black ||
                            _iconColor3 == Colors.black) {
                          _iconColor2 = Colors.white;
                          _iconColor3 = Colors.white;
                        }
                      } else {
                        _iconColor1 = Colors.white;
                      }
                      data.clear();
                      isStop = true;
                      pb = false;

                      // data.clear();
                      // data.clear();
                      // print(data.length);
                      // if (data.isEmpty) {
                      //   print(
                      //       'pekeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeer');
                      //   data.clear();
                      //   pb = true;
                      // }

                      // myPolyline.clear();

                      // pb = false;
                      // setState(() {
                      //   myPolyline.clear();
                      //   myPolyline.remove("0");
                      //   createPloyLineKonumTakip();
                      // });
                      //print(data);
                    },
                    icon: const Icon(Icons.stop),
                    color: _iconColor1),
                const Text(
                  'Stop',
                  style: const TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      //enlem ve boylami gostercek
      /* bottomNavigationBar :Container(
      height: 20,
      color: Colors.transparent,
      //color: Colors.grey[150],
      alignment: Alignment.topLeft,
      child:Text(

        //eger distance kontorlu yapmak istersek bunu asagi yapistir, calculateDistance(39.890755, 32.720318, 39.8949023, 32.7048104)
      " do not Follow   Stop                                      Pause        Start",
      style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
                  color: Colors.grey[1000],
                 ),

                 textAlign: TextAlign.center,

      ),
      ), */
      //App bar'a basinca yandan menu acilmasi.
      key: _scaffoldKey,

      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.blueGrey[700], //desired color
        ),
        child: Drawer(
          child: Container(
            color: Colors.black12,
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.all(1.0),
            //Drawer'a sayfalari ekliyoruz.
            child: ListView(
              children: [
                Container(
                  height: 210,
                  child: DrawerHeader(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("lib/assets/background2.jpg"),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 63.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              radius: 60.0,
                              backgroundImage:
                                  AssetImage("lib/assets/soldier.jpeg"),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FittedBox(
                            child: Text(
                              'Soldier',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.blueGrey[700],
                                fontFamily: 'Fredoka',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      )),
                )
                // const DrawerHeader(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //     image: DecorationImage(
                //       image: AssetImage('lib/assets/drawer.jpeg'),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                //   child: Text(
                //     'Tactical Tracking System',
                //     style: TextStyle(
                //         fontSize: 25,
                //         fontWeight: FontWeight.w700,
                //         color: Colors.black),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                ,
                SizedBox(height: 0),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Active Mission',
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                ),
                const Divider(
                  height: 5,
                  color: Colors.black,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.directions,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Profile',
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => rutbesizProfilePage()));
                  },
                ),
                const Divider(
                  height: 5,
                  color: Colors.black,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.map,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Layers',
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => rutbesizLayerPage()));
                  },
                ),
                const Divider(
                  height: 12,
                  color: Colors.black,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.aspect_ratio_rounded,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Areas',
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => rutbesizAreaPage()));
                  },
                ),
                const Divider(
                  height: 5,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(35.0), //app bar yuksekligi.
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green[800],
          //backgroundColor: Colors.transparent,
          elevation: 0.8,
          title: const Text(
            'Active Mission',
            style: TextStyle(
              fontFamily: 'Fredoka',
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          //App bar'a basinca yandan menu acilmasi.
          leading: new IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
        ),
      ),

      ////////////////////////////////////////////////

      //////////////////////////////////////////////
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _buildCompass(),
          _printMapAppBar(),
        ],
      ),

      //floationg action button'u haraket ettirdik.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          SpeedDial(icon: Icons.add, backgroundColor: Colors.amber, children: [
        SpeedDialChild(
          child: const Icon(Icons.map),
          label: 'None Map',
          //Operation 1/1.000.000
          labelStyle: TextStyle(
            color: Colors.grey[1000],
            fontSize: 13,
          ),
          backgroundColor: Colors.amberAccent,
          onTap: () {
            setState(() {
              this._currentMapType = MapType.none;
            });
          },
        ),
        SpeedDialChild(
            child: const Icon(Icons.map),
            label: 'Satellite Map',
            //Agean Operation 1/500.000
            labelStyle: TextStyle(
              color: Colors.grey[1000],
              fontSize: 13,
            ),
            backgroundColor: Colors.amberAccent,
            onTap: () {
              setState(() {
                this._currentMapType = MapType.satellite;
              });
            }),
        SpeedDialChild(
          child: const Icon(Icons.map),
          label: 'Terrain Map',
          //
          labelStyle: TextStyle(
            color: Colors.grey[1000],
            fontSize: 13,
          ),
          backgroundColor: Colors.amberAccent,
          onTap: () {
            setState(() {
              this._currentMapType = MapType.terrain;
            });
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.reply),
          label: 'Reset',
          labelStyle: TextStyle(
            color: Colors.grey[1000],
            fontSize: 13,
          ),
          backgroundColor: Colors.amberAccent,
          onTap: () {
            setState(() {
              this._currentMapType = MapType.normal;
            });
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.zoom_in),
          label: zoomLabel,
          labelStyle: TextStyle(
            color: Colors.grey[1000],
            fontSize: 12,
          ),
          backgroundColor: Colors.amberAccent,
          onTap: () {
            sayac++;
            if (sayac % 2 == 1) {
              //sayac tek ise zoom yapabil.
              zoomLabel = 'Zoom In Zoom Out Enable';
              zoomAyar = 1;
            } else {
              zoomAyar = 2;
              zoomLabel = 'Zoom In Zoom Out Disable';
            }
          },
        ),
      ]),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    late GoogleMapController _controller;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: _initialcameraposition),
            //Zoom yapip, yapmamayi saglar.
            zoomGesturesEnabled: makeZoom,

            //Sagdaki Zoom In Zoom Out tuslarinin gorunurlugu.
            zoomControlsEnabled: false,
            mapType: _currentMapType,
            markers: markers,
            //onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            polygons: _polygons,
            polylines: myPolyline.toSet(),

            //circles: circles,
            //markers: markers,

            tiltGesturesEnabled: true,

            onMapCreated: (GoogleMapController _cntlr) {
              _controller = _cntlr;
              _location.enableBackgroundMode(enable: true);
              _location.onLocationChanged.listen((l) {
                switch (zoomAyar) {
                  case 1:
                    {
                      //zoomAyar = 1 olunca zoom yapilabilecek ama haraket edince kamera haraket etmeyecek.
                      l.latitude;
                      l.longitude;
                    }
                    break;

                  case 2:
                    {
                      //zoomAyar = 2 olunca zoom yapilayamayacak ama haraket edince kamera haraket etcek.
                      _controller.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: LatLng(l.latitude!, l.longitude!),

                              //zoom:20

                              zoom: zoomlevel),
                        ),
                      );
                    }
                    break;
                  case 3:
                    {
                      addMarkers();
                      //zoomAyar = 2 olunca zoom yapilayamayacak ama haraket edince kamera haraket etcek.
                      _controller.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: LatLng(l.latitude!, l.longitude!),
                              //zoom:20

                              zoom: zoomlevel),
                        ),
                      );
                    }
                    break;
                  default:
                    {}
                    break;
                }

                newLat = tempLat;
                newLong = tempLong;
                tempLat = l.latitude;
                tempLong = l.longitude;

                //set state ile biz konumlarin her aliminda fonksiyonu guncelliyoruz ve her defasinda konumda haraket ettikce, degisen latitude ve longitude bilgilerinin guncel degerlerini yazdiriyoruz.
                setState(() {
                  initLat = l.latitude;
                  initLong = l.longitude;
                });
              });
            },
          ),
        ],
      ),
    );
  }

  //Pusla Derecesiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Hata : ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        }
        double? direction = snapshot.data!.heading;
        if (direction == null)
          return const Center(
            child: const Text("Cihazin sensoru yok !"),
          );
        ang = (direction.round());
        return Stack(
          children: [
            Container(
              child: Transform.rotate(
                angle: ((direction) * (3.1415926535897932 / 180) * -1),
                //child: Image.asset('assets/compass.png'),
              ),
            ),
            //Center ile sayfanin ortasinda deger gorunuyor teyit etmek icin kodu acabilirsin.
            /*Center(
              child: Text(
                "$ang",
                style: TextStyle(
                  color: Color(0xFFEBEBEB),
                  fontSize: 56,
                ),
              ),
            ),*/
            //////////////////
            /*
            Positioned(
              left: (width / 2) - ((width / 80) / 2),
              top: (height - width) / 2,
              child: SizedBox(
                width: width / 80,
                height: width / 10,
                child: Container(
                  //color: HSLColor.fromAHSL(0.85, 0, 0, 0.05).toColor(),
                  color: Color(0xBBEBEBEB),
                ),
              ),
            ),
            */
          ],
        );
      },
    );
  }
  ////////////////////////////////////////////////////

  //Speed Compass Location bilgilerinin containerlariiiiii

  Widget _printMapAppBar() {
    final Size size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context)
        .size
        .width; //Ekran yüzdesine göre boyutlandırmak için genişlik
    double screenHeight = MediaQuery.of(context)
        .size
        .height; // Ekran yüzdesine göre boyutlandırmak için yükseklik
    return Align(
      alignment: Alignment.topRight,
      child: Stack(
        children: [
          Container(
            //padding: EdgeInsets.only(right: 8.5, left: 8.5),
            //padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, //Yukarıdaki hız pusula vs değerlerinin boşluğunu ayarlıyor
                  children: [
                    Container(
                      padding: new EdgeInsets.only(top: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.speed_rounded,
                            color: Colors.green[800],
                            size: 25.0,
                          ),
                          new Text(
                            '${_speed.toInt()}',
                            style: const TextStyle(
                                fontSize: 16.50,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      width: screenWidth * 0.33,
                      height: 60.0,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1,
                            offset: Offset(3.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: new EdgeInsets.only(top: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.explore_outlined,
                            color: Colors.green[800],
                            size: 25.0,
                          ),
                          new Text(
                            '${ang}°',
                            style: const TextStyle(
                                fontSize: 14.50,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      width: screenWidth * 0.33,
                      height: 60.0,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1,
                            offset: Offset(3.0, 2.0),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(top: 1.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.green[800],
                            size: 25.0,
                          ),
                          if (initLat != null && initLong != null)
                            Text(
                              'Lat:${initLat.toStringAsFixed(6)} \n Lon:${initLong.toStringAsFixed(6)}',
                              style: const TextStyle(
                                  fontSize: 14.50,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ),
                      width: screenWidth * 0.33,
                      height: 60.0,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1,
                            offset:
                                Offset(0.0, 2.0), //Sadece sağına ekliyor gölge
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
//////////////////////////////////////////////////
}

/* This dart file contains the map page which displays the
user's current location as well as the surrounding carparks */

import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:geolocation/geolocation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:sgparking/control/carpark_info_ctr.dart';
import 'package:provider/provider.dart';
import '../entity/carpark.dart';
import '../entity/carpark.dart';
import 'search_display_page_map.dart';
const apiKey = "AIzaSyAnqOmXifNMFXXdASb1zMJRa7PHB9AmrBQ";



class Maps extends StatefulWidget {
//  final Data data4 = ModalRoute.of(context).settings.arguments;
//  Maps({this.data4});


  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {

  BitmapDescriptor pinLocationIcon;
  GoogleMapController _controller; //Googlemap controller
  Geolocator geolocator = Geolocator();
//  CarparkController _mapsController = new CarparkController();
  Marker marker;
  Circle circle;
  double zoomVal = 10.0;
  final LatLng _intialPos = const LatLng(1.340165306, 103.675497298);
  final LatLng _lastPos = const LatLng(1.2966, 103.7764);
  LatLng source;

  Set<Marker> _markers = {};
  Set<Polyline> _polyLines = {};
  @override
  void initState(){

    super.initState();
    setCustomMapPin();
  }

  Widget _showMarkers()  {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(Icons.zoom_out),
          onPressed: () {
            CarparkController _mapsController = new CarparkController();
            Future <List<CarparkInfo>> testest;
            testest = _mapsController.fetchNotes(1);
            int counter = 1;
            double _distanceSet = 3000.0;
            LatLng _initialLocation = new LatLng(1.340165306, 103.675497298);
            _addMarkerPivot(_initialLocation);
            testest.then((results){
              print(results.length);
              for (var i in results){
                LatLng coordinates = new LatLng(i.lat,i.lng);
                print(coordinates);
                Future<double> distanceInMeters = Geolocator().distanceBetween(1.340165306, 103.675497298, i.lat, i.lng);
                distanceInMeters.then((resultss){
                  print(resultss);
                  if (resultss < _distanceSet) {
                    setState(() {
                      _addMarker(coordinates);
                      _markers.add(Marker(
                          markerId: MarkerId("$counter"),
                          position: coordinates,
                          draggable: false,
                          zIndex: 2,
                          flat: true,
                          anchor: Offset(0.4, 0.4),
                          icon: BitmapDescriptor.defaultMarker));
                      counter++;
                    });

                  }
                });


              }

            });


          }),
    );
  }

  // TODO add centering function to current gps location
  //TODO search radius around current location pin
  //TODO dynamic creation of markers
  //TODO route creation using dummy coords

  @override
  Widget build(BuildContext context) {
    final Data data4 = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps Sample App'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching),
          onPressed: () async {
            if (data4 != null) {
              getCurrentLocation();
              while (true) {
                getCurrentLocation2();
                updateMarkerAndCircle2(source);
                sendRequests(data4.initialLoc, source);

                await new Future.delayed(const Duration(seconds: 1));
              }
            }
            else{
              getCurrentLocation();
              sendRequests(_lastPos,_intialPos);
            }
          }),
      body: Stack(
          children: <Widget>[
            _buildGoogleMaps(context),
            _showMarkers()
            // _zoomminusfunction(), _zoomplusfunction()
          ]
      ),
    );
  }

  Container _buildGoogleMaps(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        markers: _markers,
        circles: Set.of((circle != null) ? [circle] : []),
        zoomGesturesEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,
        mapType: MapType.normal,
        polylines: _polyLines,
        initialCameraPosition: CameraPosition(
          target: _intialPos,
          zoom: 10.0,
        ),
      ),
    );
  }
  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/car.png');
  }

  void getCurrentLocation() async {
    try {
      Position location = await Geolocator()  //constructing geolocator object to call current position
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemark = await Geolocator()
          .placemarkFromCoordinates(location.latitude, location.longitude); //getting the current address from the coordinates if needed to display
      print(location);
      print('test test test');
      updateMarkerAndCircle(location); //updates marker position with new location

//      var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
//      Geolocator().getPositionStream(locationOptions).listen((Position position){  //creating a location stream
//        if (_controller != null) {
//          _controller.moveCamera(CameraUpdate.newCameraPosition(new CameraPosition(
//              bearing: 192.8334901395799,
//              target: LatLng(position.latitude, position.longitude),
//              tilt: 0,
//              zoom: 18.00)));
//          updateMarkerAndCircle(position);
//        }
//      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  void getCurrentLocation2() async {
    try {
      Position locationUpdate = await Geolocator()  //constructing geolocator object to call current position
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        source = LatLng(locationUpdate.latitude, locationUpdate.longitude);
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }

  }
  void updateMarkerAndCircle(Position newLocalData) { //takes new location data and image
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);//LatLng(newLocalData.latitude, newLocalData.longitude);
    _controller.moveCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: latlng,
        tilt: 0,
        zoom: 12.00)));
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.1, 0.5),
          icon: pinLocationIcon));
      circle = Circle(
          circleId: CircleId("car"),
          radius: 3,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });






    /*Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _center, zoom: zoomVal)));
  }
  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _center, zoom: zoomVal)));
  }*/

    //Loading car assets



  }
  // ! CREATE LAGLNG LIST

  void updateMarkerAndCircle2(LatLng input) { //takes new location data and image
    LatLng latlng = input;//LatLng(newLocalData.latitude, newLocalData.longitude);
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: latlng.latitude,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.1, 0.5),
          icon: pinLocationIcon));
      circle = Circle(
          circleId: CircleId("car"),
          radius: 3,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });

  }



  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  // !DECODE POLY
  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
// repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

/*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }
  void _addMarker(LatLng location) async {
    _markers.add(Marker(
        markerId: MarkerId("destination"),

        position: location,
        infoWindow: InfoWindow(title: "address of destination", snippet: "go here"),
        icon: BitmapDescriptor.defaultMarker));
//    _markers.push(marker);
  }

  void _addMarkerPivot(LatLng location) async {
    _markers.add(Marker(
        markerId: MarkerId("Pivot"),

        position: location,
        infoWindow: InfoWindow(title: "address of destination", snippet: "go here"),
        icon: BitmapDescriptor.defaultMarker));
//    _markers.push(marker);
  }


  void createRoute(String encodedPoly){
    setState(() {
      _polyLines.add(Polyline(polylineId: PolylineId("address"),color: Colors.blueAccent, width: 3,
          points: _convertToLatLng(_decodePoly(encodedPoly))));
    });
  }
  void sendRequests(LatLng destination, LatLng source) async{
    //LatLng destination = LatLng(position.latitude, position.longitude);
    _addMarker(destination);
    String route = await getRouteCoordinates(source, destination);
    print(route);
    createRoute(route);
    print("created route");
  }

  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    print("getting coords");
    String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }


/*Marker NTU = Marker(
    markerId: MarkerId('ntu'),
    position: LatLng(1.3483, 103.6831),
    infoWindow: InfoWindow(title: 'Los Tacos'),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet,
    ),
  );*/

//Widget _showMarkers() {
//    return Align(
//      alignment: Alignment.topLeft,
//      child: IconButton(
//          icon: Icon(Icons.zoom_out),
//          onPressed: () {
//            CarparkController _mapsController = new CarparkController();
//            Future <List<CarparkInfo>> testest;
//            testest = _mapsController.fetchNotes(1);
//            testest.then((results){
//              print(results.length);
//              for (var i in results){
//                LatLng coordinates = new LatLng(i.xCoord,i.yCoord);
//                _addMarker(coordinates);
//              }
//
//            });
//
//
//          }),
//    );
//}
//  Widget _zoomplusfuncti
//on() {
//    return Align(
//      alignment: Alignment.topRight,
//      child: IconButton(
//          icon: Icon(Icons.zoom_in),
//          onPressed: () {
//            zoomVal++;
//            _plus(zoomVal);
//          }),
//    );
//  }
  //_addMarker(){
  //  var marker = MarkerOptions(
  //    positions: ...
  //  )
 // }
  /*
 getCurrentLocation() async {
    var location = new Location();
    LatLng latLng;
    location.onLocationChanged().listen((currentLocation) {
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      setState(() {
        latLng =  LatLng(currentLocation.latitude, currentLocation.longitude);
      });
      print("getLocation: $latLng ");
    });
  }
//  */
}
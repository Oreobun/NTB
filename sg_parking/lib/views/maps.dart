import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:geolocation/geolocation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';


class Maps extends StatefulWidget {

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  BitmapDescriptor pinLocationIcon;
  GoogleMapController _controller; //Googlemap controller
  Geolocator geolocator = Geolocator();
  Marker marker;
  Circle circle;
  double zoomVal = 10.0;
  final LatLng _center = const LatLng(1.3521, 103.8198);
  @override
  void initState(){
    super.initState();
    setCustomMapPin();
  }

  // TODO add centering function to current gps location
  //TODO search radius around current location pin
  //TODO dynamic creation of markers
  //TODO route creation using dummy coords

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps Sample App'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching),
          onPressed: () {
            getCurrentLocation();
          }),
      body: Stack(
          children: <Widget>[
            _buildGoogleMaps(context)
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
        markers: Set.of((marker != null) ? [marker] : []),
        circles: Set.of((circle != null) ? [circle] : []),
        zoomGesturesEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _center,
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
      print(location);
      print('test test test');
      updateMarkerAndCircle(location); //updates marker position with new location

      var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
      Geolocator().getPositionStream(locationOptions).listen((Position position){  //creating a location stream
        if (_controller != null) {
          _controller.moveCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(position.latitude, position.longitude),
              tilt: 0,
              zoom: 18.00)));
          updateMarkerAndCircle(position);
        }
      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }
  void updateMarkerAndCircle(Position newLocalData) { //takes new location data and image
    LatLng latlng = LatLng(1.3521, 103.8198);//LatLng(newLocalData.latitude, newLocalData.longitude);
    _controller.moveCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        bearing: 192.8334901395799,
        target: latlng,
        tilt: 0,
        zoom: 18.00)));
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: pinLocationIcon);
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

/*Marker NTU = Marker(
    markerId: MarkerId('ntu'),
    position: LatLng(1.3483, 103.6831),
    infoWindow: InfoWindow(title: 'Los Tacos'),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet,
    ),
  );*/

/*Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(Icons.zoom_out),
          onPressed: () {
            zoomVal--;
            _minus( zoomVal);
          }),
    );
  }
  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(Icons.zoom_in),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }
  //_addMarker(){
  //  var marker = MarkerOptions(
  //    positions: ...
  //  )
 // }
 /*getCurrentLocation() async {
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
  }*/
*/
}
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


const apiKey = "AIzaSyAnqOmXifNMFXXdASb1zMJRa7PHB9AmrBQ";

class DistanceController{


  void getDistance({LatLng source, LatLng destination})async{
  Dio dio = new Dio();
  Response response = await dio.get("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=40.6655101,-73.89188969999998&destinations=40.6905615%2C,-73.9976592&key=$apiKey");
  print('getiing distance:');
  print(response.data);
  }
}
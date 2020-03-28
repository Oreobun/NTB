import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


const apiKey = "AIzaSyAQC-XS_ETqUY0eE6yxeL443vg59q91qK0";

class DistanceController{


  void getDistance({LatLng source, LatLng destination})async{
    Dio dio = new Dio();
    Response response = await dio.get("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=1.341786,103.826009&destinations=1.332747%2C,103.919106&key=$apiKey");
    print('getiing distance:');
    print(response.data.toString());
  }
}
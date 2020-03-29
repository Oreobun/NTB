/* This controller class calls our database built on Laravel, a PHP-based database
while using Amazon Web Service's Elastic Beanstalk as a deployment service.
It returns a list of carpark information from the JSON files fetched from the API calls,
and also allows for optional sorting by available lots and address.
*/

import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sgparking/entity/carpark.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;


class CarparkController {

  var notes = List<CarparkInfo>();

  Future<List<CarparkInfo>> fetchNotes(int sortNum) async {
    // Sets up an API call to AWS Elastic Beanstalk
//    var url = 'http://url';
//    var response = await http.get(url);

    String data = await rootBundle.loadString('assets/carpark_data.json');
    var jsonResult = json.decode(data);
    print('test result');
    print(jsonResult);
    for (int i = 0; i < jsonResult.length; i++) {
      var result = CarparkInfo.fromJson(jsonResult[i]);
      notes.add(result);
    }
    Position location = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    for (int i = 0; i < notes.length; i++) {
      Future<double> distanceInMeters = Geolocator().distanceBetween(location.latitude, location.longitude, notes[i].lat, notes[i].lng);
      distanceInMeters.then((value){
        notes[i].carParkDecks = value.toInt();
      });
    }

    // Logic to proceed after a successful API call
//    if (response.statusCode == 200) {
//      var notesJson = json.decode(response.body);
//      for (int i = 0; i < notesJson.length; i++) {
//        var result = CarparkInfo.fromJson(notesJson[i]);
//        notes.add(result);
//      }
      notes.removeWhere((item) => item.availableLots == -1);
//      notes = result as List<CarparkInfo>;
//      print(notes.length);
//      Comparator<CarparkInfo> lotsComparator = (a,b) => int.parse(a.totalLots).compareTo(int.parse(b.totalLots));
//      notes.sort(lotsComparator);


//    }
    return notes;
  }

  List<CarparkInfo> getSortedList(){

    return notes;
  }

}
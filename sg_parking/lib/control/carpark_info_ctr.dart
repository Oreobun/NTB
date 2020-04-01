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
    var url = 'http://noturningbac-env.eba-qa2gpmhs.ap-southeast-1.elasticbeanstalk.com/api/get_carparks_info';
    var response = await http.get(url);

//    String data = await rootBundle.loadString('assets/carpark_data.json');

    if (response.statusCode == 200) {
      var jsonResult = json.decode(response.body);
      for (int i = 0; i < jsonResult.length; i++) {
        var result = CarparkInfo.fromJson(jsonResult[i]);
        notes.add(result);
      }
    }
    else {
      String data = await rootBundle.loadString('assets/carpark_data.json');
      var test = json.decode(data);
      for (int i = 0; i < test.length; i++) {
        var result = CarparkInfo.fromJson(test[i]);
        notes.add(result);
      }
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
/* This controller class calls our database built on Laravel, a PHP-based database
while using Amazon Web Service's Elastic Beanstalk as a deployment service.
It returns a list of carpark information from the JSON files fetched from the API calls,
and also allows for optional sorting by available lots and address.
*/

import 'dart:async';
import 'dart:convert';
import 'package:sgparking/entity/carpark.dart';
import 'package:http/http.dart' as http;


class CarparkController {
  Future<List<CarparkInfo>> fetchNotes(int sortNum) async {
    // Sets up an API call to AWS Elastic Beanstalk
    var url = 'http://ntb-rest-api.us-east-2.elasticbeanstalk.com/api/get_carparks_info';
    var response = await http.get(url);
    var notes = List<CarparkInfo>();

    // Logic to proceed after a successful API call
    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (int i = 0; i < notesJson.length; i++) {
        var result = CarparkInfo.fromJson(notesJson[i]);
        notes.add(result);
      }
//      notes = result as List<CarparkInfo>;
//      print(notes.length);
//      Comparator<CarparkInfo> lotsComparator = (a,b) => int.parse(a.totalLots).compareTo(int.parse(b.totalLots));
//      notes.sort(lotsComparator);

      if (sortNum == -1){
        // Signals to controller class to return unsorted car park information
      }
      else if (sortNum == 0){
        // Logic to return car parks sorted by total lots
      }
      //Logic to return car parks sorted by available lots
      else if (sortNum == 1){
        Comparator<CarparkInfo> lotsComparator1 = (a,b) => (a.availableLots).compareTo((b.availableLots));
        notes.sort(lotsComparator1);
      }

      //Logic to return car parks sorted by address
      else if (sortNum == 2) {
        Comparator<CarparkInfo> lotsComparator2 = (a,b) => a.address.compareTo((b.address));
        notes.sort(lotsComparator2);
      }
    }
    return notes;
  }


}
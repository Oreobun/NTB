import 'dart:async';
import 'dart:convert';
import 'package:sgparking/entity/carpark.dart';
import 'package:http/http.dart' as http;


class CarparkController {
  Future<List<CarparkInfo>> fetchNotes(int sortNum) async {
    var url = 'http://ntb-rest-api.us-east-2.elasticbeanstalk.com/api/get_carparks_info';
    var response = await http.get(url);
    var notes = List<CarparkInfo>();
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
      // do noting
    }
    else if (sortNum == 0){
      // kiv
    }
    else if (sortNum == 1){
      Comparator<CarparkInfo> lotsComparator1 = (a,b) => (a.availableLots).compareTo((b.availableLots));
      notes.sort(lotsComparator1);
    }
    else if (sortNum == 2) {
      Comparator<CarparkInfo> lotsComparator2 = (a,b) => a.address.compareTo((b.address));
      notes.sort(lotsComparator2);
    }
    }
    return notes;
  }


}
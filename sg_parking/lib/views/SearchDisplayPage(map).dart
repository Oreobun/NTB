import 'dart:async';
import 'dart:convert';
import 'package:sgparking/entity/Carpark.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ReportPage.dart';
import 'SortPage.dart';
class SearchMap extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SearchMap> {
  String _howAreYou = '...';
  List<CarparkInfo> _notes = List<CarparkInfo>();
  List<CarparkInfo> _notesForDisplay = List<CarparkInfo>();

  Future<List<CarparkInfo>> fetchNotes() async {
    var url = 'https://api.data.gov.sg/v1/transport/carpark-availability';
    var response = await http.get(url);

    var notes = List<CarparkInfo>();

    if (response.statusCode == 200) {
      print("test test");
      var notesJson = json.decode(response.body);
      var test = Response.fromJson(notesJson);
      print("test test");
      var ha = test.items[0];
      for (var noteJson in ha.carparkData) {
        notes.add(noteJson.carparkInfo[0]);
      }
      print(notes.length);
      Comparator<CarparkInfo> lotsComparator = (a,b) => int.parse(a.totalLots).compareTo(int.parse(b.totalLots));
      notes.sort(lotsComparator);
    }
    return notes;
  }

  void _openReportPage({BuildContext context, bool fullscreenDialog = false}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: fullscreenDialog,
        builder: (context) => Report(),
      ),
    );
    // Navigator.pushNamed(context, '/about');
  }


  void _openPageSort(
      {BuildContext context, bool fullscreenDialog = false}) async {
    final String _gratitudeResponse = await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: fullscreenDialog,
        builder: (context) => Sort(
          radioGroupValue: -1,
        ),
      ),
    );
    _howAreYou = _gratitudeResponse ?? '';
  }

  /* alert dialog pop out */
//
//  Future<void> _neverSatisfied() async {
//    return showDialog<void>(
//      context: context,
//      barrierDismissible: false, // user must tap button!
//      builder: (BuildContext context) {
//        return AlertDialog(
//          title: Text('Rewind and remember'),
//          content: SingleChildScrollView(
//            child: ListBody(
//              children: <Widget>[
//                Text('You will never be satisfied.'),
//                Text('You\’re like me. I’m never satisfied.'),
//              ],
//            ),
//          ),
//          actions: <Widget>[
//            FlatButton(
//              child: Text('Regret'),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }



  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
        _notesForDisplay = _notes;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Carpark Search'),
          backgroundColor: Colors.blue[900],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.report),
              onPressed: () => _openReportPage(
                context: context,
                fullscreenDialog: true,
              ),
            ),
          ],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return index == 0 ? _searchBar() : _listItem(index-1);
          },
          itemCount: _notesForDisplay.length+1,
        )
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        child: TextField(
          decoration: InputDecoration(
              hintText: 'Search...',
              suffixText: 'sort',
              suffixIcon: IconButton(
              onPressed: () => _openPageSort(
                context: context,
                fullscreenDialog: false,
              ),
              icon: Icon(Icons.sort),
                tooltip: 'sort',
            ),
              prefixText: 'filter             ',
              prefixIcon: IconButton(
              icon: Icon(Icons.filter_list),
                tooltip: 'filter',

            ),
          ),
          onChanged: (text) {
            text = text.toLowerCase();
            setState(() {
              _notesForDisplay = _notes.where((note) {
                var note2 = note.totalLots.toString();
                var noteTitle = note2.toLowerCase();
                return noteTitle.contains(text);
              }).toList();
            });
          },
        ),

      ),
    );
  }

  _listItem(index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
             'Total lots = ' + _notesForDisplay[index].totalLots,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900
              ),
            ),
            Text(
              'Lots available = ' + _notesForDisplay[index].lotsAvailable,
              style: TextStyle(
                  color: Colors.grey.shade800
              ),
            ),
            Text(
              'Lot type = ' + _notesForDisplay[index].lotType,
              style: TextStyle(
                  color: Colors.grey.shade800
              ),
            ),
          ],
        ),
      ),
    );
  }
}
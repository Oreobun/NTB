import 'dart:async';
import 'dart:convert';
import 'package:sgparking/entity/Carpark.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//void main() => runApp(App());
//
//class App extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: HomePage(),
//    );
//  }
//}

class SearchMap extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SearchMap> {

  List<CarparkInfo> _notes = List<CarparkInfo>();
  List<CarparkInfo> _notesForDisplay = List<CarparkInfo>();

  Future<List<CarparkInfo>> fetchNotes() async {
    print("test test");
    var url = 'https://api.data.gov.sg/v1/transport/carpark-availability';
    var response = await http.get(url);

    var notes = List<CarparkInfo>();

    if (response.statusCode == 200) {
      print("test test");
      var notesJson = json.decode(response.body);
      var a = notesJson.items[0].carparkData;
      int counter = notesJson.items[0].carparkData.length;
      print("test test");
      for (var noteJson in a) {
        notes.add(CarparkInfo.fromJson(noteJson));
      }
    }
    return notes;
  }

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
          title: Text('Flutter listview with json'),
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
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Search...'
        ),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _notesForDisplay = _notes.where((note) {
              var noteTitle = note.totalLots.toLowerCase();
              return noteTitle.contains(text);
            }).toList();
          });
        },
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
              _notesForDisplay[index].totalLots,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              _notesForDisplay[index].lotsAvailable,
              style: TextStyle(
                  color: Colors.grey.shade600
              ),
            ),
          ],
        ),
      ),
    );
  }
}
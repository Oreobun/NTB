/*This class contains the interface for our search function in list view.
* The class will be able to navigate to the filter/sort page and has the main search function for user
* to perform a search. Furthermore, it will allow the user to see the shortest route to a particular carpark.
* This will be the main functionality of the project, whereby user can use this page to perform search through the government API  */
import 'dart:async';
import 'package:sgparking/entity/carpark.dart';
import 'package:flutter/material.dart';
import 'report_page.dart';
import 'sort_page.dart';
import 'maps.dart';
import 'package:sgparking/control/carpark_info_ctr.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchMap extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SearchMap> {
  int sortResult = -1;
  String _howAreYou = '...';
  List<CarparkInfo> _notes = List<CarparkInfo>();
  List<CarparkInfo> _notesForDisplay = List<CarparkInfo>();
  CarparkController carparkController = new CarparkController();

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


  Future navigateToSubPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Maps()));
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
    print('test test');
    print(_howAreYou);
    setState(() {
      if (_howAreYou == "Distance"){
        sortResult = -1;
      }
      else if (_howAreYou == "availableLots"){
        sortResult = 2;
        print('test test 45');
      }
      else if (_howAreYou == 'Alphebet'){
        sortResult = 3;
      }
    });
  }


  @override
  void initState() {

    print('test test 4');

    fetchNotes(sortResult).then((value) {
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
              tooltip: 'report',
              color: Colors.red[900],
              splashColor: Colors.redAccent,
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
                var note2 = note.address;
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
             'Location = ' + _notesForDisplay[index].address,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900
              ),
            ),
            Text(
              'Lots available = ' + _notesForDisplay[index].availableLots.toString(),
              style: TextStyle(
                  color:  _notesForDisplay[index].availableLots == -1 ? Colors.red : _notesForDisplay[index].availableLots/_notesForDisplay[index].totalLots < 0.7 ? ((_notesForDisplay[index].availableLots/_notesForDisplay[index].totalLots < 0.3) )? Colors.red :Colors.orange : Colors.green
              ),
            ),
            Text(
              'Lot type = ' + _notesForDisplay[index].carParkType + '\nParking system = ' + _notesForDisplay[index].typeOfParkingSystem+ '\nShort term parking = ' + _notesForDisplay[index].shortTermParking,
              style: TextStyle(
                  color: Colors.grey.shade800
              ),
            ),

              ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blueAccent,
                    child: const Text('Get direction'),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    textColor: Colors.white,
                    onPressed: () {
                      navigateToSubPage(context);
                    },
                  ),
                ],
              ),

          ],
        ),

      ),
    );
  }
}
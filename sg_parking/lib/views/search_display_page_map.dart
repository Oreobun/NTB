/*This class contains the interface for our search function in list view.
* The class will be able to navigate to the filter/sort page and has the main search function for user
* to perform a search. Furthermore, it will allow the user to see the shortest route to a particular carpark.
* This will be the main functionality of the project, whereby user can use this page to perform search through the government API  */
import 'dart:async';
//import 'dart:html';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgparking/entity/carpark.dart';
import 'package:flutter/material.dart';
import 'report_page.dart';
import 'sort_page.dart';
import 'maps.dart';
import 'package:sgparking/control/carpark_info_ctr.dart';
import 'package:sgparking/control/distance_ctr.dart';
import 'filter.dart';
import 'dart:convert';
import 'package:sgparking/entity/carpark.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

class Data {
  LatLng initialLoc;
  List<CarparkInfo> carparkList;
  Data ({this.initialLoc, this.carparkList});
}



class SearchMap extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SearchMap> {
  int sortResult = -1;
  String _howAreYou = '...';
  List<CarparkInfo> _notes = List<CarparkInfo>();
  var notes = List<CarparkInfo>();
  static List<CarparkInfo> _notesForDisplay = List<CarparkInfo>();
  CarparkController carparkController = new CarparkController();
  DistanceController distanceGet = new DistanceController();
  List<double> carparkDistance;
  var source;
  static List<int> test;
  List<int> testList =[];
  loadJson() async {
    String data = await rootBundle.loadString('assets/carpark_data.json');
    var jsonResult = json.decode(data);
    print('test result');
    print(jsonResult);
    for (int i = 0; i < jsonResult.length; i++) {
      var result = CarparkInfo.fromJson(jsonResult[i]);
      notes.add(result);
    }
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


  Future navigateToSubPage(context, LatLng source) async {
    final data = Data(initialLoc : source);
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Maps(),
        settings:  RouteSettings(
          arguments: data,
        ),

    ));
  }

  void _openPageSort(
      {BuildContext context, bool fullscreenDialog = false, List<CarparkInfo> input }) async {
    final data = Data(carparkList: input);
    final List<CarparkInfo> _notes2 = await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: fullscreenDialog,
        settings:  RouteSettings(
          arguments: data,
        ),
        builder: (context) => Sort(
          radioGroupValue: -1,

        ),
      ),
    );

      if (_notes2 != null) {
        setState(() {
          _notesForDisplay = _notes2;
          _notes = _notes2;
        });
      }

  }


  void _openPageFilter(
      {BuildContext context, bool fullscreenDialog = false, List<CarparkInfo> input}) async {
    final data = Data(carparkList: input);
    final List<int> _notes3 = await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: fullscreenDialog,
        settings:  RouteSettings(
          arguments: data,
        ),
        builder: (context) => SliderContainer(

        ),
      ),
    );

    if (_notes3 != null) {
      setState(() => test = _notes3);
      print("the returning list has length:");
      print(_notes3.length);
    }
  }

  void slotDistance()async{
    Position locationUpdate = await Geolocator()  //constructing geolocator object to call current position
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      source = LatLng(locationUpdate.latitude, locationUpdate.longitude);
    });

  }

  @override
  void initState()  {
    test = [];
    print("test1");
    slotDistance();
    carparkController.fetchNotes(sortResult).then((value) {
      setState(() {
        print("test2");
        _notes.addAll(value);
        print("test3");
        Timer(Duration(seconds: 2), () {
          print("test4");
        for (var i in _notes) {
          Future<double> distanceInMeters = Geolocator().distanceBetween(source.latitude, source.longitude, i.lat, i.lng);
          distanceInMeters.then((result){
            i.carParkDecks = result.toInt();
          });
        }
          print("test5");
        });
        _notesForDisplay = _notes;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          title: Text('      Carpark Search'),
//          backgroundColor: Colors.blue[900],
//          actions: <Widget>[
//            IconButton(
//              tooltip: 'report',
//              color: Colors.red[900],
//              splashColor: Colors.redAccent,
//              icon: Icon(Icons.report),
//              onPressed: () => _openReportPage(
//                context: context,
//                fullscreenDialog: true,
//              ),
//            ),
//          ],
//        ),
        body: Center(
          child: Container(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return index == 0 ? _searchBar() : _listItem(index-1);
              },
              itemCount: _notesForDisplay.length+1,
            ),
          ),
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
              suffixIcon: IconButton(
              onPressed: () => _openPageSort(
                context: context,
                fullscreenDialog: false,
                input: _notesForDisplay,
              ),
              icon: Icon(Icons.sort),
                tooltip: 'sort',
            ),
              prefixIcon: IconButton(
                onPressed: () => _openPageFilter(
                  context: context,
                  fullscreenDialog: false,
                  input: _notesForDisplay,
                ),
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
    print("final test");
    print(test.length);
    return (test.contains(_notesForDisplay[index].iId) == false) ?
     new Card(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 20.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _notesForDisplay[index].address,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Distance: ' +
                          _notesForDisplay[index].carParkDecks.toString() +
                          'm',
                      style: TextStyle(
                          color: Colors.grey.shade800
                      ),
                    ),
                    Text(
                      'Gantry height: ' +
                          _notesForDisplay[index].gantryHeight.toString() +
                          'm',
                      style: TextStyle(
                          color: Colors.grey.shade800
                      ),
                    ),
                    Text(
                      'Lots available: ' +
                          _notesForDisplay[index].availableLots.toString(),
                      style: TextStyle(
                          color: _notesForDisplay[index].availableLots == -1
                              ? Colors.red
                              : _notesForDisplay[index].availableLots /
                              _notesForDisplay[index].totalLots < 0.7
                              ? ((_notesForDisplay[index].availableLots /
                              _notesForDisplay[index].totalLots < 0.3))
                              ? Colors.red
                              : Colors.orange
                              : Colors.green
                      ),
                    ),
                    Text(
                      'Lot type: ' + _notesForDisplay[index].carParkType +
                          '\nParking system = ' +
                          _notesForDisplay[index].typeOfParkingSystem +
                          '\nShort term parking = ' +
                          _notesForDisplay[index].shortTermParking,
                      style: TextStyle(
                          color: Colors.grey.shade800
                      ),
                    ),
                  ],
                ),

                Container(
                  width: 40,
                  height: 40,
                  child: FloatingActionButton(
                    heroTag: "btn$index",
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.navigation),
                    onPressed: () {
                      navigateToSubPage(context, LatLng(
                          _notesForDisplay[index].lat,
                          _notesForDisplay[index].lng));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ) : new Row();
  }
}
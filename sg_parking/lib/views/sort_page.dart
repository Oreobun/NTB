/*This class contains the interface for our sort function.
* A sorted result of carpark information is return to the Search_display_page_map.dart.
* User can choose to sort by either available lots, distance or gantry height. */
import 'package:flutter/material.dart';
import 'package:sgparking/control/carpark_info_ctr.dart';
import 'package:sgparking/entity/carpark.dart';
import 'package:sgparking/views/search_display_page_map.dart';


class Sort extends StatefulWidget {

  final int radioGroupValue;
  SearchMap la = new SearchMap();
  Sort({Key key, @required this.radioGroupValue}) : super(key: key);

  @override
  _SortState createState() => _SortState();
}

class _SortState extends State<Sort> {
  List<String> _gratitudeList = List();
  String _selectedGratitude;
  int _radioGroupValue;
  int result;
  bool finishLoading = false;
  CarparkController carparkController = new CarparkController();
  List<CarparkInfo> _notes2 = new List<CarparkInfo>();

  void _radioOnChanged(int index, List<CarparkInfo> test)  {
    setState(() {
      _radioGroupValue = index;
      _selectedGratitude = _gratitudeList[index];
      print('_selectedRadioValue $_selectedGratitude');
//      carparkController.fetchNotes(_radioGroupValue).then((value){
//        _notes2.addAll(value);
//        finishLoading = true;
//      });
      if (index == -1){
        // Signals to controller class to return unsorted car park information
      }
      else if (index == 0){
        // Logic to return car parks sorted by distance
        Comparator<CarparkInfo> lotsComparator0 = (a,b) => (a.carParkDecks).compareTo((b.carParkDecks));
        test.sort(lotsComparator0);
        print("test1");
      }
      //Logic to return car parks sorted by available lots
      else if (index == 1){
        Comparator<CarparkInfo> lotsComparator1 = (a,b) => (a.availableLots).compareTo((b.availableLots));
        test.sort(lotsComparator1);
        print("test2");
      }

      //Logic to return car parks sorted by gantry height
      else if (index == 2) {
        Comparator<CarparkInfo> lotsComparator2 = (a,b) => a.gantryHeight.compareTo((b.gantryHeight));
        test.sort(lotsComparator2);
      }
      _notes2 = test;
      finishLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();

    _gratitudeList..add('Distance')..add('availableLots')..add('GantryHeight');
    _radioGroupValue = widget.radioGroupValue;

  }

  @override
  Widget build(BuildContext context) {
    final Data data4 = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sort'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              while (true) {
                if (finishLoading == true) {
                  Navigator.pop(context, _notes2);
                }
                await new Future.delayed(const Duration(seconds: 1));
              }
              },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Radio(
                    value: 0,
                    groupValue: _radioGroupValue,
                    onChanged: (index) => _radioOnChanged(index, data4.carparkList),
                  ),
                  Text('Distance'),
                  Radio(
                    value: 1,
                    groupValue: _radioGroupValue,
                    onChanged: (index) => _radioOnChanged(index, data4.carparkList),
                  ),
                  Text('availableLots'),
                  Radio(
                    value: 2,
                    groupValue: _radioGroupValue,
                    onChanged: (index) => _radioOnChanged(index, data4.carparkList),
                  ),
                  Text('GantryHeight'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
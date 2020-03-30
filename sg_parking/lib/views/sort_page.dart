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
  List<bool> isSelected = [true, false, false];
  List<String> _gratitudeList = List();
  String _selectedGratitude;
  int _radioGroupValue;
  int result;
  bool finishLoading = false;
  CarparkController carparkController = new CarparkController();
  List<CarparkInfo> _notes2 = new List<CarparkInfo>();

  void _toggleButtonChanged(int index, List<CarparkInfo> test){
    if(index == 0){
      Comparator<CarparkInfo> lotsComparator0 = (a,b) => (a.carParkDecks).compareTo((b.carParkDecks));
      test.sort(lotsComparator0);
      print("test1");
    }else if (index == 1){
      Comparator<CarparkInfo> lotsComparator1 = (a,b) => (a.availableLots).compareTo((b.availableLots));
      test.sort(lotsComparator1);
      print("test2");
    }
    else if (index == 2){
      Comparator<CarparkInfo> lotsComparator2 = (a,b) => a.gantryHeight.compareTo((b.gantryHeight));
      test.sort(lotsComparator2);
    }
    _notes2 = test;
    finishLoading = true;
  }
  /*
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
  }*/

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
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
            'Sort', style: TextStyle(
            color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.orange,
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
            padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text(
                'Sort list according to:',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ToggleButtons(
                    children: <Widget>[
                      Container(
                          width: 110,
                          height: 70,
                          padding: EdgeInsets.all(4),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.arrow_forward),
                                SizedBox(height: 1),
                                Text('Distance',textAlign: TextAlign.center),
                              ]
                          )
                      ),
                      Container(
                          width: 110,
                          height: 70,
                          padding: EdgeInsets.all(4),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.directions_car),
                                SizedBox(height: 1),
                                Text('Available Lots',textAlign: TextAlign.center),
                              ]
                          )
                      ),
                      Container(
                          width: 110,
                          height: 70,
                          padding: EdgeInsets.all(4),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.looks_two),
                                SizedBox(height: 1),
                                Text('Gantry Height',textAlign: TextAlign.center),
                              ]
                          )
                      ),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                          if (buttonIndex == index) {
                            isSelected[buttonIndex] = true;
                          } else {
                            isSelected[buttonIndex] = false;
                          }
                        }
                      });
                      _toggleButtonChanged(index, data4.carparkList);
                    },
                    isSelected: isSelected,
                  ),
                ],

                /*children: <Widget>[
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
            ],*/
              ),
            ],
          )
        ),
      ),
    );
  }
}
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

  void _radioOnChanged(int index)  {
    setState(() {
      _radioGroupValue = index;
      _selectedGratitude = _gratitudeList[index];
      print('_selectedRadioValue $_selectedGratitude');
      carparkController.fetchNotes(_radioGroupValue).then((value){
        _notes2.addAll(value);
        finishLoading = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _gratitudeList..add('Distance')..add('availableLots')..add('Alphebet');
    _radioGroupValue = widget.radioGroupValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gratitude'),
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
              Radio(
                value: 0,
                groupValue: _radioGroupValue,
                onChanged: (index) => _radioOnChanged(index),
              ),
              Text('Distance'),
              Radio(
                value: 1,
                groupValue: _radioGroupValue,
                onChanged: (index) => _radioOnChanged(index),
              ),
              Text('availableLots'),
              Radio(
                value: 2,
                groupValue: _radioGroupValue,
                onChanged: (index) => _radioOnChanged(index),
              ),
              Text('Alphebet'),
            ],
          ),
        ),
      ),
    );
  }
}
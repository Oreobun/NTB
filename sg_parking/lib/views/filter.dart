import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgparking/control/carpark_info_ctr.dart';
import 'package:sgparking/entity/carpark.dart';
import 'package:sgparking/views/search_display_page_map.dart';

class SliderContainer extends StatefulWidget{
  @override
  _SliderContainerState createState() => _SliderContainerState();
}

class _SliderContainerState extends State<SliderContainer>{
  static double _lowerValDist = 0.0; //Change these values for the starting and end points
  static double _upperValDist = 20.0;
  double _distance = 0;
  static double _lowerValPrice = 0.0;
  static double _upperValPrice = 10.0;
  double height = 0;
  static double _lowerValAvail= 0.0;
  static double _upperValAvail= 1000.0;
  double avail = 0;
  List<CarparkInfo> _notes3 = new List<CarparkInfo>();
  CarparkController carparkController = new CarparkController();
  bool finishLoading = false;
  final headingTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w800,
    fontFamily: 'Roboto',
    letterSpacing: 0.5,
    fontSize: 20,
  );

  void _onClick()  {

  }

  void filterResult(List<CarparkInfo> notes,double dis, double hgt, double avail){

    notes.removeWhere((item) => item.gantryHeight < hgt);
    notes.retainWhere((item) => item.carParkDecks > dis);
    notes.removeWhere((item) => item.availableLots < avail);
    finishLoading = true;
    _notes3 = notes;
  }

  @override
  Widget build(BuildContext context){
    final Data data4 = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Maximum Distance(km)",
                      style: headingTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top : 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          _lowerValDist.toString(),
                        ),
                        Expanded(
                          flex: 2,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                              valueIndicatorColor: Colors.blueAccent,
                              valueIndicatorTextStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            child: Slider(
                                min: _lowerValDist,//_lowerValDist,
                                max: _upperValDist,//_upperValDist,
                                value: _distance,
                                divisions: 100,
                                label: _distance.toStringAsFixed(2),
                                onChanged: (val) {
                                  setState(() {
                                    _distance = val;
                                    print(getDistance());
                                  });
                                }
                            ),
                          ),
                        ),

                        Text(
                          _upperValDist.toString(),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Minimum Gantry Height(\m)",
                      style: headingTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          _lowerValPrice.toString(),
                        ),
                        Expanded(
                            flex: 2,
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                                valueIndicatorColor: Colors.blueAccent,
                                valueIndicatorTextStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              child: Slider(
                                  min:_lowerValPrice,// _lowerValPrice,
                                  max: _upperValPrice,// _upperValPrice,
                                  divisions: 100,
                                  value: height,
                                  label: height.toStringAsFixed(2),
                                  onChanged: (val) {
                                    setState(() {
                                      height= val;
                                      print(getPrice());
                                    });
                                  }
                              ),

                            )
                        ),
                        Text(
                          _upperValPrice.toString(),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Minimum Availability(\%)",
                      style: headingTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 12.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          _lowerValAvail.toString() + '%',
                        ),
                        Expanded(
                          flex: 2,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                              valueIndicatorColor: Colors.blueAccent,
                              valueIndicatorTextStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            child: Slider(
                                min:_lowerValAvail,//_lowerValAvail,
                                max: _upperValAvail,// _upperValAvail,
                                value: avail,
                                label: avail.toStringAsFixed(2),
                                divisions: 100,
                                onChanged: (val) {
                                  setState(() {
                                    avail= val;
                                    print(getAvail());
                                  });
                                }
                            ),
                          ),
                        ),
                        Text(
                          _upperValAvail.toString() + '%',
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: Text("Apply"),
                    color: Color(0xFF4B9DFE),
                    textColor: Colors.white,
                    padding: EdgeInsets.only(
                        left: 38, right: 38, top: 15, bottom: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: ()async {
                      _onClick();
                      while (true) {

                          filterResult(data4.carparkList, _distance, height, avail);
                          Navigator.pop(context, _notes3);

                        await new Future.delayed(const Duration(seconds: 1));
                      }
                    },
                  ),
                  FlatButton(
                    child: Text("Cancel"),
                    color: Color(0xFF696969),
                    textColor: Colors.white,
                    padding: EdgeInsets.only(
                        left: 38, right: 38, top: 15, bottom: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  )

                ]
            )
          ],
        ),
      ),
    );
  }

  double getDistance(){
    return _distance;
  }
  double getPrice(){
    return height;
  }
  double getAvail(){
    return avail;
  }
}




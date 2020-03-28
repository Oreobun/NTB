import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SliderContainer extends StatefulWidget{
  @override
  _SliderContainerState createState() => _SliderContainerState();
}

class _SliderContainerState extends State<SliderContainer>{
  static double _lowerValDist = 0.0; //Change these values for the starting and end points
  static double _upperValDist = 10.0;
  double _distance = 5;
  static double _lowerValPrice = 0.0;
  static double _upperValPrice = 10.0;
  double price = 5;
  static double _lowerValAvail= 0.0;
  static double _upperValAvail= 100.0;
  double avail = 50;

  final headingTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w800,
    fontFamily: 'Roboto',
    letterSpacing: 0.5,
    fontSize: 20,
  );


  @override
  Widget build(BuildContext context){
    return Column(
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
                            min: 0.0,//_lowerValDist,
                            max: 10.0,//_upperValDist,
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
                  "Maximum Price(\$)",
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
                              min:0.0,// _lowerValPrice,
                              max: 10.0,// _upperValPrice,
                              divisions: 100,
                              value: price,
                              label: price.toStringAsFixed(2),
                              onChanged: (val) {
                                setState(() {
                                  price= val;
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
                  "Maximum Availability(\%)",
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
                            min: 0.0,//_lowerValAvail,
                            max: 100.0,// _upperValAvail,
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
                onPressed: (){},
              ),
              FlatButton(
                child: Text("Cancel"),
                color: Color(0xFF696969),
                textColor: Colors.white,
                padding: EdgeInsets.only(
                    left: 38, right: 38, top: 15, bottom: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: (){},
              )

            ]
        )
      ],
    );
  }

  double getDistance(){
    return _distance;
  }
  double getPrice(){
    return price;
  }
  double getAvail(){
    return avail;
  }
}



